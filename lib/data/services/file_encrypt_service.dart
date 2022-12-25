import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart' as found;
import 'package:turbo_crypt/core/models/encrypt_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:encrypt/encrypt.dart';
import 'package:turbo_crypt/core/models/utils/bytes_utils.dart';

enum CryptAction {
  encrypt,
  decrypt,
}

final fileEcnryptServiceProvider = Provider<FileEcnryptService>((ref) {
  throw UnimplementedError();
});

const blockSize = 16;

Future<void> encryptProccessing(SendPort sendPort) async {
  final receivePort = ReceivePort();

  final key = Key.fromBase64(
    'oXPsnF6Ap8+Dwixjm4WC/0TZP4YgOyLmZuK7eyXdymg=',
  );
  final iv = IV.fromBase64('keB8uZ0d6YHtnnqEXzAdfw==');

  final crypt = Encrypter(AES(key, mode: AESMode.cbc, padding: null));

  sendPort.send(receivePort.sendPort);

  await for (final msg in receivePort) {
    final data = msg['data'] as Map<String, dynamic>;
    final fromPath = data['from_path'];
    final toPath = data['to_path'];
    final action = data['action'] as CryptAction;
    final replyTo = msg['port'] as SendPort;

    final source = File(fromPath);
    final target = File(toPath);
    final writer = target.openWrite();

    final totalSize = await source.length();
    var progresSize = 0;

    source.openRead().listen(
      (event) {
        progresSize += event.length;
        final progressPercent = progresSize * 100 / totalSize;

        switch (action) {
          case CryptAction.encrypt:
            if (event.length % blockSize == 0) {
              writer.add(
                crypt.encryptBytes(event, iv: iv).bytes,
              );
            } else {
              writer.add(
                crypt
                    .encryptBytes(
                      BytesUtils.addPadding(bytes: event, blockSize: blockSize),
                      iv: iv,
                    )
                    .bytes,
              );
            }
            break;
          case CryptAction.decrypt:
            if (event.length % blockSize == 0) {
              writer.add(
                crypt.decryptBytes(
                  Encrypted(
                    found.Uint8List.fromList(event),
                  ),
                  iv: iv,
                ),
              );
            } else {
              writer.add(
                crypt.decryptBytes(
                  Encrypted(
                    found.Uint8List.fromList(
                      BytesUtils.addPadding(bytes: event, blockSize: blockSize),
                    ),
                  ),
                  iv: iv,
                ),
              );
            }

            break;
        }

        replyTo.send(
          EncryptState(
            status: EncryptStatus.encrypting,
            progress: progressPercent,
          ),
        );
      },
      onError: (err) {
        writer.close();

        throw err;
      },
      onDone: () {
        writer.close();

        replyTo.send(
          const EncryptState(
            status: EncryptStatus.encrypted,
          ),
        );
      },
    );
  }
}

class FileEcnryptService {
  SendPort? _sendPort;
  ReceivePort? _errorPort;
  ReceivePort? _closePort;
  ReceivePort? _responsePort;

  StreamSubscription? _errorSub;
  StreamSubscription? _responseSub;
  StreamSubscription? _closeSub;

  Isolate? _isolate;
  StreamController<EncryptState>? _stream;
  static FileEcnryptService? _instance;

  static Future<FileEcnryptService> getInstance() async {
    if (_instance == null) {
      _instance = FileEcnryptService();
      await _instance?._makeIsolate();
    }

    return _instance!;
  }

  Future<Stream<EncryptState>> run({
    required String fromPath,
    required String toPath,
    required CryptAction action,
  }) async {
    if (_isolate == null) {
      await _makeIsolate();
    }

    return _sendReceive(
      fromPath: fromPath,
      toPath: toPath,
      action: action,
    );
  }

  Future<void> _makeIsolate() async {
    final receivePort = ReceivePort();
    _errorPort = ReceivePort();
    _closePort = ReceivePort();
    _responsePort = ReceivePort();
    _stream = StreamController<EncryptState>.broadcast();

    _isolate = await Isolate.spawn(
      encryptProccessing,
      receivePort.sendPort,
      onError: _errorPort!.sendPort,
      onExit: _closePort!.sendPort,
      debugName: 'FileEcnryptService',
    );

    _errorSub = _errorPort?.listen((message) {
      _stream?.add(
        EncryptState(
          status: EncryptStatus.error,
          error: message,
        ),
      );
    });

    _responseSub = _responsePort?.listen((message) {
      _stream?.add(message);
    });

    _closeSub = _closePort?.listen((message) {
      _isolate = null;
      _errorSub?.cancel();
      _responseSub?.cancel();
      _stream?.close();
      _closeSub?.cancel();
    });

    _sendPort = await receivePort.first as SendPort;
    receivePort.close();
  }

  Stream<EncryptState> _sendReceive({
    required String fromPath,
    required String toPath,
    required CryptAction action,
  }) {
    _sendPort?.send(
      {
        'data': {
          'from_path': fromPath,
          'to_path': toPath,
          'action': action,
        },
        'port': _responsePort!.sendPort,
      },
    );

    return _stream!.stream;
  }
}

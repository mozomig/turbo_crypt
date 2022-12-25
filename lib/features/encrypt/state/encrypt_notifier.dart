import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';
import 'package:turbo_crypt/core/models/encrypt_state.dart';
import 'package:turbo_crypt/data/repositories/aes_encrypt_repository.dart';
import 'package:turbo_crypt/data/repositories/file_encrypt_repository.dart';

final encryptNotifierProvider =
    StateNotifierProvider<EncryptNotifier, EncryptState>((ref) {
  return EncryptNotifier(
    fileEncryptRepository: ref.watch(
      aesEncryptRepositoryProvider,
    ),
  );
});

class EncryptNotifier extends StateNotifier<EncryptState> {
  final FileEncryptRepository _fileEncryptRepository;
  StreamSubscription? _stateSub;

  EncryptNotifier({
    required FileEncryptRepository fileEncryptRepository,
  })  : _fileEncryptRepository = fileEncryptRepository,
        super(
          const EncryptState(
            status: EncryptStatus.none,
            progress: 0,
          ),
        );

  void encrypt({
    required String fromPath,
  }) async {
    _stateSub?.cancel();
    _stateSub = (await _fileEncryptRepository.encrypt(
      fromPath: fromPath,
      toPath:
          '${dirname(fromPath)}/${basenameWithoutExtension(fromPath)}.encrypted',
    ))
        .listen((event) {
      state = event;
    });
  }

  void decrypt({
    required String fromPath,
  }) async {
    _stateSub?.cancel();
    _stateSub = (await _fileEncryptRepository.decrypt(
      fromPath: fromPath,
      toPath: '${dirname(fromPath)}/${basenameWithoutExtension(fromPath)}.decrypt',
    ))
        .listen((event) {
      state = event;
    });
  }

  @override
  void dispose() {
    _stateSub?.cancel();
    super.dispose();
  }
}

import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:turbo_crypt/core/models/encrypt_state.dart';
import 'package:turbo_crypt/features/encrypt/state/encrypt_notifier.dart';

class EncryptPage extends HookConsumerWidget {
  const EncryptPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(encryptNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Turbo Ecnrypt'),
      ),
      body: Stack(
        children: [
          if (state.status == EncryptStatus.encrypted)
            const Align(
              alignment: Alignment.topCenter,
              child: Text('Success!'),
            ),
          if (state.status == EncryptStatus.error)
            Align(
              alignment: Alignment.topCenter,
              child: Text(state.error.toString()),
            ),
          if (state.status != EncryptStatus.encrypting)
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      final path = await chooseFile(
                        context: context,
                      );
                      if (path != null) {
                        ref
                            .read(encryptNotifierProvider.notifier)
                            .encrypt(fromPath: path);
                      }
                    },
                    icon: const Icon(Icons.file_open),
                    label: const Text(
                      'Encrypt File',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final path = await chooseFile(
                        context: context,
                      );
                      if (path != null) {
                        ref
                            .read(encryptNotifierProvider.notifier)
                            .decrypt(fromPath: path);
                      }
                    },
                    icon: const Icon(Icons.security_rounded),
                    label: const Text(
                      'Decrypt File',
                    ),
                  ),
                ],
              ),
            ),
          if (state.status == EncryptStatus.encrypting)
            const Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 90,
                width: 90,
                child: CircularProgressIndicator(),
              ),
            ),
          if (state.status == EncryptStatus.encrypting)
            Align(
              alignment: Alignment.center,
              child: Text(
                '${state.progress.round()} %',
              ),
            ),
        ],
      ),
    );
  }

  Future<String?> chooseFile({
    required BuildContext context,
  }) async {
    await Permission.manageExternalStorage.request();
    await Permission.storage.request();
    //todo: add permission handler

    final path = await ExternalPath.getExternalStorageDirectories();
    final result = await FilesystemPicker.open(
      contextActions: [
        FilesystemPickerNewFolderContextAction(),
      ],
      context: context,
      fsType: FilesystemType.file,
      rootDirectory: Directory(path.first),
    );

    return result;
  }
}

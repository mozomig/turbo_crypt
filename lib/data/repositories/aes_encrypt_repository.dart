// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:turbo_crypt/core/models/encrypt_state.dart';
import 'package:turbo_crypt/data/repositories/file_encrypt_repository.dart';
import 'package:turbo_crypt/data/services/file_encrypt_service.dart';

final aesEncryptRepositoryProvider = Provider<AESEncryptRepository>((ref) {
  return AESEncryptRepository(
    fileEcnryptService: ref.watch(fileEcnryptServiceProvider),
  );
});

class AESEncryptRepository implements FileEncryptRepository {
  final FileEcnryptService _fileEcnryptService;

  AESEncryptRepository({
    required FileEcnryptService fileEcnryptService,
  }) : _fileEcnryptService = fileEcnryptService;

  @override
  Future<Stream<EncryptState>> encrypt({
    required String fromPath,
    required String toPath,
  }) {
    return _fileEcnryptService.run(
      fromPath: fromPath,
      toPath: toPath,
      action: CryptAction.encrypt,
    );
  }

  @override
  Future<Stream<EncryptState>> decrypt({
    required String fromPath,
    required String toPath,
  }) {
    return _fileEcnryptService.run(
      fromPath: fromPath,
      toPath: toPath,
      action: CryptAction.decrypt,
    );
  }
}

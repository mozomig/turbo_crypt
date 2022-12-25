import 'package:turbo_crypt/core/models/encrypt_state.dart';

abstract class FileEncryptRepository {
  Future<Stream<EncryptState>> encrypt({
    required String fromPath,
    required String toPath,
  });

  Future<Stream<EncryptState>> decrypt({
    required String fromPath,
    required String toPath,
  });
}

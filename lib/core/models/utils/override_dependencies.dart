import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:turbo_crypt/data/services/file_encrypt_service.dart';

Future<List<Override>> getOverridesDependecy() async {
  final fileEcnryptService = await FileEcnryptService.getInstance();
  return [
    fileEcnryptServiceProvider.overrideWithValue(fileEcnryptService),
  ];
}

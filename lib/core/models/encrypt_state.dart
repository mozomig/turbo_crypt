import 'package:freezed_annotation/freezed_annotation.dart';

part 'encrypt_state.freezed.dart';

enum EncryptStatus {
  none,
  encrypting,
  error,
  encrypted,
}

@freezed
class EncryptState with _$EncryptState {
  const factory EncryptState({
    required EncryptStatus status,
    @Default(0.0) double progress,
    dynamic error,
  }) = _EncryptState;
}

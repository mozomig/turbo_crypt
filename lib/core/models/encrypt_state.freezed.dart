// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'encrypt_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$EncryptState {
  EncryptStatus get status => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;
  dynamic get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EncryptStateCopyWith<EncryptState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EncryptStateCopyWith<$Res> {
  factory $EncryptStateCopyWith(
          EncryptState value, $Res Function(EncryptState) then) =
      _$EncryptStateCopyWithImpl<$Res, EncryptState>;
  @useResult
  $Res call({EncryptStatus status, double progress, dynamic error});
}

/// @nodoc
class _$EncryptStateCopyWithImpl<$Res, $Val extends EncryptState>
    implements $EncryptStateCopyWith<$Res> {
  _$EncryptStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? progress = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EncryptStatus,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EncryptStateCopyWith<$Res>
    implements $EncryptStateCopyWith<$Res> {
  factory _$$_EncryptStateCopyWith(
          _$_EncryptState value, $Res Function(_$_EncryptState) then) =
      __$$_EncryptStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({EncryptStatus status, double progress, dynamic error});
}

/// @nodoc
class __$$_EncryptStateCopyWithImpl<$Res>
    extends _$EncryptStateCopyWithImpl<$Res, _$_EncryptState>
    implements _$$_EncryptStateCopyWith<$Res> {
  __$$_EncryptStateCopyWithImpl(
      _$_EncryptState _value, $Res Function(_$_EncryptState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? progress = null,
    Object? error = freezed,
  }) {
    return _then(_$_EncryptState(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EncryptStatus,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$_EncryptState implements _EncryptState {
  const _$_EncryptState(
      {required this.status, this.progress = 0.0, this.error});

  @override
  final EncryptStatus status;
  @override
  @JsonKey()
  final double progress;
  @override
  final dynamic error;

  @override
  String toString() {
    return 'EncryptState(status: $status, progress: $progress, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EncryptState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, progress,
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EncryptStateCopyWith<_$_EncryptState> get copyWith =>
      __$$_EncryptStateCopyWithImpl<_$_EncryptState>(this, _$identity);
}

abstract class _EncryptState implements EncryptState {
  const factory _EncryptState(
      {required final EncryptStatus status,
      final double progress,
      final dynamic error}) = _$_EncryptState;

  @override
  EncryptStatus get status;
  @override
  double get progress;
  @override
  dynamic get error;
  @override
  @JsonKey(ignore: true)
  _$$_EncryptStateCopyWith<_$_EncryptState> get copyWith =>
      throw _privateConstructorUsedError;
}

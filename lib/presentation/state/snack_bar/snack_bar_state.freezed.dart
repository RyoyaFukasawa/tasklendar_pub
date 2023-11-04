// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'snack_bar_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SnackBarState {
  bool get isShown => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  SnackBarType get type => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SnackBarStateCopyWith<SnackBarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SnackBarStateCopyWith<$Res> {
  factory $SnackBarStateCopyWith(
          SnackBarState value, $Res Function(SnackBarState) then) =
      _$SnackBarStateCopyWithImpl<$Res, SnackBarState>;
  @useResult
  $Res call({bool isShown, String message, SnackBarType type});
}

/// @nodoc
class _$SnackBarStateCopyWithImpl<$Res, $Val extends SnackBarState>
    implements $SnackBarStateCopyWith<$Res> {
  _$SnackBarStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isShown = null,
    Object? message = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      isShown: null == isShown
          ? _value.isShown
          : isShown // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SnackBarType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SnackBarStateCopyWith<$Res>
    implements $SnackBarStateCopyWith<$Res> {
  factory _$$_SnackBarStateCopyWith(
          _$_SnackBarState value, $Res Function(_$_SnackBarState) then) =
      __$$_SnackBarStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isShown, String message, SnackBarType type});
}

/// @nodoc
class __$$_SnackBarStateCopyWithImpl<$Res>
    extends _$SnackBarStateCopyWithImpl<$Res, _$_SnackBarState>
    implements _$$_SnackBarStateCopyWith<$Res> {
  __$$_SnackBarStateCopyWithImpl(
      _$_SnackBarState _value, $Res Function(_$_SnackBarState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isShown = null,
    Object? message = null,
    Object? type = null,
  }) {
    return _then(_$_SnackBarState(
      isShown: null == isShown
          ? _value.isShown
          : isShown // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SnackBarType,
    ));
  }
}

/// @nodoc

class _$_SnackBarState implements _SnackBarState {
  const _$_SnackBarState(
      {required this.isShown, required this.message, required this.type});

  @override
  final bool isShown;
  @override
  final String message;
  @override
  final SnackBarType type;

  @override
  String toString() {
    return 'SnackBarState(isShown: $isShown, message: $message, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SnackBarState &&
            (identical(other.isShown, isShown) || other.isShown == isShown) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isShown, message, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SnackBarStateCopyWith<_$_SnackBarState> get copyWith =>
      __$$_SnackBarStateCopyWithImpl<_$_SnackBarState>(this, _$identity);
}

abstract class _SnackBarState implements SnackBarState {
  const factory _SnackBarState(
      {required final bool isShown,
      required final String message,
      required final SnackBarType type}) = _$_SnackBarState;

  @override
  bool get isShown;
  @override
  String get message;
  @override
  SnackBarType get type;
  @override
  @JsonKey(ignore: true)
  _$$_SnackBarStateCopyWith<_$_SnackBarState> get copyWith =>
      throw _privateConstructorUsedError;
}

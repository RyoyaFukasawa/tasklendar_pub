// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_email_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChangeEmailState {
  GlobalKey<FormState> get formKey => throw _privateConstructorUsedError;
  String get newEmail => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChangeEmailStateCopyWith<ChangeEmailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangeEmailStateCopyWith<$Res> {
  factory $ChangeEmailStateCopyWith(
          ChangeEmailState value, $Res Function(ChangeEmailState) then) =
      _$ChangeEmailStateCopyWithImpl<$Res, ChangeEmailState>;
  @useResult
  $Res call({GlobalKey<FormState> formKey, String newEmail, String password});
}

/// @nodoc
class _$ChangeEmailStateCopyWithImpl<$Res, $Val extends ChangeEmailState>
    implements $ChangeEmailStateCopyWith<$Res> {
  _$ChangeEmailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? formKey = null,
    Object? newEmail = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      formKey: null == formKey
          ? _value.formKey
          : formKey // ignore: cast_nullable_to_non_nullable
              as GlobalKey<FormState>,
      newEmail: null == newEmail
          ? _value.newEmail
          : newEmail // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChangeEmailStateCopyWith<$Res>
    implements $ChangeEmailStateCopyWith<$Res> {
  factory _$$_ChangeEmailStateCopyWith(
          _$_ChangeEmailState value, $Res Function(_$_ChangeEmailState) then) =
      __$$_ChangeEmailStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({GlobalKey<FormState> formKey, String newEmail, String password});
}

/// @nodoc
class __$$_ChangeEmailStateCopyWithImpl<$Res>
    extends _$ChangeEmailStateCopyWithImpl<$Res, _$_ChangeEmailState>
    implements _$$_ChangeEmailStateCopyWith<$Res> {
  __$$_ChangeEmailStateCopyWithImpl(
      _$_ChangeEmailState _value, $Res Function(_$_ChangeEmailState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? formKey = null,
    Object? newEmail = null,
    Object? password = null,
  }) {
    return _then(_$_ChangeEmailState(
      formKey: null == formKey
          ? _value.formKey
          : formKey // ignore: cast_nullable_to_non_nullable
              as GlobalKey<FormState>,
      newEmail: null == newEmail
          ? _value.newEmail
          : newEmail // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ChangeEmailState implements _ChangeEmailState {
  const _$_ChangeEmailState(
      {required this.formKey, required this.newEmail, required this.password});

  @override
  final GlobalKey<FormState> formKey;
  @override
  final String newEmail;
  @override
  final String password;

  @override
  String toString() {
    return 'ChangeEmailState(formKey: $formKey, newEmail: $newEmail, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChangeEmailState &&
            (identical(other.formKey, formKey) || other.formKey == formKey) &&
            (identical(other.newEmail, newEmail) ||
                other.newEmail == newEmail) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, formKey, newEmail, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChangeEmailStateCopyWith<_$_ChangeEmailState> get copyWith =>
      __$$_ChangeEmailStateCopyWithImpl<_$_ChangeEmailState>(this, _$identity);
}

abstract class _ChangeEmailState implements ChangeEmailState {
  const factory _ChangeEmailState(
      {required final GlobalKey<FormState> formKey,
      required final String newEmail,
      required final String password}) = _$_ChangeEmailState;

  @override
  GlobalKey<FormState> get formKey;
  @override
  String get newEmail;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$_ChangeEmailStateCopyWith<_$_ChangeEmailState> get copyWith =>
      throw _privateConstructorUsedError;
}

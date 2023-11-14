// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_account_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$DeleteAccountPageState {
  AuthCredential? get credential => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  bool get isAuth => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DeleteAccountPageStateCopyWith<DeleteAccountPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteAccountPageStateCopyWith<$Res> {
  factory $DeleteAccountPageStateCopyWith(DeleteAccountPageState value,
          $Res Function(DeleteAccountPageState) then) =
      _$DeleteAccountPageStateCopyWithImpl<$Res, DeleteAccountPageState>;
  @useResult
  $Res call(
      {AuthCredential? credential, bool isLoading, String? error, bool isAuth});
}

/// @nodoc
class _$DeleteAccountPageStateCopyWithImpl<$Res,
        $Val extends DeleteAccountPageState>
    implements $DeleteAccountPageStateCopyWith<$Res> {
  _$DeleteAccountPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? credential = freezed,
    Object? isLoading = null,
    Object? error = freezed,
    Object? isAuth = null,
  }) {
    return _then(_value.copyWith(
      credential: freezed == credential
          ? _value.credential
          : credential // ignore: cast_nullable_to_non_nullable
              as AuthCredential?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      isAuth: null == isAuth
          ? _value.isAuth
          : isAuth // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DeleteAccountPageStateCopyWith<$Res>
    implements $DeleteAccountPageStateCopyWith<$Res> {
  factory _$$_DeleteAccountPageStateCopyWith(_$_DeleteAccountPageState value,
          $Res Function(_$_DeleteAccountPageState) then) =
      __$$_DeleteAccountPageStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AuthCredential? credential, bool isLoading, String? error, bool isAuth});
}

/// @nodoc
class __$$_DeleteAccountPageStateCopyWithImpl<$Res>
    extends _$DeleteAccountPageStateCopyWithImpl<$Res,
        _$_DeleteAccountPageState>
    implements _$$_DeleteAccountPageStateCopyWith<$Res> {
  __$$_DeleteAccountPageStateCopyWithImpl(_$_DeleteAccountPageState _value,
      $Res Function(_$_DeleteAccountPageState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? credential = freezed,
    Object? isLoading = null,
    Object? error = freezed,
    Object? isAuth = null,
  }) {
    return _then(_$_DeleteAccountPageState(
      credential: freezed == credential
          ? _value.credential
          : credential // ignore: cast_nullable_to_non_nullable
              as AuthCredential?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      isAuth: null == isAuth
          ? _value.isAuth
          : isAuth // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_DeleteAccountPageState implements _DeleteAccountPageState {
  const _$_DeleteAccountPageState(
      {this.credential,
      required this.isLoading,
      this.error,
      required this.isAuth});

  @override
  final AuthCredential? credential;
  @override
  final bool isLoading;
  @override
  final String? error;
  @override
  final bool isAuth;

  @override
  String toString() {
    return 'DeleteAccountPageState(credential: $credential, isLoading: $isLoading, error: $error, isAuth: $isAuth)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DeleteAccountPageState &&
            (identical(other.credential, credential) ||
                other.credential == credential) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.isAuth, isAuth) || other.isAuth == isAuth));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, credential, isLoading, error, isAuth);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeleteAccountPageStateCopyWith<_$_DeleteAccountPageState> get copyWith =>
      __$$_DeleteAccountPageStateCopyWithImpl<_$_DeleteAccountPageState>(
          this, _$identity);
}

abstract class _DeleteAccountPageState implements DeleteAccountPageState {
  const factory _DeleteAccountPageState(
      {final AuthCredential? credential,
      required final bool isLoading,
      final String? error,
      required final bool isAuth}) = _$_DeleteAccountPageState;

  @override
  AuthCredential? get credential;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  bool get isAuth;
  @override
  @JsonKey(ignore: true)
  _$$_DeleteAccountPageStateCopyWith<_$_DeleteAccountPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

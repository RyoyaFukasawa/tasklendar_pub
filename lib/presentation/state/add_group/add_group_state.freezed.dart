// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_group_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddGroupState {
  String get name => throw _privateConstructorUsedError;
  String get emoji => throw _privateConstructorUsedError;
  Color get color => throw _privateConstructorUsedError;
  GlobalKey<FormState> get formKey => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddGroupStateCopyWith<AddGroupState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddGroupStateCopyWith<$Res> {
  factory $AddGroupStateCopyWith(
          AddGroupState value, $Res Function(AddGroupState) then) =
      _$AddGroupStateCopyWithImpl<$Res, AddGroupState>;
  @useResult
  $Res call(
      {String name, String emoji, Color color, GlobalKey<FormState> formKey});
}

/// @nodoc
class _$AddGroupStateCopyWithImpl<$Res, $Val extends AddGroupState>
    implements $AddGroupStateCopyWith<$Res> {
  _$AddGroupStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? emoji = null,
    Object? color = null,
    Object? formKey = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      emoji: null == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      formKey: null == formKey
          ? _value.formKey
          : formKey // ignore: cast_nullable_to_non_nullable
              as GlobalKey<FormState>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddGroupStateCopyWith<$Res>
    implements $AddGroupStateCopyWith<$Res> {
  factory _$$_AddGroupStateCopyWith(
          _$_AddGroupState value, $Res Function(_$_AddGroupState) then) =
      __$$_AddGroupStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String emoji, Color color, GlobalKey<FormState> formKey});
}

/// @nodoc
class __$$_AddGroupStateCopyWithImpl<$Res>
    extends _$AddGroupStateCopyWithImpl<$Res, _$_AddGroupState>
    implements _$$_AddGroupStateCopyWith<$Res> {
  __$$_AddGroupStateCopyWithImpl(
      _$_AddGroupState _value, $Res Function(_$_AddGroupState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? emoji = null,
    Object? color = null,
    Object? formKey = null,
  }) {
    return _then(_$_AddGroupState(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      emoji: null == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
      formKey: null == formKey
          ? _value.formKey
          : formKey // ignore: cast_nullable_to_non_nullable
              as GlobalKey<FormState>,
    ));
  }
}

/// @nodoc

class _$_AddGroupState implements _AddGroupState {
  const _$_AddGroupState(
      {required this.name,
      required this.emoji,
      required this.color,
      required this.formKey});

  @override
  final String name;
  @override
  final String emoji;
  @override
  final Color color;
  @override
  final GlobalKey<FormState> formKey;

  @override
  String toString() {
    return 'AddGroupState(name: $name, emoji: $emoji, color: $color, formKey: $formKey)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddGroupState &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.formKey, formKey) || other.formKey == formKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, emoji, color, formKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddGroupStateCopyWith<_$_AddGroupState> get copyWith =>
      __$$_AddGroupStateCopyWithImpl<_$_AddGroupState>(this, _$identity);
}

abstract class _AddGroupState implements AddGroupState {
  const factory _AddGroupState(
      {required final String name,
      required final String emoji,
      required final Color color,
      required final GlobalKey<FormState> formKey}) = _$_AddGroupState;

  @override
  String get name;
  @override
  String get emoji;
  @override
  Color get color;
  @override
  GlobalKey<FormState> get formKey;
  @override
  @JsonKey(ignore: true)
  _$$_AddGroupStateCopyWith<_$_AddGroupState> get copyWith =>
      throw _privateConstructorUsedError;
}

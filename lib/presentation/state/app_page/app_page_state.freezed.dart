// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppPageState {
  String get appBarTitle => throw _privateConstructorUsedError;
  Color? get titleColor => throw _privateConstructorUsedError;
  BuildContext? get context => throw _privateConstructorUsedError;
  String? get groupId =>
      throw _privateConstructorUsedError; // customFloatingで使う
  dynamic Function()? get onTitlePressed => throw _privateConstructorUsedError;
  DateTime? get selectedDate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppPageStateCopyWith<AppPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppPageStateCopyWith<$Res> {
  factory $AppPageStateCopyWith(
          AppPageState value, $Res Function(AppPageState) then) =
      _$AppPageStateCopyWithImpl<$Res, AppPageState>;
  @useResult
  $Res call(
      {String appBarTitle,
      Color? titleColor,
      BuildContext? context,
      String? groupId,
      dynamic Function()? onTitlePressed,
      DateTime? selectedDate});
}

/// @nodoc
class _$AppPageStateCopyWithImpl<$Res, $Val extends AppPageState>
    implements $AppPageStateCopyWith<$Res> {
  _$AppPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appBarTitle = null,
    Object? titleColor = freezed,
    Object? context = freezed,
    Object? groupId = freezed,
    Object? onTitlePressed = freezed,
    Object? selectedDate = freezed,
  }) {
    return _then(_value.copyWith(
      appBarTitle: null == appBarTitle
          ? _value.appBarTitle
          : appBarTitle // ignore: cast_nullable_to_non_nullable
              as String,
      titleColor: freezed == titleColor
          ? _value.titleColor
          : titleColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      onTitlePressed: freezed == onTitlePressed
          ? _value.onTitlePressed
          : onTitlePressed // ignore: cast_nullable_to_non_nullable
              as dynamic Function()?,
      selectedDate: freezed == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppPageStateCopyWith<$Res>
    implements $AppPageStateCopyWith<$Res> {
  factory _$$_AppPageStateCopyWith(
          _$_AppPageState value, $Res Function(_$_AppPageState) then) =
      __$$_AppPageStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String appBarTitle,
      Color? titleColor,
      BuildContext? context,
      String? groupId,
      dynamic Function()? onTitlePressed,
      DateTime? selectedDate});
}

/// @nodoc
class __$$_AppPageStateCopyWithImpl<$Res>
    extends _$AppPageStateCopyWithImpl<$Res, _$_AppPageState>
    implements _$$_AppPageStateCopyWith<$Res> {
  __$$_AppPageStateCopyWithImpl(
      _$_AppPageState _value, $Res Function(_$_AppPageState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appBarTitle = null,
    Object? titleColor = freezed,
    Object? context = freezed,
    Object? groupId = freezed,
    Object? onTitlePressed = freezed,
    Object? selectedDate = freezed,
  }) {
    return _then(_$_AppPageState(
      appBarTitle: null == appBarTitle
          ? _value.appBarTitle
          : appBarTitle // ignore: cast_nullable_to_non_nullable
              as String,
      titleColor: freezed == titleColor
          ? _value.titleColor
          : titleColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as String?,
      onTitlePressed: freezed == onTitlePressed
          ? _value.onTitlePressed
          : onTitlePressed // ignore: cast_nullable_to_non_nullable
              as dynamic Function()?,
      selectedDate: freezed == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$_AppPageState implements _AppPageState {
  const _$_AppPageState(
      {required this.appBarTitle,
      this.titleColor,
      this.context,
      this.groupId,
      this.onTitlePressed,
      this.selectedDate});

  @override
  final String appBarTitle;
  @override
  final Color? titleColor;
  @override
  final BuildContext? context;
  @override
  final String? groupId;
// customFloatingで使う
  @override
  final dynamic Function()? onTitlePressed;
  @override
  final DateTime? selectedDate;

  @override
  String toString() {
    return 'AppPageState(appBarTitle: $appBarTitle, titleColor: $titleColor, context: $context, groupId: $groupId, onTitlePressed: $onTitlePressed, selectedDate: $selectedDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppPageState &&
            (identical(other.appBarTitle, appBarTitle) ||
                other.appBarTitle == appBarTitle) &&
            (identical(other.titleColor, titleColor) ||
                other.titleColor == titleColor) &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.onTitlePressed, onTitlePressed) ||
                other.onTitlePressed == onTitlePressed) &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, appBarTitle, titleColor, context,
      groupId, onTitlePressed, selectedDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppPageStateCopyWith<_$_AppPageState> get copyWith =>
      __$$_AppPageStateCopyWithImpl<_$_AppPageState>(this, _$identity);
}

abstract class _AppPageState implements AppPageState {
  const factory _AppPageState(
      {required final String appBarTitle,
      final Color? titleColor,
      final BuildContext? context,
      final String? groupId,
      final dynamic Function()? onTitlePressed,
      final DateTime? selectedDate}) = _$_AppPageState;

  @override
  String get appBarTitle;
  @override
  Color? get titleColor;
  @override
  BuildContext? get context;
  @override
  String? get groupId;
  @override // customFloatingで使う
  dynamic Function()? get onTitlePressed;
  @override
  DateTime? get selectedDate;
  @override
  @JsonKey(ignore: true)
  _$$_AppPageStateCopyWith<_$_AppPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

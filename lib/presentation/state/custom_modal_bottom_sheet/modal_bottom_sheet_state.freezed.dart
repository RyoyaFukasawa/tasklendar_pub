// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'modal_bottom_sheet_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ModalBottomSheetState {
  bool get isSave => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ModalBottomSheetStateCopyWith<ModalBottomSheetState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModalBottomSheetStateCopyWith<$Res> {
  factory $ModalBottomSheetStateCopyWith(ModalBottomSheetState value,
          $Res Function(ModalBottomSheetState) then) =
      _$ModalBottomSheetStateCopyWithImpl<$Res, ModalBottomSheetState>;
  @useResult
  $Res call({bool isSave});
}

/// @nodoc
class _$ModalBottomSheetStateCopyWithImpl<$Res,
        $Val extends ModalBottomSheetState>
    implements $ModalBottomSheetStateCopyWith<$Res> {
  _$ModalBottomSheetStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSave = null,
  }) {
    return _then(_value.copyWith(
      isSave: null == isSave
          ? _value.isSave
          : isSave // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ModalBottomSheetStateCopyWith<$Res>
    implements $ModalBottomSheetStateCopyWith<$Res> {
  factory _$$_ModalBottomSheetStateCopyWith(_$_ModalBottomSheetState value,
          $Res Function(_$_ModalBottomSheetState) then) =
      __$$_ModalBottomSheetStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isSave});
}

/// @nodoc
class __$$_ModalBottomSheetStateCopyWithImpl<$Res>
    extends _$ModalBottomSheetStateCopyWithImpl<$Res, _$_ModalBottomSheetState>
    implements _$$_ModalBottomSheetStateCopyWith<$Res> {
  __$$_ModalBottomSheetStateCopyWithImpl(_$_ModalBottomSheetState _value,
      $Res Function(_$_ModalBottomSheetState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSave = null,
  }) {
    return _then(_$_ModalBottomSheetState(
      isSave: null == isSave
          ? _value.isSave
          : isSave // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_ModalBottomSheetState implements _ModalBottomSheetState {
  const _$_ModalBottomSheetState({required this.isSave});

  @override
  final bool isSave;

  @override
  String toString() {
    return 'ModalBottomSheetState(isSave: $isSave)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ModalBottomSheetState &&
            (identical(other.isSave, isSave) || other.isSave == isSave));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isSave);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ModalBottomSheetStateCopyWith<_$_ModalBottomSheetState> get copyWith =>
      __$$_ModalBottomSheetStateCopyWithImpl<_$_ModalBottomSheetState>(
          this, _$identity);
}

abstract class _ModalBottomSheetState implements ModalBottomSheetState {
  const factory _ModalBottomSheetState({required final bool isSave}) =
      _$_ModalBottomSheetState;

  @override
  bool get isSave;
  @override
  @JsonKey(ignore: true)
  _$$_ModalBottomSheetStateCopyWith<_$_ModalBottomSheetState> get copyWith =>
      throw _privateConstructorUsedError;
}

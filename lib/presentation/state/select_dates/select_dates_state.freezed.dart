// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_dates_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SelectDatesState {
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SelectDatesStateCopyWith<SelectDatesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SelectDatesStateCopyWith<$Res> {
  factory $SelectDatesStateCopyWith(
          SelectDatesState value, $Res Function(SelectDatesState) then) =
      _$SelectDatesStateCopyWithImpl<$Res, SelectDatesState>;
  @useResult
  $Res call({DateTime? startDate, DateTime? endDate, int duration});
}

/// @nodoc
class _$SelectDatesStateCopyWithImpl<$Res, $Val extends SelectDatesState>
    implements $SelectDatesStateCopyWith<$Res> {
  _$SelectDatesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? duration = null,
  }) {
    return _then(_value.copyWith(
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SelectDatesStateCopyWith<$Res>
    implements $SelectDatesStateCopyWith<$Res> {
  factory _$$_SelectDatesStateCopyWith(
          _$_SelectDatesState value, $Res Function(_$_SelectDatesState) then) =
      __$$_SelectDatesStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime? startDate, DateTime? endDate, int duration});
}

/// @nodoc
class __$$_SelectDatesStateCopyWithImpl<$Res>
    extends _$SelectDatesStateCopyWithImpl<$Res, _$_SelectDatesState>
    implements _$$_SelectDatesStateCopyWith<$Res> {
  __$$_SelectDatesStateCopyWithImpl(
      _$_SelectDatesState _value, $Res Function(_$_SelectDatesState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? duration = null,
  }) {
    return _then(_$_SelectDatesState(
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_SelectDatesState implements _SelectDatesState {
  const _$_SelectDatesState(
      {required this.startDate, required this.endDate, required this.duration});

  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final int duration;

  @override
  String toString() {
    return 'SelectDatesState(startDate: $startDate, endDate: $endDate, duration: $duration)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SelectDatesState &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @override
  int get hashCode => Object.hash(runtimeType, startDate, endDate, duration);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SelectDatesStateCopyWith<_$_SelectDatesState> get copyWith =>
      __$$_SelectDatesStateCopyWithImpl<_$_SelectDatesState>(this, _$identity);
}

abstract class _SelectDatesState implements SelectDatesState {
  const factory _SelectDatesState(
      {required final DateTime? startDate,
      required final DateTime? endDate,
      required final int duration}) = _$_SelectDatesState;

  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  int get duration;
  @override
  @JsonKey(ignore: true)
  _$$_SelectDatesStateCopyWith<_$_SelectDatesState> get copyWith =>
      throw _privateConstructorUsedError;
}

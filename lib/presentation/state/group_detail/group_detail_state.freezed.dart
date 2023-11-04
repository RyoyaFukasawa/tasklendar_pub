// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GroupDetailState {
  List<TodoEntity?> get todos => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GroupDetailStateCopyWith<GroupDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupDetailStateCopyWith<$Res> {
  factory $GroupDetailStateCopyWith(
          GroupDetailState value, $Res Function(GroupDetailState) then) =
      _$GroupDetailStateCopyWithImpl<$Res, GroupDetailState>;
  @useResult
  $Res call({List<TodoEntity?> todos});
}

/// @nodoc
class _$GroupDetailStateCopyWithImpl<$Res, $Val extends GroupDetailState>
    implements $GroupDetailStateCopyWith<$Res> {
  _$GroupDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todos = null,
  }) {
    return _then(_value.copyWith(
      todos: null == todos
          ? _value.todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<TodoEntity?>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GroupDetailStateCopyWith<$Res>
    implements $GroupDetailStateCopyWith<$Res> {
  factory _$$_GroupDetailStateCopyWith(
          _$_GroupDetailState value, $Res Function(_$_GroupDetailState) then) =
      __$$_GroupDetailStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TodoEntity?> todos});
}

/// @nodoc
class __$$_GroupDetailStateCopyWithImpl<$Res>
    extends _$GroupDetailStateCopyWithImpl<$Res, _$_GroupDetailState>
    implements _$$_GroupDetailStateCopyWith<$Res> {
  __$$_GroupDetailStateCopyWithImpl(
      _$_GroupDetailState _value, $Res Function(_$_GroupDetailState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todos = null,
  }) {
    return _then(_$_GroupDetailState(
      todos: null == todos
          ? _value._todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<TodoEntity?>,
    ));
  }
}

/// @nodoc

class _$_GroupDetailState implements _GroupDetailState {
  const _$_GroupDetailState({required final List<TodoEntity?> todos})
      : _todos = todos;

  final List<TodoEntity?> _todos;
  @override
  List<TodoEntity?> get todos {
    if (_todos is EqualUnmodifiableListView) return _todos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todos);
  }

  @override
  String toString() {
    return 'GroupDetailState(todos: $todos)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GroupDetailState &&
            const DeepCollectionEquality().equals(other._todos, _todos));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_todos));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GroupDetailStateCopyWith<_$_GroupDetailState> get copyWith =>
      __$$_GroupDetailStateCopyWithImpl<_$_GroupDetailState>(this, _$identity);
}

abstract class _GroupDetailState implements GroupDetailState {
  const factory _GroupDetailState({required final List<TodoEntity?> todos}) =
      _$_GroupDetailState;

  @override
  List<TodoEntity?> get todos;
  @override
  @JsonKey(ignore: true)
  _$$_GroupDetailStateCopyWith<_$_GroupDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

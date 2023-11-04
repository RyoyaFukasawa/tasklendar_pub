// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TodoPageState {
  List<TodoEntity?> get todos => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TodoPageStateCopyWith<TodoPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoPageStateCopyWith<$Res> {
  factory $TodoPageStateCopyWith(
          TodoPageState value, $Res Function(TodoPageState) then) =
      _$TodoPageStateCopyWithImpl<$Res, TodoPageState>;
  @useResult
  $Res call({List<TodoEntity?> todos});
}

/// @nodoc
class _$TodoPageStateCopyWithImpl<$Res, $Val extends TodoPageState>
    implements $TodoPageStateCopyWith<$Res> {
  _$TodoPageStateCopyWithImpl(this._value, this._then);

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
abstract class _$$_TodoPageStateCopyWith<$Res>
    implements $TodoPageStateCopyWith<$Res> {
  factory _$$_TodoPageStateCopyWith(
          _$_TodoPageState value, $Res Function(_$_TodoPageState) then) =
      __$$_TodoPageStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TodoEntity?> todos});
}

/// @nodoc
class __$$_TodoPageStateCopyWithImpl<$Res>
    extends _$TodoPageStateCopyWithImpl<$Res, _$_TodoPageState>
    implements _$$_TodoPageStateCopyWith<$Res> {
  __$$_TodoPageStateCopyWithImpl(
      _$_TodoPageState _value, $Res Function(_$_TodoPageState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todos = null,
  }) {
    return _then(_$_TodoPageState(
      todos: null == todos
          ? _value._todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<TodoEntity?>,
    ));
  }
}

/// @nodoc

class _$_TodoPageState implements _TodoPageState {
  const _$_TodoPageState({required final List<TodoEntity?> todos})
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
    return 'TodoPageState(todos: $todos)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TodoPageState &&
            const DeepCollectionEquality().equals(other._todos, _todos));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_todos));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TodoPageStateCopyWith<_$_TodoPageState> get copyWith =>
      __$$_TodoPageStateCopyWithImpl<_$_TodoPageState>(this, _$identity);
}

abstract class _TodoPageState implements TodoPageState {
  const factory _TodoPageState({required final List<TodoEntity?> todos}) =
      _$_TodoPageState;

  @override
  List<TodoEntity?> get todos;
  @override
  @JsonKey(ignore: true)
  _$$_TodoPageStateCopyWith<_$_TodoPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

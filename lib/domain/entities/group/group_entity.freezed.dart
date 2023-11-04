// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GroupEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get emoji => throw _privateConstructorUsedError;
  Color get color => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  List<TodoEntity?> get todos => throw _privateConstructorUsedError;
  int? get order => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GroupEntityCopyWith<GroupEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupEntityCopyWith<$Res> {
  factory $GroupEntityCopyWith(
          GroupEntity value, $Res Function(GroupEntity) then) =
      _$GroupEntityCopyWithImpl<$Res, GroupEntity>;
  @useResult
  $Res call(
      {String id,
      String name,
      String emoji,
      Color color,
      DateTime createdAt,
      DateTime updatedAt,
      List<TodoEntity?> todos,
      int? order});
}

/// @nodoc
class _$GroupEntityCopyWithImpl<$Res, $Val extends GroupEntity>
    implements $GroupEntityCopyWith<$Res> {
  _$GroupEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? emoji = null,
    Object? color = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? todos = null,
    Object? order = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      todos: null == todos
          ? _value.todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<TodoEntity?>,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GroupEntityCopyWith<$Res>
    implements $GroupEntityCopyWith<$Res> {
  factory _$$_GroupEntityCopyWith(
          _$_GroupEntity value, $Res Function(_$_GroupEntity) then) =
      __$$_GroupEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String emoji,
      Color color,
      DateTime createdAt,
      DateTime updatedAt,
      List<TodoEntity?> todos,
      int? order});
}

/// @nodoc
class __$$_GroupEntityCopyWithImpl<$Res>
    extends _$GroupEntityCopyWithImpl<$Res, _$_GroupEntity>
    implements _$$_GroupEntityCopyWith<$Res> {
  __$$_GroupEntityCopyWithImpl(
      _$_GroupEntity _value, $Res Function(_$_GroupEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? emoji = null,
    Object? color = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? todos = null,
    Object? order = freezed,
  }) {
    return _then(_$_GroupEntity(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      todos: null == todos
          ? _value._todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<TodoEntity?>,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_GroupEntity implements _GroupEntity {
  const _$_GroupEntity(
      {required this.id,
      required this.name,
      required this.emoji,
      required this.color,
      required this.createdAt,
      required this.updatedAt,
      required final List<TodoEntity?> todos,
      this.order})
      : _todos = todos;

  @override
  final String id;
  @override
  final String name;
  @override
  final String emoji;
  @override
  final Color color;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  final List<TodoEntity?> _todos;
  @override
  List<TodoEntity?> get todos {
    if (_todos is EqualUnmodifiableListView) return _todos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todos);
  }

  @override
  final int? order;

  @override
  String toString() {
    return 'GroupEntity(id: $id, name: $name, emoji: $emoji, color: $color, createdAt: $createdAt, updatedAt: $updatedAt, todos: $todos, order: $order)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GroupEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._todos, _todos) &&
            (identical(other.order, order) || other.order == order));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, emoji, color,
      createdAt, updatedAt, const DeepCollectionEquality().hash(_todos), order);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GroupEntityCopyWith<_$_GroupEntity> get copyWith =>
      __$$_GroupEntityCopyWithImpl<_$_GroupEntity>(this, _$identity);
}

abstract class _GroupEntity implements GroupEntity {
  const factory _GroupEntity(
      {required final String id,
      required final String name,
      required final String emoji,
      required final Color color,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final List<TodoEntity?> todos,
      final int? order}) = _$_GroupEntity;

  @override
  String get id;
  @override
  String get name;
  @override
  String get emoji;
  @override
  Color get color;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  List<TodoEntity?> get todos;
  @override
  int? get order;
  @override
  @JsonKey(ignore: true)
  _$$_GroupEntityCopyWith<_$_GroupEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

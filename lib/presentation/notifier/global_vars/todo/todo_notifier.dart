// Package imports:
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/config/constraints/utils.dart';
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/core/enums/comparison_operator.dart';
import 'package:tasklendar/core/extension/date_time_extension.dart';
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';
import 'package:uuid/uuid.dart';

part 'todo_notifier.g.dart';

@Riverpod(keepAlive: true)
class TodoNotifier extends _$TodoNotifier {
  @override
  List<TodoEntity?> build() {
    return [
      for (var i = 0; i < 100; i++)
        TodoEntity(
          id: const Uuid().v4(),
          name: 'タスク$i',
          date: now.truncateTime(),
          duration: 1,
          color: AppColors.black,
          isDone: false,
          monthCellIndex: i,
          groupId: null,
          updatedAt: now,
          createdAt: now,
          times: 1,
          currentTimes: 0,
        ),
      // TodoEntity(
      //   id: const Uuid().v4(),
      //   name: 'タップしてタスクを完了✓',
      //   date: now.truncateTime(),
      //   duration: 1,
      //   color: AppColors.black,
      //   isDone: false,
      //   monthCellIndex: 0,
      //   groupId: null,
      //   updatedAt: now,
      //   createdAt: now,
      //   times: 1,
      //   currentTimes: 0,
      // ),
      // TodoEntity(
      //   id: const Uuid().v4(),
      //   name: '右スライドでタスクを編集',
      //   date: now.truncateTime(),
      //   duration: 1,
      //   color: AppColors.black,
      //   isDone: false,
      //   monthCellIndex: 1,
      //   groupId: null,
      //   updatedAt: now,
      //   createdAt: now,
      //   times: 1,
      //   currentTimes: 0,
      // ),
      // TodoEntity(
      //   id: const Uuid().v4(),
      //   name: '左スライドでタスクを削除',
      //   date: now.truncateTime(),
      //   duration: 1,
      //   color: AppColors.black,
      //   isDone: false,
      //   monthCellIndex: 2,
      //   groupId: null,
      //   updatedAt: now,
      //   createdAt: now,
      //   times: 1,
      //   currentTimes: 0,
      // ),
    ];
  }

  Future<void> add(TodoEntity todo) async {
    state = [...state, todo];
    sortTodosByDate();
  }

  Future<void> updateTodo(TodoEntity todo) async {
    todo = todo.copyWith(
      updatedAt: now,
    );
    final index = state.indexWhere((element) => element?.id == todo.id);
    state[index] = todo;

    state = [...state];
  }

  void removeTodo(TodoEntity todo) {
    state = state.where((element) => element?.id != todo.id).toList();
  }

  void clear() {
    state = [];
  }

  void removeTodoByProperty({
    required String property,
    required dynamic value,
    ComparisonOperator? operator,
  }) {
    state = state.where((element) {
      final propertyValue = _getPropertyValue(element, property);
      return !filterByComparisonOperator(
        operator,
        propertyValue,
        value,
      );
    }).toList();
  }

  List<TodoEntity?> getTodosByProperty({
    required String property,
    required dynamic value,
    ComparisonOperator? operator,
  }) {
    final filteredTodos = state.where((todo) {
      final propertyValue = _getPropertyValue(todo, property);
      return filterByComparisonOperator(
        operator,
        propertyValue,
        value,
      );
    }).toList();

    return filteredTodos;
  }

  List<TodoEntity?> getTodosByDate(DateTime date) {
    final filteredTodos = state.where((todo) {
      if (todo == null) return false;

      final startDate = todo.date;

      if (startDate == null) return false;

      final DateTime endDate = startDate.add(
        Duration(
          days: todo.duration - 1,
        ),
      );

      return date.isAfter(startDate) && date.isBefore(endDate) ||
          date == startDate ||
          date == endDate;
    }).toList();

    return filteredTodos;
  }

  bool filterByComparisonOperator(
    ComparisonOperator? operator,
    dynamic propertyValue,
    dynamic value,
  ) {
    switch (operator) {
      case ComparisonOperator.equal:
        return propertyValue == value;
      case ComparisonOperator.notEqual:
        return propertyValue != value;
      case ComparisonOperator.greaterThan:
        return propertyValue > value;
      case ComparisonOperator.greaterThanOrEqual:
        return propertyValue >= value;
      case ComparisonOperator.lessThan:
        return propertyValue < value;
      case ComparisonOperator.lessThanOrEqual:
        return propertyValue <= value;
      default:
        return propertyValue == value;
    }
  }

  dynamic _getPropertyValue(TodoEntity? todo, String property) {
    final propertyMap = {
      'id': todo?.id,
      'name': todo?.name,
      'date': todo?.date,
      'duration': todo?.duration,
      'color': todo?.color,
      'isDone': todo?.isDone,
      'monthCellIndex': todo?.monthCellIndex,
      'groupId': todo?.groupId,
      'updatedAt': todo?.updatedAt,
      'createdAt': todo?.createdAt,
    };

    if (!propertyMap.containsKey(property)) {
      throw ArgumentError('Unknown property: $property');
    }

    return propertyMap[property];
  }

  Future<void> sortTodosByDate() async {
    state.sort((a, b) {
      if (a!.date == null || b!.date == null) return 0;
      final dateComparison = a.date!.compareTo(b.date!);
      if (dateComparison == 0) {
        // a.dateとb.dateが同じ場合、createdAtで比較
        return a.createdAt.compareTo(b.createdAt);
      } else {
        return dateComparison;
      }
    });
  }

  Future<void> calculateMonthCellIndex() async {
    for (var todo in state) {
      if (todo!.date == null) continue;
      TodoEntity updatedTodo = todo.copyWith(
        monthCellIndex: 99,
      );

      await updateTodo(updatedTodo);
    }
    for (var todo in state) {
      if (todo!.date == null) continue;
      final todoStart = todo.date;
      final overlapDuration = <TodoEntity>[];

      for (var otherTodo in state) {
        if (otherTodo!.isDone) continue;
        if (otherTodo.date == null) continue;
        final otherTodoStart = otherTodo.date;
        final otherTodoEnd = otherTodo.date!.add(
          Duration(
            days: otherTodo.duration - 1,
          ),
        );

        if ((todoStart!.isBefore(otherTodoEnd) &&
                todoStart.isAfter(otherTodoStart!)) ||
            todoStart.isAtSameMomentAs(otherTodoStart!) ||
            todoStart.isAtSameMomentAs(otherTodoEnd)) {
          overlapDuration.add(otherTodo);
        }
      }

      final Set<int?> usedIndexes = <int?>{
        for (TodoEntity overlapTodo in overlapDuration)
          if (overlapTodo.id != todo.id) overlapTodo.monthCellIndex
      };

      final int? overlapDurationIndex =
          Iterable.generate(overlapDuration.length)
              .firstWhere((i) => !usedIndexes.contains(i), orElse: () => null);

      if (overlapDurationIndex == null) continue;
      TodoEntity updatedTodo = todo.copyWith(
        monthCellIndex: overlapDurationIndex,
      );

      await updateTodo(updatedTodo);
    }
  }
}

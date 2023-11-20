// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:tasklendar/config/constraints/utils.dart';
import 'package:tasklendar/core/enums/comparison_operator.dart';
import 'package:tasklendar/core/logs/log.dart';
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';
import 'package:tasklendar/domain/repository/todo_repository.dart';
import 'package:tasklendar/presentation/provider/repository/todo_repository/todo_repository.dart';

part 'todo_notifier.g.dart';

@Riverpod(keepAlive: true)
class TodoNotifier extends _$TodoNotifier {
  @override
  List<TodoEntity?> build() {
    return [];
  }

  Future<void> updateTodos(List<TodoEntity?> todos) async {
    state = [...todos];
    sortTodosByDate();
  }

  Future<void> add(TodoEntity todo) async {
    state = [...state, todo];
    sortTodosByDate();
  }

  // calculateMonthCellIndexを行った後にfirebaseに保存するためadd()とは別で作成
  Future<void> insert(TodoEntity todo) async {
    final TodoRepository todoRepository = ref.read(todoRepositoryProvider);
    try {
      await todoRepository.insertTodo(
        todo,
      );
    } catch (e) {
      Log.error(e.toString());
    }
  }

  Future<void> updateTodo(TodoEntity todo) async {
    todo = todo.copyWith(
      updatedAt: now,
    );
    final index = state.indexWhere((element) => element?.id == todo.id);
    state[index] = todo;

    state = [...state];
  }

  // calculateMonthCellIndexを行った後にfirebaseに保存するためupdateTodo()とは別で作成
  Future<void> updateDatabaseTodo(
    TodoEntity todo,
  ) async {
    final TodoRepository todoRepository = ref.read(todoRepositoryProvider);
    try {
      await todoRepository.updateTodo(
        todo,
      );
    } catch (e) {
      Log.error(e.toString());
    }
  }

  Future<void> removeTodo(TodoEntity todo) async {
    state = state.where((element) => element?.id != todo.id).toList();
  }

  Future<void> deleteTodo(
    TodoEntity todo,
  ) async {
    final TodoRepository todoRepository = ref.read(todoRepositoryProvider);
    try {
      await todoRepository.deleteTodo(
        todo,
      );
    } catch (e) {
      Log.error(e.toString());
    }
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

  TodoEntity? getTodoById(String id) {
    return state.firstWhere((element) => element?.id == id);
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

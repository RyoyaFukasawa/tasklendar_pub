// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/config/styles/app_opacity.dart';
import 'package:tasklendar/config/styles/app_themes.dart';
import 'package:tasklendar/core/enums/comparison_operator.dart';
import 'package:tasklendar/core/enums/snack_bar_type.dart';
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';
import 'package:tasklendar/presentation/components/bottom_sheet/custom_modal_bottom_sheet.dart';
import 'package:tasklendar/presentation/components/slidable_action/delete_slidable_action.dart';
import 'package:tasklendar/presentation/components/slidable_action/edit_slidable_action.dart';
import 'package:tasklendar/presentation/components/todo/todo_tile.dart';
import 'package:tasklendar/presentation/notifier/global_vars/group/group_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/snack_bar/snack_bar_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/todo/todo_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/app_page/app_page_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/group_detail/group_detail_notifier.dart';
import 'package:tasklendar/presentation/pages/add_todo/add_todo_page.dart';
import 'package:tasklendar/presentation/state/snack_bar/snack_bar_state.dart';

class DrawerDetailPage extends HookConsumerWidget {
  const DrawerDetailPage({
    super.key,
    required String property,
    required dynamic value,
    ComparisonOperator? operator,
  })  : _property = property,
        _value = value,
        _operator = operator;

  final String _property;
  final dynamic _value;
  final ComparisonOperator? _operator;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(groupDetailNotifierProvider.notifier);
    final state = ref.watch(groupDetailNotifierProvider);
    final theme = AppTheme.colorScheme;
    final TodoNotifier todoNotifier = ref.read(todoNotifierProvider.notifier);
    final GroupNotifier groupNotifier =
        ref.read(groupNotifierProvider.notifier);
    final SnackBarNotifier snackBarNotifier =
        ref.read(snackBarNotifierProvider.notifier);
    final SnackBarState snackBarState = ref.watch(snackBarNotifierProvider);

    useEffect(() {
      final List<TodoEntity?> todos = todoNotifier.getTodosByProperty(
        property: _property,
        value: _value,
        operator: _operator,
      );

      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifier.updateState(todos);
      });

      return null;
    }, [
      ref.watch(todoNotifierProvider),
      ref.watch(appPageNotifierProvider),
    ]);

    return ReorderableListView.builder(
      itemCount: state.todos.length,
      onReorder: (int oldIndex, int newIndex) {},
      proxyDecorator: (Widget child, int index, _) {
        return Material(
          shadowColor: Theme.of(context)
              .colorScheme
              .onBackground
              .withOpacity(AppOpacity.barrier),
          borderRadius: BorderRadius.circular(10),
          elevation: 4,
          child: child,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        final TodoEntity? todo = state.todos[index];
        if (todo == null) {
          return const SizedBox(
            key: Key(''),
          );
        }
        final Key key = Key(todo.id);
        return Container(
          key: key,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.darkWhite,
                  width: 0.3,
                ),
              ),
            ),
            child: TodoTile(
              todo: todo,
              key: key,
              endActionPane: ActionPane(
                extentRatio: 0.2,
                motion: const ScrollMotion(),
                dismissible: DismissiblePane(
                  onDismissed: () {
                    notifier.removeTodo(todo);
                    snackBarNotifier.updateSnackBarStatus(
                      snackBarState.copyWith(
                        isShown: true,
                        message: 'Todo deleted',
                        type: SnackBarType.delete,
                      ),
                    );
                  },
                ),
                children: [
                  DeleteSlidableAction(
                    onPressed: (BuildContext buildContext) {
                      notifier.removeTodo(todo);
                    },
                  ),
                ],
              ),
              startActionPane: ActionPane(
                extentRatio: 0.2,
                motion: const ScrollMotion(),
                children: [
                  EditSlidableAction(
                    onPressed: (BuildContext buildContext) {
                      showCustomModalBottomSheet(
                        key: const Key('addTodoPage'),
                        context: context,
                        child: (_) => AddTodoPage(
                          groupId: todo.groupId,
                          todo: todo,
                        ),
                        isBottomNavigationBar: false,
                        isScrollControlled: true,
                        useTopBar: false,
                        horizontalPadding: 0,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

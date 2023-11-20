// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

// Project imports:
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/config/styles/app_opacity.dart';
import 'package:tasklendar/config/styles/app_themes.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/core/enums/nav_extra.dart';
import 'package:tasklendar/core/enums/snack_bar_type.dart';
import 'package:tasklendar/core/extension/date_time_extension.dart';
import 'package:tasklendar/core/utils/screen.dart';
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';
import 'package:tasklendar/presentation/components/bottom_sheet/custom_modal_bottom_sheet.dart';
import 'package:tasklendar/presentation/components/default_design/default_button.dart';
import 'package:tasklendar/presentation/components/icon/app_bar_icon.dart';
import 'package:tasklendar/presentation/components/slidable_action/delete_slidable_action.dart';
import 'package:tasklendar/presentation/components/slidable_action/edit_slidable_action.dart';
import 'package:tasklendar/presentation/components/todo/todo_tile.dart';
import 'package:tasklendar/presentation/navigation/page_navigation.dart';
import 'package:tasklendar/presentation/notifier/global_vars/current_month/current_month_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/snack_bar/snack_bar_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/todo/todo_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/app_page/app_page_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/todo/todo_page_notifier.dart';
import 'package:tasklendar/presentation/pages/add_todo/add_todo_page.dart';
import 'package:tasklendar/presentation/state/app_page/app_page_state.dart';
import 'package:tasklendar/presentation/state/snack_bar/snack_bar_state.dart';

class TodoPage extends HookConsumerWidget {
  const TodoPage({
    super.key,
    required DateTime date,
  }) : _date = date;

  final DateTime _date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppPageNotifier appPageNotifier =
        ref.read(appPageNotifierProvider.notifier);
    final AppPageState appPageState = ref.watch(appPageNotifierProvider);

    final PageController controller = usePageController(
      initialPage: 5000,
    );
    final DateTime currentMonth = ref.watch(currentMonthNotifierProvider);
    final SnackBarNotifier snackBarNotifier =
        ref.read(snackBarNotifierProvider.notifier);
    final SnackBarState snackBarState = ref.watch(snackBarNotifierProvider);

    final notifier = ref.read(todoPageNotifierProvider.notifier);
    final state = ref.watch(todoPageNotifierProvider);

    final theme = AppTheme.colorScheme;
    final screenWidth = Screen.width;
    final screenHeight = Screen.height;

    final bottomDate = useState(_date);

    ref.watch(todoNotifierProvider);

    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: controller,
            onPageChanged: (index) {
              final DateTime newDate = DateTime(
                _date.year,
                _date.month,
                _date.day - (controller.initialPage - index),
              );
              appPageNotifier.updateState(
                appPageState.copyWith(
                  appBarTitle: newDate.mMMEd(),
                  selectedDate: newDate,
                ),
              );
            },
            itemBuilder: (context, index) {
              final todoNotifier = ref.watch(todoNotifierProvider.notifier);

              final DateTime date = DateTime(
                _date.year,
                _date.month,
                _date.day - (5000 - index),
              );
              final todos = todoNotifier.getTodosByDate(
                date,
              );
              return ReorderableListView.builder(
                itemCount: todos.length,
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
                  final TodoEntity? todo = todos[index];
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
                            onDismissed: () async {
                              await notifier.removeTodo(todo);
                              snackBarNotifier.updateSnackBarStatus(
                                snackBarState.copyWith(
                                  isShown: true,
                                  message: '${todo.name} Deleted',
                                  type: SnackBarType.delete,
                                ),
                              );
                            },
                          ),
                          children: [
                            DeleteSlidableAction(
                              onPressed: (BuildContext buildContext) async {
                                await notifier.removeTodo(todo);
                                snackBarNotifier.updateSnackBarStatus(
                                  snackBarState.copyWith(
                                    isShown: true,
                                    message: '${todo.name} Deleted',
                                    type: SnackBarType.delete,
                                  ),
                                );
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
            },
          ),
        ),
        Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity == 0) return;

                if (details.primaryVelocity! > 0) {
                  controller.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  bottomDate.value = bottomDate.value.subtract(
                    const Duration(days: 1),
                  );
                } else {
                  controller.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  bottomDate.value = bottomDate.value.add(
                    const Duration(days: 1),
                  );
                }
              },
              child: Container(
                height: kBottomNavigationBarHeight,
                decoration: BoxDecoration(
                  color: theme.background,
                  border: Border(
                    top: BorderSide(
                      color: AppColors.darkWhite,
                      width: 0.3,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultButton(
                      builder: (isHover, opacity) {
                        return BaseIcon(
                          Symbols.arrow_left,
                          color: theme.primary.withOpacity(
                            isHover ? opacity : 1,
                          ),
                        );
                      },
                      onPressed: () {
                        controller.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        bottomDate.value = bottomDate.value.subtract(
                          const Duration(days: 1),
                        );
                      },
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      bottomDate.value.mMMEd(),
                      textAlign: TextAlign.center,
                      style: AppTypography.h5,
                    ),
                    DefaultButton(
                      builder: (isHover, opacity) {
                        return BaseIcon(
                          Symbols.arrow_right,
                          color: theme.primary.withOpacity(
                            isHover ? opacity : 1,
                          ),
                        );
                      },
                      onPressed: () {
                        controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        bottomDate.value = bottomDate.value.add(
                          const Duration(days: 1),
                        );
                      },
                      width: 50,
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: DefaultButton(
                builder: (isHover, opacity) {
                  return BaseIcon(
                    Symbols.arrow_back_ios,
                    color: theme.onBackground,
                    size: 20,
                  );
                },
                onPressed: () {
                  appPageNotifier.updateState(
                    appPageState.copyWith(
                      appBarTitle: currentMonth.mMMEd(),
                      selectedDate: currentMonth,
                    ),
                  );
                  context.goNamed(
                    PageName.calendar,
                  );
                },
                width: 50,
                height: 50,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import 'package:tasklendar/config/constraints/utils.dart';
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/config/styles/app_themes.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/core/extension/date_time_extension.dart';
import 'package:tasklendar/core/icons/icons.dart';
import 'package:tasklendar/domain/entities/group/group_entity.dart';
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';
import 'package:tasklendar/presentation/components/bottom_sheet/custom_modal_bottom_sheet.dart';
import 'package:tasklendar/presentation/components/default_design/default_button.dart';
import 'package:tasklendar/presentation/components/icon/app_bar_icon.dart';
import 'package:tasklendar/presentation/components/text_field/base_text_field.dart';
import 'package:tasklendar/presentation/notifier/global_vars/group/group_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/select_dates/select_dates_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/select_group/select_group_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/select_times/select_times_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/todo/todo_notifier.dart';
import 'package:tasklendar/presentation/pages/add_todo/select_date/select_date_page.dart';
import 'package:tasklendar/presentation/pages/add_todo/select_group/select_group_page.dart';
import 'package:tasklendar/presentation/pages/add_todo/select_times/select_times_page.dart';

class AddTodoPage extends HookConsumerWidget {
  const AddTodoPage({
    super.key,
    this.groupId,
    this.todo,
    this.selectedDate,
  });

  final String? groupId;
  final TodoEntity? todo;
  final DateTime? selectedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(groupNotifierProvider);
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final theme = AppTheme.colorScheme;
    final GlobalKey<FormState> formKey =
        useMemoized(() => GlobalKey<FormState>());

    final todoController = useTextEditingController(
      text: todo?.name ?? '',
    );

    final GroupEntity? group = groups.firstWhere(
      (element) => element?.id == groupId,
      orElse: () => null,
    );

    final selectedDate = useState<DateTime?>(todo?.date ?? this.selectedDate);
    final selectedDuration = useState<int>(todo?.duration ?? 1);
    final selectedGroup = useState<GroupEntity?>(group);
    final selectedTimes = useState<int>(todo?.times ?? 1);
    final currentTimes = useState<int>(todo?.currentTimes ?? 0);
    final isPinned = useState<bool>(false);

    return Container(
      padding: EdgeInsets.only(
        bottom: keyboardHeight,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(5),
            Row(
              children: [
                const Gap(10),
                DefaultButton(
                  onPressed: () {
                    isPinned.value = !isPinned.value;
                  },
                  width: 25,
                  builder: (isHover, opacity) => BaseIcon(
                    Symbols.push_pin_rounded,
                    color:
                        isPinned.value ? theme.primary : AppColors.placeholder,
                    fill: 1,
                    size: 25,
                  ),
                ),
                const Gap(5),
                Expanded(
                  child: BaseTextField(
                    controller: todoController,
                    hintText: 'Todo',
                    autoFocus: true,
                    onFieldSubmitted: (String value) async {
                      context.pop();
                      if (value.isEmpty) return;
                      if (todo != null) {
                        final updatedTodo = todo!.copyWith(
                          name: todoController.text,
                          groupId: selectedGroup.value?.id,
                          date: selectedDate.value?.truncateTime(),
                          color:
                              selectedGroup.value?.color ?? theme.onBackground,
                          times: selectedTimes.value,
                          currentTimes: currentTimes.value > selectedTimes.value
                              ? selectedTimes.value
                              : currentTimes.value,
                          duration: selectedDuration.value,
                          isDone: _checkIsDone(
                            todo: todo!,
                            selectedTimes: selectedTimes.value,
                          ),
                        );
                        _updateTodo(
                          updatedTodo: updatedTodo,
                          ref: ref,
                        );
                      } else {
                        final newTodo = TodoEntity(
                          id: const Uuid().v4(),
                          name: todoController.text,
                          date: selectedDate.value?.truncateTime(),
                          duration: selectedDuration.value,
                          color:
                              selectedGroup.value?.color ?? theme.onBackground,
                          isDone: false,
                          monthCellIndex: 99,
                          groupId: selectedGroup.value?.id,
                          updatedAt: now,
                          createdAt: now,
                          times: selectedTimes.value,
                          currentTimes: 0,
                        );
                        _addTodo(
                          todo: newTodo,
                          ref: ref,
                        );
                      }
                    },
                  ),
                ),
                const Gap(5),
                DefaultButton(
                  width: 25,
                  onPressed: () async {
                    context.pop();
                    if (todoController.text.isEmpty) return;
                    if (todo != null) {
                      final updatedTodo = todo!.copyWith(
                        name: todoController.text,
                        groupId: selectedGroup.value?.id,
                        date: selectedDate.value?.truncateTime(),
                        color: selectedGroup.value?.color ?? theme.onBackground,
                        times: selectedTimes.value,
                        currentTimes: currentTimes.value > selectedTimes.value
                            ? selectedTimes.value
                            : currentTimes.value,
                        duration: selectedDuration.value,
                        isDone: _checkIsDone(
                          todo: todo!,
                          selectedTimes: selectedTimes.value,
                        ),
                      );
                      _updateTodo(
                        updatedTodo: updatedTodo,
                        ref: ref,
                      );
                    } else {
                      final newTodo = TodoEntity(
                        id: const Uuid().v4(),
                        name: todoController.text,
                        date: selectedDate.value?.truncateTime(),
                        duration: selectedDuration.value,
                        color: selectedGroup.value?.color ?? theme.onBackground,
                        isDone: false,
                        monthCellIndex: 99,
                        groupId: selectedGroup.value?.id,
                        updatedAt: now,
                        createdAt: now,
                        times: selectedTimes.value,
                        currentTimes: 0,
                      );
                      _addTodo(
                        todo: newTodo,
                        ref: ref,
                      );
                    }
                  },
                  builder: (isHover, opacity) => BaseIcon(
                    Symbols.send_rounded,
                    color: theme.primary.withOpacity(
                      isHover ? opacity : 1,
                    ),
                    fill: 1,
                    size: 25,
                  ),
                ),
                const Gap(10),
              ],
            ),
            const Gap(5),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  const Gap(10),
                  DefaultButton(
                    builder: (isHover, opacity) => Row(
                      children: [
                        BaseIcon(
                          Symbols.calendar_month_rounded,
                          color: selectedDate.value != null
                              ? theme.primary.withOpacity(
                                  isHover ? opacity : 1,
                                )
                              : theme.onBackground.withOpacity(
                                  isHover ? opacity : 1,
                                ),
                          size: 20,
                        ),
                        const Gap(5),
                        Text(
                          _selectedDateText(
                            selectedDate.value,
                            selectedDuration.value,
                          ),
                          style: AppTypography.body.copyWith(
                            color: theme.onBackground.withOpacity(
                              isHover ? opacity : 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    height: 40,
                    padding: const EdgeInsets.only(
                      left: 7,
                      right: 7,
                    ),
                    border: Border.all(
                      color: AppColors.darkWhite,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    onPressed: () {
                      // endDateは計算後selectedDateと等しいならnull
                      final endDate = selectedDate.value?.add(
                                Duration(days: selectedDuration.value - 1),
                              ) ==
                              selectedDate.value
                          ? null
                          : selectedDate.value?.add(
                              Duration(days: selectedDuration.value - 1),
                            );

                      const key = Key('select_date');

                      showCustomModalBottomSheet(
                        key: key,
                        context: context,
                        isScrollControlled: true,
                        isBottomNavigationBar: false,
                        horizontalPadding: 20,
                        title: 'Select Date',
                        enableSaveButton: true,
                        initialSaveButtonState: true,
                        onSaveButtonPressed: (context, ref) {
                          final newSelectedDate =
                              ref.watch(selectDatesNotifierProvider);
                          selectedDate.value = newSelectedDate.startDate;
                          selectedDuration.value = newSelectedDate.duration;
                          context.pop(true);
                        },
                        child: (context) {
                          return SelectDatePage(
                            key: key,
                            startDate: selectedDate.value,
                            endDate: endDate,
                          );
                        },
                      );
                    },
                  ),
                  const Gap(7),
                  DefaultButton(
                    builder: (isHover, opacity) => Row(
                      children: [
                        BaseIcon(
                          TasklendarIcon.counter,
                          color: selectedTimes.value != 1
                              ? theme.primary.withOpacity(
                                  isHover ? opacity : 1,
                                )
                              : theme.onBackground.withOpacity(
                                  isHover ? opacity : 1,
                                ),
                          size: 20,
                        ),
                        const Gap(5),
                        Text(
                          'Times: ${selectedTimes.value}',
                          style: AppTypography.body.copyWith(
                            color: isHover
                                ? theme.onBackground.withOpacity(opacity)
                                : theme.onBackground,
                          ),
                        ),
                      ],
                    ),
                    height: 40,
                    padding: const EdgeInsets.only(
                      left: 7,
                      right: 7,
                    ),
                    border: Border.all(
                      color: AppColors.darkWhite,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    onPressed: () {
                      showCustomModalBottomSheet(
                        key: const Key('select_times'),
                        context: context,
                        isScrollControlled: true,
                        isBottomNavigationBar: false,
                        horizontalPadding: 20,
                        title: 'Select Times',
                        enableSaveButton: true,
                        initialSaveButtonState: true,
                        onSaveButtonPressed: (context, ref) {
                          final newSelectedTimes =
                              ref.watch(selectTimesNotifierProvider);

                          selectedTimes.value = newSelectedTimes;
                          context.pop(true);
                        },
                        child: (context) {
                          return SelectTimesPage(
                            time: selectedTimes.value,
                          );
                        },
                      );
                    },
                  ),
                  const Gap(7),
                  Stack(
                    children: [
                      if (selectedGroup.value != null)
                        Positioned(
                          left: 5,
                          top: 10,
                          bottom: 10,
                          child: Container(
                            width: 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: selectedGroup.value!.color,
                            ),
                          ),
                        ),
                      DefaultButton(
                        builder: (isHover, opacity) {
                          return selectedGroup.value != null
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Gap(5),
                                    AutoSizeText(
                                      selectedGroup.value!.emoji,
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                    const Gap(5),
                                    Container(
                                      constraints: const BoxConstraints(
                                        maxWidth: 150,
                                      ),
                                      child: Text(
                                        selectedGroup.value!.name,
                                        style: AppTypography.body.copyWith(
                                          color: isHover
                                              ? theme.onBackground
                                                  .withOpacity(opacity)
                                              : theme.onBackground,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    BaseIcon(
                                      Symbols.folder_rounded,
                                      color: isHover
                                          ? theme.onBackground
                                              .withOpacity(opacity)
                                          : theme.onBackground,
                                      size: 20,
                                    ),
                                    const Gap(5),
                                    Text(
                                      'group',
                                      style: AppTypography.body.copyWith(
                                        color: isHover
                                            ? theme.onBackground
                                                .withOpacity(opacity)
                                            : theme.onBackground,
                                      ),
                                    ),
                                  ],
                                );
                        },
                        height: 40,
                        padding: const EdgeInsets.only(
                          left: 7,
                          right: 7,
                        ),
                        border: Border.all(
                          color: AppColors.darkWhite,
                          width: 1,
                        ),
                        backgroundColor:
                            selectedGroup.value?.color.withOpacity(.3),
                        borderRadius: BorderRadius.circular(10),
                        onPressed: () {
                          showCustomModalBottomSheet(
                            key: const Key('select_group'),
                            context: context,
                            isScrollControlled: true,
                            isBottomNavigationBar: false,
                            horizontalPadding: 20,
                            title: 'Select Group',
                            enableSaveButton: true,
                            initialSaveButtonState: true,
                            onSaveButtonPressed: (context, ref) {
                              final newSelectedGroup =
                                  ref.watch(selectGroupNotifierProvider);
                              selectedGroup.value = newSelectedGroup;
                              context.pop(true);
                            },
                            child: (context) {
                              return SelectGroupPage(
                                group: selectedGroup.value,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const Gap(10),
                ],
              ),
            ),
            const Gap(5),
          ],
        ),
      ),
    );
  }

  bool _checkIsDone({
    required TodoEntity todo,
    required int selectedTimes,
  }) {
    if (todo.currentTimes >= selectedTimes) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _updateTodo({
    required TodoEntity updatedTodo,
    required WidgetRef ref,
  }) async {
    final TodoNotifier todoNotifier = ref.read(todoNotifierProvider.notifier);
    await todoNotifier.updateTodo(updatedTodo);
    await todoNotifier.updateDatabaseTodo(updatedTodo);
    await todoNotifier.sortTodosByDate();
    await todoNotifier.calculateMonthCellIndex();
  }

  Future<void> _addTodo({
    required TodoEntity todo,
    required WidgetRef ref,
  }) async {
    final TodoNotifier todoNotifier = ref.read(todoNotifierProvider.notifier);
    await todoNotifier.add(todo);
    await todoNotifier.insert(todo);
    await todoNotifier.calculateMonthCellIndex();
  }

  String _selectedDateText(DateTime? selectedDate, int duration) {
    if (selectedDate == null) return 'Someday';
    if (selectedDate.truncateTime().isSameDay(now.truncateTime()) &&
        duration == 1) {
      return 'Today';
    }
    if (duration == 1) return selectedDate.yMMMEd();
    final DateTime endDate = selectedDate.add(Duration(days: duration - 1));
    if (selectedDate.year != endDate.year) {
      return '${selectedDate.yMMMEd()} - ${endDate.yMMMEd()}';
    }
    return '${selectedDate.mMMEd()} - ${selectedDate.add(Duration(days: duration - 1)).mMMEd()}';
  }
}

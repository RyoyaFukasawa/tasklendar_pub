// Flutter imports:
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Package imports:
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

// Project imports:
import 'package:tasklendar/config/constraints/utils.dart';
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/config/styles/app_themes.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/core/extension/date_time_extension.dart';
import 'package:tasklendar/core/icons/icons.dart';
import 'package:tasklendar/domain/entities/group/group_entity.dart';
import 'package:tasklendar/domain/entities/todo/todo_entity.dart';
import 'package:tasklendar/presentation/components/check_box/custom_check_box.dart';
import 'package:tasklendar/presentation/components/icon/app_bar_icon.dart';
import 'package:tasklendar/presentation/notifier/global_vars/group/group_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/todo/todo_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/app_page/app_page_notifier.dart';
import 'package:tasklendar/presentation/state/app_page/app_page_state.dart';

class TodoTile extends HookConsumerWidget {
  const TodoTile({
    super.key,
    required this.todo,
    this.startActionPane,
    this.endActionPane,
  });

  final ActionPane? endActionPane;
  final ActionPane? startActionPane;
  final TodoEntity todo;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TodoNotifier todoNotifier = ref.read(todoNotifierProvider.notifier);
    final GroupNotifier groupNotifier =
        ref.read(groupNotifierProvider.notifier);
    final AppPageState appPageState = ref.watch(appPageNotifierProvider);
    final ColorScheme theme = AppTheme.colorScheme;
    const audioContext = AudioContext(
      iOS: AudioContextIOS(
        category: AVAudioSessionCategory.ambient,
      ),
      android: AudioContextAndroid(),
    );
    final AudioPlayer player = AudioPlayer();

    final GroupEntity? group =
        todo.groupId == null ? null : groupNotifier.getGroupById(todo.groupId!);

    Future<void> initializeAudioPlayer() async {
      await AudioPlayer.global.setAudioContext(audioContext);
    }

    useEffect(
      () {
        initializeAudioPlayer();
        return;
      },
      const [],
    );

    Future<void> playSound() async {
      player.play(
        AssetSource('sounds/done.mp3'),
      );
    }

    return Container(
      key: key,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.darkWhite,
              width: 1,
            ),
          ),
        ),
        child: Slidable(
          key: key,
          endActionPane: endActionPane,
          startActionPane: startActionPane,
          child: GestureDetector(
            onTap: () async {
              HapticFeedback.mediumImpact();
              if (todo.isDone) {
                todoNotifier.updateTodo(
                  todo.copyWith(
                    isDone: !todo.isDone,
                    currentTimes: 0,
                  ),
                );
                return;
              }
              if (todo.currentTimes + 1 == todo.times) {
                // playSound();
                todoNotifier.updateTodo(
                  todo.copyWith(
                    isDone: !todo.isDone,
                    currentTimes: todo.currentTimes + 1,
                  ),
                );
              } else {
                todoNotifier.updateTodo(
                  todo.copyWith(
                    currentTimes: todo.currentTimes + 1,
                    isDone: todo.currentTimes + 1 == todo.times,
                  ),
                );
              }
              todoNotifier.calculateMonthCellIndex();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 7,
              ),
              color: theme.background,
              constraints: const BoxConstraints(
                minHeight: 50,
              ),
              child: Row(
                children: [
                  todo.times - todo.currentTimes != 1
                      ? todo.isDone
                          ? CustomCheckBox(
                              isCheck: todo.isDone,
                            )
                          : Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.3,
                                  color: theme.onBackground,
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Center(
                                child: Text(
                                  '${todo.times - todo.currentTimes}',
                                  style: AppTypography.body.copyWith(
                                    color: theme.onBackground,
                                  ),
                                ),
                              ),
                            )
                      : CustomCheckBox(
                          isCheck: todo.isDone,
                        ),
                  const Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Positioned(
                              top: 2,
                              bottom: 2,
                              child: Container(
                                width: 5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: todo.groupId == null
                                      ? transparent
                                      : groupNotifier
                                              .getGroupById(todo.groupId!)
                                              ?.color ??
                                          transparent,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                left: 10,
                              ),
                              child: Text(
                                todo.name,
                                style: AppTypography.h5.copyWith(
                                  color: theme.onBackground,
                                  decoration: todo.isDone
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        if ((appPageState.groupId == null &&
                                todo.groupId != null) ||
                            todo.times != 1 ||
                            todo.date != null)
                          const Gap(5),
                        Row(
                          children: [
                            if (appPageState.groupId == null &&
                                todo.groupId != null)
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      AutoSizeText(
                                        '${group?.emoji}',
                                        style: TextStyle(
                                          color: theme.onBackground,
                                          fontSize: 12,
                                        ),
                                      ),
                                      if (todo.isDone)
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          bottom: 0,
                                          left: 0,
                                          child: Container(
                                            color: theme.background
                                                .withOpacity(.5),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const Gap(5),
                                  Text(
                                    '${group?.name}',
                                    style: AppTypography.body.copyWith(
                                      color: !todo.isDone
                                          ? theme.onBackground
                                          : AppColors.placeholder,
                                    ),
                                  ),
                                ],
                              ),
                            if (todo.times != 1) const Gap(10),
                            if (todo.times != 1)
                              Row(
                                children: [
                                  BaseIcon(
                                    TasklendarIcon.counter,
                                    color: !todo.isDone
                                        ? theme.onBackground
                                        : AppColors.placeholder,
                                    size: 15,
                                  ),
                                  const Gap(5),
                                  Text(
                                    '${todo.currentTimes}/${todo.times}',
                                    style: AppTypography.body.copyWith(
                                      color: !todo.isDone
                                          ? theme.onBackground
                                          : AppColors.placeholder,
                                    ),
                                  ),
                                ],
                              ),
                            if (todo.date != null) const Gap(10),
                            if (todo.date != null)
                              Row(
                                children: [
                                  BaseIcon(
                                    Symbols.calendar_today_rounded,
                                    color: !todo.isDone
                                        ? theme.onBackground
                                        : AppColors.placeholder,
                                    size: 15,
                                  ),
                                  const Gap(5),
                                  Text(
                                    _period(todo),
                                    style: AppTypography.body.copyWith(
                                      color: !todo.isDone
                                          ? theme.onBackground
                                          : AppColors.placeholder,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _period(TodoEntity todo) {
    if (todo.date == null) {
      return '';
    } else if (todo.date == todo.date!.add(Duration(days: todo.duration - 1))) {
      return todo.date!.yMMMd();
    } else if (todo.date!.month ==
        todo.date!.add(Duration(days: todo.duration)).month) {
      return '${todo.date!.yMMMd()} - ${todo.date!.add(Duration(days: todo.duration - 1)).d()}';
    } else {
      return '${todo.date!.yMMMd()} - ${todo.date!.add(Duration(days: todo.duration - 1)).yMMMd()}';
    }
  }
}

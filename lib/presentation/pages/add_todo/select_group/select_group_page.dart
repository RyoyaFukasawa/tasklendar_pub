// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/config/styles/app_themes.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/domain/entities/group/group_entity.dart';
import 'package:tasklendar/presentation/components/default_design/default_button.dart';
import 'package:tasklendar/presentation/notifier/global_vars/group/group_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/select_group/select_group_notifier.dart';

class SelectGroupPage extends HookConsumerWidget {
  const SelectGroupPage({
    super.key,
    GroupEntity? group,
  }) : _group = group;

  final GroupEntity? _group;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectGroupNotifier = ref.read(selectGroupNotifierProvider.notifier);
    final selectGroup = ref.watch(selectGroupNotifierProvider);
    final groups = ref.watch(groupNotifierProvider);
    final theme = AppTheme.colorScheme;

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          selectGroupNotifier.updateState(_group);
        });
        return;
      },
      const [],
    );

    return Container(
      height: 250,
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: groups.isEmpty
          ? Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(
                top: 30,
              ),
              child: Text(
                'グループがありません',
                style: AppTypography.body,
              ),
            )
          : ListView.builder(
              itemCount: groups.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final GroupEntity? group = groups[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  child: DefaultButton(
                    builder: (isHover, opacity) {
                      return Transform(
                        transform: Matrix4.translationValues(
                          0,
                          // isHover ? 2 : 0,
                          0,
                          0,
                        ),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: theme.background,
                            // boxShadow: [
                            //   if (!isHover)
                            //     BoxShadow(
                            //       color: theme.onBackground.withOpacity(0.2),
                            //       blurRadius: 5,
                            //       offset: const Offset(0, 2),
                            //     ),
                            // ],
                            border: Border.all(
                              color: AppColors.darkWhite,
                              width: 1,
                            ),
                          ),
                          margin: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 5,
                                top: 10,
                                bottom: 10,
                                child: Container(
                                  width: 5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: group?.color,
                                  ),
                                ),
                              ),
                              // if (selectGroup == group)
                              Positioned(
                                right: 0,
                                left: 0,
                                top: 0,
                                bottom: 0,
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 100),
                                  curve: Curves.fastOutSlowIn,
                                  opacity: selectGroup == group ? 1 : 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: group?.color.withOpacity(.3),
                                    ),
                                  ),
                                ),
                              ),
                              // Visibility(
                              //   visible: selectGroup == group,
                              //   maintainAnimation: true,
                              //   maintainState: true,
                              //   child: AnimatedOpacity(
                              //     duration: const Duration(milliseconds: 200),
                              //     curve: Curves.fastOutSlowIn,
                              //     opacity: selectGroup == group ? 1 : 0,
                              //     child: Container(
                              //       decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(10),
                              //         color: group?.color.withOpacity(.3),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AutoSizeText(
                                      group?.emoji ?? '',
                                      style: const TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    const Gap(10),
                                    Expanded(
                                      child: Text(
                                        group?.name ?? 'group',
                                        style: AppTypography.body.copyWith(
                                          color: theme.onBackground,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    onPressed: () {
                      if (selectGroup == group) {
                        selectGroupNotifier.updateState(null);
                        return;
                      }
                      selectGroupNotifier.updateState(group);
                    },
                  ),
                );
              },
            ),
    );
  }
}

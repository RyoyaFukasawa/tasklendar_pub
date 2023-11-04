// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:tasklendar/config/constraints/drawer_key.dart';
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/config/styles/app_themes.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/core/extension/date_time_extension.dart';
import 'package:tasklendar/core/utils/l10n.dart';
import 'package:tasklendar/domain/entities/group/group_entity.dart';
import 'package:tasklendar/presentation/components/bottom_sheet/custom_modal_bottom_sheet.dart';
import 'package:tasklendar/presentation/components/button/middle_button.dart';
import 'package:tasklendar/presentation/navigation/page_navigation.dart';
import 'package:tasklendar/presentation/notifier/global_vars/current_month/current_month_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/group/group_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/todo/todo_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/app_page/app_page_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/drawer/drawer_notifier.dart';
import 'package:tasklendar/presentation/pages/add_group/add_group_page.dart';
import 'package:tasklendar/presentation/provider/global_vars/scaffold_key/scaffold_key.dart';
import 'package:tasklendar/presentation/state/app_page/app_page_state.dart';

class MorePage extends HookConsumerWidget {
  const MorePage({
    super.key,
    required GroupEntity group,
  }) : _group = group;

  final GroupEntity _group;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppPageNotifier appPageNotifier =
        ref.read(appPageNotifierProvider.notifier);
    final TodoNotifier todoNotifier = ref.read(todoNotifierProvider.notifier);
    final GroupNotifier groupNotifier =
        ref.read(groupNotifierProvider.notifier);
    final DrawerNotifier drawerNotifier =
        ref.read(drawerNotifierProvider.notifier);
    final GlobalKey<ScaffoldState> scaffoldKey = ref.watch(scaffoldKeyProvider);
    final l10n = L10n.of;
    final theme = AppTheme.colorScheme;
    final DateTime currentMonth = ref.watch(currentMonthNotifierProvider);

    return Column(
      children: [
        const Gap(10),
        MiddleButton(
          onPressed: () {
            final context = scaffoldKey.currentContext!;
            context.pop();
            // showCustomModalBottomSheet(
            //   key: const Key('add_group_modal_bottom_sheet'),
            //   context: context,
            //   isScrollControlled: true,
            //   child: (_) {
            //     return AddGroupPage(
            //       group: _group,
            //     );
            //   },
            //   title: l10n.edit_group,
            // );
          },
          child: Text(
            'Edit Group',
            style: AppTypography.h4,
          ),
        ),
        const Gap(20),
        MiddleButton(
          backgroundColor: theme.background,
          onPressed: () {
            context.pop();
            showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: const Text(
                    'Delete Group',
                  ),
                  content: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Are you sure you want to delete ',
                          style: TextStyle(
                            color: theme.onBackground,
                          ),
                        ),
                        TextSpan(
                          text: _group.name,
                          style: AppTypography.h5.copyWith(
                            color: _group.color,
                          ),
                        ),
                        TextSpan(
                          text: ' group?',
                          style: TextStyle(
                            color: theme.onBackground,
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    CupertinoDialogAction(
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          color: AppColors.red,
                        ),
                      ),
                      onPressed: () {
                        drawerNotifier.updateSelectedKey(DrawerKey.get(
                          DrawerKeyType.calendar,
                        ));
                        appPageNotifier.updateState(
                          AppPageState(
                            appBarTitle: currentMonth.monthFormat(),
                            titleColor: theme.onBackground,
                            groupId: null,
                          ),
                        );
                        context.goNamed(PageName.calendar);
                        groupNotifier.removeGroup(_group.id);
                        todoNotifier.calculateMonthCellIndex();
                        context.pop();
                      },
                    ),
                    CupertinoDialogAction(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: AppColors.blue,
                        ),
                      ),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          borderColor: AppColors.red,
          isBorder: true,
          child: Text(
            'Delete Group',
            style: AppTypography.h4.copyWith(
              color: AppColors.red,
            ),
          ),
        ),
      ],
    );
  }
}

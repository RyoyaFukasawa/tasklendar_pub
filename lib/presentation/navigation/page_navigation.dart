// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

// Project imports:
import 'package:tasklendar/config/constraints/drawer_key.dart';
import 'package:tasklendar/config/constraints/utils.dart';
import 'package:tasklendar/config/styles/app_borders.dart';
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/config/styles/app_opacity.dart';
import 'package:tasklendar/config/styles/app_themes.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/core/enums/nav_extra.dart';
import 'package:tasklendar/core/extension/date_time_extension.dart';
import 'package:tasklendar/core/utils/l10n.dart';
import 'package:tasklendar/domain/entities/group/group_entity.dart';
import 'package:tasklendar/presentation/components/bottom_sheet/custom_modal_bottom_sheet.dart';
import 'package:tasklendar/presentation/components/button/base_button.dart';
import 'package:tasklendar/presentation/components/default_design/default_button.dart';
import 'package:tasklendar/presentation/components/icon/app_bar_icon.dart';
import 'package:tasklendar/presentation/notifier/global_vars/current_month/current_month_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/group/group_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/todo/todo_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/add_group/add_group_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/app_page/app_page_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/calendar/calendar_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/drawer/drawer_notifier.dart';
import 'package:tasklendar/presentation/pages/add_group/add_group_page.dart';
import 'package:tasklendar/presentation/pages/app_page.dart';
import 'package:tasklendar/presentation/pages/calendar/calendar_page.dart';
import 'package:tasklendar/presentation/pages/delete_account/delete_account_complete_page.dart';
import 'package:tasklendar/presentation/pages/drawer/drawer_detail_page.dart';
import 'package:tasklendar/presentation/pages/error/error_page.dart';
import 'package:tasklendar/presentation/pages/sign_out/sign_out_complete_page.dart';
import 'package:tasklendar/presentation/pages/todo/todo_page.dart';
import 'package:tasklendar/presentation/state/add_group/add_group_state.dart';
import 'package:tasklendar/presentation/state/app_page/app_page_state.dart';

class PageName {
  static const String calendar = 'calendar';
  static const String todo = 'todo';
  static const String groupDetail = 'group_detail';
  static const String deleteAccountComplete = 'delete_account_complete';
  static const String signOut = 'sign_out';
}

class PagePath {
  static const String initial = '/';
  static const String todo = '/todo';
  static const String groupDetail = '/group/detail';
  static const String deleteAccountComplete = '/delete_account_complete';
  static const String signOut = '/sign_out';
}

class PageNavigation {
  PageNavigation._();
  static final PageNavigation _instance = PageNavigation._();

  MaterialPage page({
    required Widget child,
    Function(BuildContext context, WidgetRef ref)? onTitlePressed,
    List<Widget>? Function(BuildContext context, WidgetRef ref)? actions,
    bool? isSafeAreaBottom,
  }) {
    return MaterialPage(
      child: AppPage(
        onTitlePressed: onTitlePressed,
        actions: actions,
        isSafeAreaBottom: isSafeAreaBottom,
        child: child,
      ),
    );
  }

  MaterialPage errorPage() {
    return _instance.page(
      child: const ErrorPage(),
    );
  }

  static final goRouter = GoRouter(
    initialLocation: PagePath.initial,
    routes: [
      GoRoute(
        path: PagePath.initial,
        name: PageName.calendar,
        pageBuilder: (context, state) {
          return _instance.page(
            child: const CalendarPage(),
            onTitlePressed: _instance.onCalendarTitlePressed,
            actions: (context, ref) {
              final theme = AppTheme.colorScheme;
              final currentMonth = ref.watch(currentMonthNotifierProvider);
              final PageController pageController =
                  ref.watch(calendarPageControllerProvider);
              final calendarState = ref.watch(calendarPageNotifierProvider);

              final actions = [
                BaseButton(
                  child: BaseIcon(
                    Symbols.today_rounded,
                    color: currentMonth.isSameMonth(now)
                        ? theme.onBackground.withOpacity(AppOpacity.disabled)
                        : theme.onBackground,
                  ),
                  onPressed: () {
                    if (currentMonth.isSameMonth(now)) return;
                    pageController.animateToPage(
                      calendarState.initialPage,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ];

              return actions;
            },
          );
        },
      ),
      GoRoute(
        path: PagePath.todo,
        name: PageName.todo,
        pageBuilder: (context, state) {
          final Map<NavExtra, dynamic> extra =
              state.extra as Map<NavExtra, dynamic>;
          if (extra.isNotEmpty) {
            return _instance.page(
              child: TodoPage(
                date: extra[NavExtra.date],
              ),
              isSafeAreaBottom: true,
            );
          }
          return _instance.errorPage();
        },
      ),
      GoRoute(
        path: PagePath.groupDetail,
        name: PageName.groupDetail,
        pageBuilder: (context, GoRouterState state) {
          final Map<NavExtra, dynamic> extra =
              state.extra as Map<NavExtra, dynamic>;

          if (extra.isNotEmpty) {
            return _instance.page(
              child: DrawerDetailPage(
                property: extra[NavExtra.property],
                value: extra[NavExtra.value],
                operator: extra[NavExtra.operator],
              ),
              actions: (context, ref) {
                final DrawerKeyType? key =
                    DrawerKey.getType(extra[NavExtra.key]);
                return _instance.switchActions(
                  context: context,
                  ref: ref,
                  key: key,
                );
              },
              isSafeAreaBottom: true,
            );
          }
          return _instance.errorPage();
        },
      ),
      GoRoute(
        path: PagePath.deleteAccountComplete,
        name: PageName.deleteAccountComplete,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: DeleteAccountCompletePage(),
          );
        },
      ),
      GoRoute(
        path: PagePath.signOut,
        name: PageName.signOut,
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: SignOutCompletePage(),
          );
        },
      ),
    ],
    errorPageBuilder: (context, state) {
      return _instance.errorPage();
    },
  );

  void onCalendarTitlePressed(context, ref) {
    final DateTime currentMonth = ref.watch(currentMonthNotifierProvider);
    DateTime newCurrentMonth = currentMonth;
    int newPage = 5000;
    final theme = Theme.of(context).colorScheme;
    final now = DateTime.now();

    showCustomModalBottomSheet(
      key: const Key('calendar_modal_bottom_sheet'),
      title: 'Select Month',
      context: context,
      enableSaveButton: true,
      isBottomNavigationBar: false,
      onSaveButtonPressed: (context, ref) async {
        final currentMonthNotifier =
            ref.read(currentMonthNotifierProvider.notifier);
        final PageController pageController =
            ref.watch(calendarPageControllerProvider);
        currentMonthNotifier.updateCurrentMonth(newCurrentMonth);
        ref
            .read(appPageNotifierProvider.notifier)
            .updateAppBarTitle(newCurrentMonth.monthFormat());
        context.pop(true);
        await pageController.animateToPage(
          // page.value,
          newPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
      child: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          height: 250,
          child: CupertinoTheme(
            data: CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: AppTypography.h4.copyWith(
                  fontWeight: FontWeight.w400,
                  color: theme.onBackground,
                ),
              ),
            ),
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.monthYear,
              onDateTimeChanged: (DateTime value) async {
                newCurrentMonth = DateTime(
                  value.year,
                  value.month,
                );

                newPage = (5000 +
                    (value.year - now.year) * 12 +
                    (value.month - now.month));
              },
              initialDateTime: currentMonth,
              maximumDate: DateTime(2024, 12),
              minimumDate: DateTime(2020, 1),
              minimumYear: 2020,
              maximumYear: 2024,
            ),
          ),
        );
      },
    );
  }

  List<Widget>? switchActions({
    required BuildContext context,
    required WidgetRef ref,
    required DrawerKeyType? key,
  }) {
    final theme = AppTheme.colorScheme;
    final menuController = MenuController();
    final l10n = L10n.of;
    final GroupNotifier groupNotifier =
        ref.read(groupNotifierProvider.notifier);
    final AppPageState state = ref.watch(appPageNotifierProvider);
    final TodoNotifier todoNotifier = ref.read(todoNotifierProvider.notifier);
    final appPageNotifier = ref.read(appPageNotifierProvider.notifier);
    final drawerNotifier = ref.read(drawerNotifierProvider.notifier);
    final currentMonth = ref.watch(currentMonthNotifierProvider);

    List<Widget>? actions;

    switch (key) {
      case DrawerKeyType.inbox:
        break;
      case DrawerKeyType.someday:
        break;
      default:
        actions = [
          Theme(
            data: Theme.of(context).copyWith(
              menuTheme: MenuThemeData(
                style: MenuStyle(
                  backgroundColor: MaterialStateProperty.all(
                    theme.background,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppBorders.radius),
                    ),
                  ),
                  shadowColor: MaterialStateProperty.all(
                    theme.onBackground.withOpacity(
                      AppOpacity.barrier,
                    ),
                  ),
                  elevation: MaterialStateProperty.all(
                    4,
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.all(0),
                  ),
                ),
              ),
            ),
            child: MenuAnchor(
              controller: menuController,
              builder: (BuildContext context, MenuController controller,
                  Widget? child) {
                return DefaultButton(
                  height: 40,
                  width: 40,
                  builder: (isHover, opacity) => BaseIcon(
                    Symbols.more_horiz_rounded,
                    color: Theme.of(context).colorScheme.onBackground,
                    size: 25,
                  ),
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                );
              },
              menuChildren: [
                DefaultButton(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  builder: (isHover, opacity) => Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Edit Group',
                            style: AppTypography.h5.copyWith(
                              color: theme.onBackground.withOpacity(
                                isHover ? opacity : 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      BaseIcon(
                        Symbols.edit_rounded,
                        color: theme.onBackground.withOpacity(
                          isHover ? opacity : 1,
                        ),
                        size: 20,
                      ),
                    ],
                  ),
                  height: 50,
                  width: 250,
                  onPressed: () {
                    menuController.close();

                    const key = Key('edit_group_page');
                    showCustomModalBottomSheet(
                      key: key,
                      context: context,
                      title: l10n.edit_group,
                      isScrollControlled: true,
                      enableSaveButton: true,
                      initialSaveButtonState: false,
                      isBottomNavigationBar: false,
                      onSaveButtonPressed: (context, ref) {
                        final AddGroupState addGroupState =
                            ref.read(addGroupNotifierProvider);

                        if (addGroupState.formKey.currentState!.validate()) {
                          final group =
                              groupNotifier.getGroupById(state.groupId!)!;
                          final updatedGroup = group.copyWith(
                            name: addGroupState.name,
                            emoji: addGroupState.emoji,
                            color: addGroupState.color,
                            updatedAt: now,
                          );

                          groupNotifier.updateGroup(updatedGroup).then(
                                (value) => context.pop(),
                              );

                          final drawerState = ref.watch(drawerNotifierProvider);
                          final appPageState =
                              ref.watch(appPageNotifierProvider);
                          if (drawerState.selectedKey == Key(group.id)) {
                            ref
                                .read(appPageNotifierProvider.notifier)
                                .updateState(
                                  appPageState.copyWith(
                                    appBarTitle:
                                        '${updatedGroup.emoji} ${updatedGroup.name}',
                                    titleColor: updatedGroup.color,
                                  ),
                                );
                          }
                        }
                      },
                      child: (_) {
                        final group =
                            groupNotifier.getGroupById(state.groupId!)!;
                        return AddGroupPage(
                          group: group,
                          key: key,
                        );
                      },
                    );
                  },
                ),
                Divider(
                  color: theme.onBackground.withOpacity(0.2),
                  height: 1,
                ),
                DefaultButton(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  builder: (isHover, opacity) => Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Delete Group',
                            style: AppTypography.h5.copyWith(
                              color: theme.secondary.withOpacity(
                                isHover ? opacity : 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      BaseIcon(
                        Symbols.delete_rounded,
                        color: theme.secondary.withOpacity(
                          isHover ? opacity : 1,
                        ),
                        size: 20,
                      ),
                    ],
                  ),
                  height: 50,
                  width: 250,
                  onPressed: () {
                    menuController.close();
                    final GroupEntity group =
                        groupNotifier.getGroupById(state.groupId!)!;
                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Container(
                            padding: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: const Text(
                              'Delete Group',
                            ),
                          ),
                          content: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Are you sure you want to delete ',
                                  style: TextStyle(
                                    color: theme.onBackground,
                                  ),
                                ),
                                TextSpan(
                                  text: '${group.emoji}${group.name}',
                                  style: AppTypography.h5.copyWith(
                                    color: group.color,
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
                                groupNotifier.removeGroup(group.id);
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
                ),
              ],
            ),
          ),
        ];
        break;
    }
    return actions;
  }
}

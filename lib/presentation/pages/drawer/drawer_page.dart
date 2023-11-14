// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import 'package:tasklendar/config/constraints/drawer_key.dart';
import 'package:tasklendar/config/constraints/utils.dart';
import 'package:tasklendar/config/gen/assets.gen.dart';
import 'package:tasklendar/config/styles/app_borders.dart';
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/config/styles/app_opacity.dart';
import 'package:tasklendar/config/styles/app_themes.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/core/enums/nav_extra.dart';
import 'package:tasklendar/core/enums/user_status.dart';
import 'package:tasklendar/core/extension/date_time_extension.dart';
import 'package:tasklendar/core/utils/l10n.dart';
import 'package:tasklendar/domain/entities/group/group_entity.dart';
import 'package:tasklendar/presentation/components/bottom_sheet/custom_modal_bottom_sheet.dart';
import 'package:tasklendar/presentation/components/button/base_button.dart';
import 'package:tasklendar/presentation/components/default_design/default_button.dart';
import 'package:tasklendar/presentation/components/drawer/drawer_expansion_tile.dart';
import 'package:tasklendar/presentation/components/drawer/drawer_tile.dart';
import 'package:tasklendar/presentation/components/icon/app_bar_icon.dart';
import 'package:tasklendar/presentation/navigation/page_navigation.dart';
import 'package:tasklendar/presentation/notifier/global_vars/current_month/current_month_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/group/group_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/todo/todo_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/user/user_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/add_group/add_group_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/app_page/app_page_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/drawer/drawer_notifier.dart';
import 'package:tasklendar/presentation/pages/add_group/add_group_page.dart';
import 'package:tasklendar/presentation/pages/auth/auth_page.dart';
import 'package:tasklendar/presentation/pages/my_page/my_page.dart';
import 'package:tasklendar/presentation/provider/datasources/auth_datasource.dart/auth_datasource.dart';
import 'package:tasklendar/presentation/provider/global_vars/scaffold_key/scaffold_key.dart';
import 'package:tasklendar/presentation/provider/global_vars/shared_preferences/shared_preferences.dart';
import 'package:tasklendar/presentation/state/add_group/add_group_state.dart';
import 'package:tasklendar/presentation/state/app_page/app_page_state.dart';
import 'package:tasklendar/presentation/state/drawer/drawer_state.dart';
import 'package:tasklendar/presentation/state/user/user_state.dart';

class DrawerPage extends HookConsumerWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DrawerNotifier notifier = ref.read(drawerNotifierProvider.notifier);
    final DrawerState state = ref.watch(drawerNotifierProvider);

    final AppPageNotifier appPageNotifier =
        ref.read(appPageNotifierProvider.notifier);
    final TodoNotifier todoNotifier = ref.read(todoNotifierProvider.notifier);
    final GroupNotifier groupNotifier =
        ref.read(groupNotifierProvider.notifier);
    final drawerNotifier = ref.read(drawerNotifierProvider.notifier);

    final UserState user = ref.watch(userNotifierProvider);
    final List<GroupEntity?> groups = ref.watch(groupNotifierProvider);
    final GlobalKey<ScaffoldState> scaffoldKey = ref.watch(scaffoldKeyProvider);
    final DateTime currentMonth = ref.watch(currentMonthNotifierProvider);
    final l10n = L10n.of;
    final theme = AppTheme.colorScheme;

    final AddGroupNotifier addGroupNotifier =
        ref.read(addGroupNotifierProvider.notifier);

    void closeDrawer() {
      scaffoldKey.currentState?.openEndDrawer();
    }

    return Container(
      color: theme.background,
      child: SafeArea(
        maintainBottomViewPadding: true,
        child: Drawer(
          backgroundColor: theme.background,
          shadowColor: transparent,
          elevation: 0,
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: DrawerTile(
                      key: DrawerKey.get(DrawerKeyType.me),
                      leading: Image(
                        image: AssetImage(Assets.images.bearFace.path),
                        width: 25,
                      ),
                      title:
                          user.status == UserStatus.guest ? 'Guest' : 'Member',
                      onTap: () async {
                        final context = scaffoldKey.currentContext!;
                        context.pop();
                        if (user.status == UserStatus.guest) {
                          showCustomModalBottomSheet(
                            key: const Key('auth'),
                            context: context,
                            isScrollControlled: true,
                            child: (_) {
                              return const AuthPage();
                            },
                          );
                        }
                        if (user.status == UserStatus.member) {
                          showCustomModalBottomSheet(
                            key: const Key('my_page'),
                            context: context,
                            isScrollControlled: true,
                            horizontalPadding: 0,
                            isBottomNavigationBar: false,
                            child: (_) {
                              return const MyPage();
                            },
                            title: 'My Page',
                          );
                        }
                      },
                    ),
                  ),
                  // Container(
                  //   margin: const EdgeInsets.only(right: 10),
                  //   child: BaseButton(
                  //     onPressed: () {},
                  //     child: const BaseIcon(Symbols.settings_rounded),
                  //   ),
                  // ),
                ],
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.darkWhite,
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: AppColors.darkWhite,
                        width: 1,
                      ),
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                  child: SingleChildScrollView(
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        DrawerTile(
                          key: DrawerKey.get(DrawerKeyType.calendar),
                          leading: const BaseIcon(
                            Symbols.calendar_month_rounded,
                          ),
                          title: 'Calendar',
                          onTap: () {
                            closeDrawer();
                            notifier.updateSelectedKey(DrawerKey.get(
                              DrawerKeyType.calendar,
                            ));
                            todoNotifier.calculateMonthCellIndex();
                            appPageNotifier.updateState(
                              AppPageState(
                                appBarTitle: currentMonth.monthFormat(),
                                titleColor: theme.onBackground,
                                groupId: null,
                              ),
                            );
                            context.goNamed(
                              PageName.calendar,
                            );
                          },
                        ),
                        DrawerTile(
                          key: DrawerKey.get(DrawerKeyType.inbox),
                          leading: const BaseIcon(
                            Symbols.inbox_rounded,
                          ),
                          title: L10n.of.inbox,
                          onTap: () {
                            notifier.updateSelectedKey(DrawerKey.get(
                              DrawerKeyType.inbox,
                            ));
                            closeDrawer();
                            appPageNotifier.updateState(
                              AppPageState(
                                appBarTitle: l10n.inbox,
                                titleColor: theme.onBackground,
                              ),
                            );
                            context.goNamed(
                              PageName.groupDetail,
                              extra: {
                                NavExtra.property: 'groupId',
                                NavExtra.value: null,
                                NavExtra.key: DrawerKey.get(
                                  DrawerKeyType.inbox,
                                ),
                              },
                            );
                          },
                        ),
                        DrawerTile(
                          key: DrawerKey.get(DrawerKeyType.someday),
                          leading: const BaseIcon(
                            Symbols.edit_calendar_rounded,
                          ),
                          title: 'Someday',
                          onTap: () {
                            notifier.updateSelectedKey(DrawerKey.get(
                              DrawerKeyType.someday,
                            ));
                            closeDrawer();
                            appPageNotifier.updateState(
                              AppPageState(
                                appBarTitle: 'Someday',
                                titleColor: theme.onBackground,
                              ),
                            );
                            context.goNamed(
                              PageName.groupDetail,
                              extra: {
                                NavExtra.property: 'date',
                                NavExtra.value: null,
                                NavExtra.key: DrawerKey.get(
                                  DrawerKeyType.someday,
                                ),
                              },
                            );
                          },
                        ),
                        DrawerTile(
                          key: DrawerKey.get(DrawerKeyType.routine),
                          leading: const BaseIcon(
                            Symbols.routine_rounded,
                          ),
                          title: 'Routine',
                          onTap: () {
                            notifier.updateSelectedKey(DrawerKey.get(
                              DrawerKeyType.routine,
                            ));
                          },
                        ),
                        DrawerExpansionTile(
                          isOpen: ref.read(sharedPreferencesProvider).getBool(
                                  DrawerKey.get(DrawerKeyType.group)
                                      .toString()) ??
                              true,
                          key: DrawerKey.get(DrawerKeyType.group),
                          title: l10n.group,
                          leading: const BaseIcon(
                            Symbols.folder_rounded,
                          ),
                          trailing: BaseIcon(
                            Symbols.chevron_left_rounded,
                            color: theme.onBackground,
                          ),
                          isSelectedColor: false,
                          children: [
                            ReorderableListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
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
                              itemCount: groups.length,
                              onReorder: (int oldIndex, int newIndex) {
                                if (oldIndex < newIndex) {
                                  newIndex -= 1;
                                }
                                final GroupEntity? group =
                                    groups.removeAt(oldIndex);
                                groups.insert(newIndex, group);
                                for (GroupEntity? group in groups) {
                                  if (group == null) return;
                                  groups[groups.indexOf(group)] =
                                      group.copyWith(
                                    order: groups.indexOf(group),
                                  );
                                }
                                groupNotifier.updateGroups(groups);
                              },
                              itemBuilder: (BuildContext context, int index) {
                                final menuController = MenuController();

                                final group = groups[index];
                                if (group == null) {
                                  return const SizedBox();
                                }
                                final key = Key(group.id);

                                return DrawerTile(
                                  key: key,
                                  margin: EdgeInsets.zero,
                                  leading: AutoSizeText(
                                    group.emoji,
                                    style: AppTypography.h2,
                                  ),
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  color: group.color,
                                  title: group.name,
                                  trailing: Theme(
                                    data: Theme.of(context).copyWith(
                                      menuTheme: MenuThemeData(
                                        style: MenuStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            theme.background,
                                          ),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppBorders.radius),
                                            ),
                                          ),
                                          shadowColor:
                                              MaterialStateProperty.all(
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
                                      builder: (BuildContext context,
                                          MenuController controller,
                                          Widget? child) {
                                        return DefaultButton(
                                          height: 40,
                                          width: 40,
                                          builder: (isHover, opacity) =>
                                              BaseIcon(
                                            Symbols.more_horiz_rounded,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
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
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'Edit Group',
                                                    style: AppTypography.h5
                                                        .copyWith(
                                                      color: theme.onBackground
                                                          .withOpacity(
                                                        isHover ? opacity : 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              BaseIcon(
                                                Symbols.edit_rounded,
                                                color: theme.onBackground
                                                    .withOpacity(
                                                  isHover ? opacity : 1,
                                                ),
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                          height: 50,
                                          width: 250,
                                          onPressed: () {
                                            // inspect(menuController);
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
                                              onSaveButtonPressed:
                                                  (context, ref) {
                                                final AddGroupState
                                                    addGroupState = ref.read(
                                                        addGroupNotifierProvider);

                                                if (addGroupState
                                                    .formKey.currentState!
                                                    .validate()) {
                                                  final updatedGroup =
                                                      group.copyWith(
                                                    name: addGroupState.name,
                                                    emoji: addGroupState.emoji,
                                                    color: addGroupState.color,
                                                    updatedAt: now,
                                                  );

                                                  groupNotifier
                                                      .updateGroup(updatedGroup)
                                                      .then(
                                                        (value) =>
                                                            context.pop(),
                                                      );

                                                  final drawerState = ref.watch(
                                                      drawerNotifierProvider);
                                                  final appPageState = ref.watch(
                                                      appPageNotifierProvider);
                                                  if (drawerState.selectedKey ==
                                                      Key(group.id)) {
                                                    ref
                                                        .read(
                                                            appPageNotifierProvider
                                                                .notifier)
                                                        .updateState(
                                                          appPageState.copyWith(
                                                            appBarTitle:
                                                                '${updatedGroup.emoji} ${updatedGroup.name}',
                                                            titleColor:
                                                                updatedGroup
                                                                    .color,
                                                          ),
                                                        );
                                                  }
                                                }
                                              },
                                              child: (_) {
                                                return AddGroupPage(
                                                  group: group,
                                                  key: key,
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        Divider(
                                          color: theme.onBackground
                                              .withOpacity(0.2),
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
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    'Delete Group',
                                                    style: AppTypography.h5
                                                        .copyWith(
                                                      color: theme.secondary
                                                          .withOpacity(
                                                        isHover ? opacity : 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              BaseIcon(
                                                Symbols.delete_rounded,
                                                color:
                                                    theme.secondary.withOpacity(
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
                                            showCupertinoDialog(
                                              context: context,
                                              builder: (context) {
                                                return CupertinoAlertDialog(
                                                  title: Container(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                          text:
                                                              'Are you sure you want to delete ',
                                                          style: TextStyle(
                                                            color: theme
                                                                .onBackground,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              '${group.emoji}${group.name}',
                                                          style: AppTypography
                                                              .h5
                                                              .copyWith(
                                                            color: group.color,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text: ' group?',
                                                          style: TextStyle(
                                                            color: theme
                                                                .onBackground,
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
                                                        drawerNotifier
                                                            .updateSelectedKey(
                                                                DrawerKey.get(
                                                          DrawerKeyType
                                                              .calendar,
                                                        ));
                                                        appPageNotifier
                                                            .updateState(
                                                          AppPageState(
                                                            appBarTitle:
                                                                currentMonth
                                                                    .monthFormat(),
                                                            titleColor: theme
                                                                .onBackground,
                                                            groupId: null,
                                                          ),
                                                        );
                                                        context.goNamed(
                                                            PageName.calendar);
                                                        groupNotifier
                                                            .removeGroup(
                                                                group.id);
                                                        todoNotifier
                                                            .calculateMonthCellIndex();
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
                                  onTap: () {
                                    notifier.updateSelectedKey(key);
                                    closeDrawer();
                                    appPageNotifier.updateState(
                                      AppPageState(
                                        appBarTitle:
                                            '${group.emoji} ${group.name}',
                                        titleColor: group.color,
                                        groupId: group.id,
                                      ),
                                    );
                                    context.goNamed(
                                      PageName.groupDetail,
                                      extra: {
                                        NavExtra.property: 'groupId',
                                        NavExtra.value: group.id,
                                        NavExtra.key: key,
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                color: theme.background,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DrawerTile(
                      key: const Key('add_group'),
                      onTap: () {
                        const key = Key('add_group_page');
                        showCustomModalBottomSheet(
                          key: key,
                          context: context,
                          title: l10n.add_group,
                          isScrollControlled: true,
                          enableSaveButton: true,
                          initialSaveButtonState: false,
                          isBottomNavigationBar: false,
                          onSaveButtonPressed: (context, ref) {
                            final AddGroupState addGroupState =
                                ref.read(addGroupNotifierProvider);
                            if (addGroupState.formKey.currentState!
                                .validate()) {
                              final newGroup = GroupEntity(
                                id: const Uuid().v4(),
                                name: addGroupState.name,
                                emoji: addGroupState.emoji,
                                color: addGroupState.color,
                                todos: [],
                                createdAt: now,
                                updatedAt: now,
                              );
                              groupNotifier.addGroup(newGroup);
                            }
                            context.pop(true);
                          },
                          child: (_) {
                            return AddGroupPage(
                              key: key,
                            );
                          },
                        );
                      },
                      leading: const BaseIcon(
                        Symbols.list_alt_add_rounded,
                      ),
                      title: 'add group',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

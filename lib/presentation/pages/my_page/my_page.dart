import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/config/styles/app_themes.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/presentation/provider/datasources/auth_datasource.dart/auth_datasource.dart';

class MyPage extends HookConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.colorScheme;

    return SettingsList(
      lightTheme: SettingsThemeData(
        settingsListBackground: AppColors.darkWhite,
        settingsSectionBackground: theme.background,
        titleTextColor: theme.onBackground,
      ),
      shrinkWrap: true,
      sections: [
        // SettingsSection(
        //   tiles: [
        //     SettingsTile.navigation(
        //       leading: Icon(
        //         Symbols.person,
        //         size: 30,
        //         color: theme.onBackground,
        //       ),
        //       title: Text(
        //         'Account',
        //         style: AppTypography.h5,
        //       ),
        //       onPressed: (_) {
        //         showCustomModalBottomSheet(
        //           key: const Key('account_page'),
        //           context: context,
        //           title: 'Account',
        //           child: (_) {
        //             return const AccountPage();
        //           },
        //           horizontalPadding: 0,
        //           isScrollControlled: true,
        //           isBottomNavigationBar: false,
        //         );
        //       },
        //     ),
        //   ],
        // ),
        SettingsSection(
          title: Text(
            'Warning',
            style: AppTypography.h5,
          ),
          tiles: [
            SettingsTile(
              title: Text(
                'Sign out',
                style: AppTypography.h5.copyWith(
                  color: theme.error,
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: (_) {
                showCupertinoModalPopup(
                  context: context,
                  builder: (_) {
                    return CupertinoActionSheet(
                      title: Text(
                        'Sign out?',
                        style: AppTypography.h5,
                      ),
                      message: Text(
                        'Are you sure you want to sign out?',
                        style: AppTypography.body,
                      ),
                      actions: [
                        CupertinoActionSheetAction(
                          onPressed: () {
                            context.pop();
                            ref.read(authDataSourceProvider).signOut();
                          },
                          child: Text(
                            'Sign out',
                            style: TextStyle(
                              color: theme.error,
                            ),
                          ),
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            SettingsTile(
              title: Text(
                'Delete Account',
                style: AppTypography.h5.copyWith(
                  color: theme.error,
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: (_) {
                showCupertinoModalPopup(
                  context: context,
                  builder: (_) {
                    return CupertinoActionSheet(
                      title: Text(
                        'Delete Account?',
                        style: AppTypography.h5,
                      ),
                      message: Text(
                        'This action cannot be undone. \nThis will permanently delete your account. \nAre you sure?',
                        style: AppTypography.body,
                      ),
                      actions: [
                        CupertinoActionSheetAction(
                          onPressed: () {
                            context.pop();
                          },
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              color: theme.error,
                            ),
                          ),
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

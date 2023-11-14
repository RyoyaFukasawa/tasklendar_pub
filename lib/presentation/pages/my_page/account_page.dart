// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

// Project imports:
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/config/styles/app_themes.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/core/enums/auth_provider.dart';
import 'package:tasklendar/presentation/components/bottom_sheet/custom_modal_bottom_sheet.dart';
import 'package:tasklendar/presentation/notifier/global_vars/change_email/change_email_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/user/user_notifier.dart';
import 'package:tasklendar/presentation/pages/my_page/change_email_page.dart';
import 'package:tasklendar/presentation/state/user/user_state.dart';

class AccountPage extends HookConsumerWidget {
  const AccountPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserState userState = ref.watch(userNotifierProvider);
    final theme = AppTheme.colorScheme;

    return SettingsList(
      lightTheme: SettingsThemeData(
        settingsListBackground: AppColors.darkWhite,
        settingsSectionBackground: theme.background,
        titleTextColor: theme.onBackground,
      ),
      shrinkWrap: true,
      sections: [
        SettingsSection(
          title: const Text(
            'Email',
          ),
          tiles: [
            if (userState.authProvider == AuthProvider.email)
              SettingsTile.navigation(
                title: Text(
                  userState.email,
                  style: AppTypography.h5,
                ),
                onPressed: (_) {
                  showCustomModalBottomSheet(
                    key: const Key('change_email_page'),
                    title: 'Change Email',
                    context: context,
                    horizontalPadding: 0,
                    isScrollControlled: true,
                    enableSaveButton: true,
                    initialSaveButtonState: false,
                    onSaveButtonPressed: (BuildContext context, ref) {
                      final changeEmailNotifier =
                          ref.read(changeEmailNotifierProvider.notifier);

                      changeEmailNotifier.updateEmail();
                      context.pop(true);
                    },
                    child: (_) {
                      return const ChangeEmailPage(
                        key: Key('change_email_page'),
                      );
                    },
                  );
                },
              ),
          ],
        ),
        SettingsSection(
          tiles: [
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

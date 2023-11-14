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
import 'package:tasklendar/presentation/components/bottom_sheet/custom_modal_bottom_sheet.dart';
import 'package:tasklendar/presentation/navigation/page_navigation.dart';
import 'package:tasklendar/presentation/notifier/global_vars/snack_bar/snack_bar_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/my_page/my_page_notifier.dart';
import 'package:tasklendar/presentation/pages/delete_account/delete_account_page.dart';
import 'package:tasklendar/presentation/state/snack_bar/snack_bar_state.dart';

class MyPage extends HookConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.colorScheme;
    final MyPageNotifier viewModel = ref.read(myPageNotifierProvider.notifier);
    final SnackBarNotifier snackBarNotifier =
        ref.read(snackBarNotifierProvider.notifier);
    final SnackBarState snackBarState = ref.read(snackBarNotifierProvider);

    return SettingsList(
      lightTheme: SettingsThemeData(
        settingsListBackground: AppColors.darkWhite,
        settingsSectionBackground: theme.background,
        titleTextColor: theme.onBackground,
      ),
      shrinkWrap: true,
      sections: [
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
                            viewModel.signOut();
                            context.pop();
                            context.goNamed(PageName.signOut);
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
                showCustomModalBottomSheet(
                  key: const Key('delete_account'),
                  context: context,
                  isScrollControlled: true,
                  gradient: AppColors.gradient,
                  closeButtonColor: theme.onBackground,
                  child: (context) {
                    return const DeleteAccountPage();
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

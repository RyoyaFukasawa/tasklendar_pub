// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

// Project imports:
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/core/utils/screen.dart';
import 'package:tasklendar/presentation/components/button/middle_button.dart';
import 'package:tasklendar/presentation/components/icon/app_bar_icon.dart';
import 'package:tasklendar/presentation/navigation/page_navigation.dart';
import 'package:tasklendar/presentation/notifier/view_models/splash/splash_notifier.dart';

class SignOutCompletePage extends HookConsumerWidget {
  const SignOutCompletePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SplashNotifier splashNotifier =
        ref.watch(splashNotifierProvider.notifier);
    final screenWidth = Screen.width;

    return Scaffold(
      body: SizedBox(
        width: screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BaseIcon(
              Symbols.check_circle_filled_rounded,
              color: AppColors.green,
              size: 100,
            ),
            const SizedBox(height: 20),
            Text(
              'Complete Sign Out',
              style: AppTypography.h3,
            ),
            const SizedBox(height: 20),
            MiddleButton(
              onPressed: () async {
                await splashNotifier.initialized().then((value) {
                  context.goNamed(PageName.calendar);
                });
              },
              child: Text(
                'Back to Home',
                style: AppTypography.h4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

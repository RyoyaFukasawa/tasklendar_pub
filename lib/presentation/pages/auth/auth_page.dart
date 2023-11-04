// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:tasklendar/config/gen/assets.gen.dart';
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/core/utils/l10n.dart';
import 'package:tasklendar/presentation/components/bottom_sheet/custom_modal_bottom_sheet.dart';
import 'package:tasklendar/presentation/components/button/middle_button.dart';
import 'package:tasklendar/presentation/pages/auth/sign_in_page.dart';
import 'package:tasklendar/presentation/pages/auth/sign_up_page.dart';
import 'package:tasklendar/presentation/provider/global_vars/scaffold_key/scaffold_key.dart';

class AuthPage extends HookConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey = ref.watch(scaffoldKeyProvider);
    final theme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              L10n.of.welcome_to,
              style: AppTypography.h2,
              textAlign: TextAlign.center,
            ),
            const Gap(5),
            Container(
              constraints: const BoxConstraints(
                maxWidth: 350,
                maxHeight: 100,
              ),
              child: Image.asset(
                Assets.images.logo.path,
                height: 28,
              ),
            ),
          ],
        ),
        const Gap(20),
        Text(
          L10n.of.app_usage_notice,
          style: AppTypography.body.copyWith(
            decoration: TextDecoration.none,
          ),
          textAlign: TextAlign.center,
        ),
        const Gap(30),
        MiddleButton(
          onPressed: () {
            final context = scaffoldKey.currentContext!;
            context.pop();
            showCustomModalBottomSheet(
              key: const Key('sign_in'),
              context: context,
              child: (_) {
                return const SignInPage();
              },
              gradient: AppColors.gradient,
              closeButtonColor: theme.onBackground,
              isScrollControlled: true,
            );
          },
          child: Text(
            L10n.of.sign_in,
            style: AppTypography.h4.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        const Gap(20),
        MiddleButton(
          isBorder: true,
          onPressed: () {
            context.pop();
            showCustomModalBottomSheet(
              key: const Key('sign_up'),
              context: context,
              child: (_) {
                return const SignUpPage();
              },
              gradient: AppColors.gradient,
              closeButtonColor: theme.onBackground,
              isScrollControlled: true,
            );
          },
          backgroundColor: theme.background,
          child: Text(
            L10n.of.sign_up,
            style: AppTypography.h4.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

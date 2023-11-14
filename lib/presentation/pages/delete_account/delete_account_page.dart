// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

// Project imports:
import 'package:tasklendar/config/gen/assets.gen.dart';
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/config/styles/app_themes.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/core/enums/auth_provider.dart';
import 'package:tasklendar/core/utils/l10n.dart';
import 'package:tasklendar/core/utils/screen.dart';
import 'package:tasklendar/core/utils/validator.dart';
import 'package:tasklendar/presentation/components/button/middle_button.dart';
import 'package:tasklendar/presentation/components/button/social_button.dart';
import 'package:tasklendar/presentation/components/custom_loading/custom_loading.dart';
import 'package:tasklendar/presentation/components/icon/app_bar_icon.dart';
import 'package:tasklendar/presentation/components/text_field/base_text_field.dart';
import 'package:tasklendar/presentation/navigation/page_navigation.dart';
import 'package:tasklendar/presentation/notifier/global_vars/snack_bar/snack_bar_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/user/user_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/auth/sign_in_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/delete_account/delete_account_notifier.dart';
import 'package:tasklendar/presentation/state/auth/sign_in_state.dart';
import 'package:tasklendar/presentation/state/delete_account_page/delete_account_page_state.dart';
import 'package:tasklendar/presentation/state/snack_bar/snack_bar_state.dart';
import 'package:tasklendar/presentation/state/user/user_state.dart';

class DeleteAccountPage extends HookConsumerWidget {
  const DeleteAccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DeleteAccountNotifier viewModel =
        ref.watch(deleteAccountNotifierProvider.notifier);
    final DeleteAccountPageState state =
        ref.watch(deleteAccountNotifierProvider);
    final GlobalKey<FormState> formKey =
        useMemoized(() => GlobalKey<FormState>());
    final TextEditingController passwordController = useTextEditingController();
    final double screenHeight = Screen.height;
    final double screenWidth = Screen.width;
    final double screenKeyboard = Screen.keyboard;
    final theme = AppTheme.colorScheme;

    final SnackBarState snackBarState = ref.watch(snackBarNotifierProvider);
    final snackBarNotifier = ref.read(snackBarNotifierProvider.notifier);

    final UserState userState = ref.read(userNotifierProvider);

    Widget reAuthWidget() {
      switch (userState.authProvider) {
        case AuthProvider.email:
          return Form(
            key: formKey,
            child: SizedBox(
              width: screenWidth * 0.8,
              child: Column(
                children: [
                  const Gap(20),
                  state.isAuth
                      ? BaseIcon(
                          Symbols.check_circle_filled_rounded,
                          size: 50,
                          color: AppColors.green,
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                L10n.of.password,
                                style: AppTypography.body.copyWith(
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            const Gap(10),
                            BaseTextField(
                              controller: passwordController,
                              hintText: L10n.of.password,
                              useObscureText: true,
                              validator: (value) =>
                                  Validator.validatePassword(value!, context),
                              onChanged: (value) {
                                viewModel.updateState(
                                  state.copyWith(
                                    error: null,
                                  ),
                                );
                              },
                            ),
                            const Gap(5),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                L10n.of.password_rule,
                                style: AppTypography.body.copyWith(
                                  color: AppColors.placeholder,
                                ),
                              ),
                            ),
                            const Gap(20),
                            MiddleButton(
                              child: state.isLoading
                                  ? const CustomLoading()
                                  : Text(
                                      L10n.of.sign_in,
                                      style: AppTypography.h4,
                                    ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  viewModel.reEmailAndPasswordAuth(
                                      password: passwordController.text);
                                }
                              },
                            ),
                          ],
                        ),
                  const Gap(20),
                ],
              ),
            ),
          );
        case AuthProvider.google:
          return SizedBox(
            width: screenWidth * 0.8,
            child: Column(
              children: [
                const Gap(20),
                state.isAuth
                    ? BaseIcon(
                        Symbols.check_circle_filled_rounded,
                        size: 50,
                        color: AppColors.green,
                      )
                    : SocialButton(
                        icon: FontAwesomeIcons.google,
                        onPressed: () {
                          viewModel.reGoogleAuth();
                        },
                      ),
                const Gap(20),
              ],
            ),
          );
        default:
          return Container();
      }
    }

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: AppColors.gradient,
          ),
          constraints: BoxConstraints(
            maxHeight: screenHeight * 0.8,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Delete Account',
                              style: AppTypography.h1.copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ),
                            const Gap(5),
                            Image(
                              image: AssetImage(
                                  Assets.images.appIconTransparent.path),
                              width: 40,
                            ),
                          ],
                        ),
                        const Gap(5),
                        Text(
                          'This will permanently delete your account.',
                          style: AppTypography.body.copyWith(
                            color: Theme.of(context).colorScheme.background,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
                const Gap(30),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(13)),
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: Column(
                    children: [
                      const Gap(20),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Re Authentication',
                          style: AppTypography.h2,
                        ),
                      ),
                      const Gap(10),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          L10n.of.sign_in_continue,
                          style: AppTypography.body.copyWith(
                            color: AppColors.placeholder,
                          ),
                        ),
                      ),
                      if (state.error != null)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Gap(10),
                            Text(
                              state.error ?? '',
                              style: AppTypography.error,
                            ),
                          ],
                        ),
                      const Gap(20),
                      reAuthWidget(),
                      const Gap(20),
                      MiddleButton(
                        backgroundColor: state.isAuth
                            ? theme.secondary
                            : AppColors.placeholder,
                        onPressed: () async {
                          if (!state.isAuth) return null;
                          await viewModel.deleteAccount().then((value) {
                            context.goNamed(PageName.deleteAccountComplete);
                          });
                        },
                        child: Text(
                          'Delete',
                          style: AppTypography.h4,
                        ),
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
                Gap(screenKeyboard),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

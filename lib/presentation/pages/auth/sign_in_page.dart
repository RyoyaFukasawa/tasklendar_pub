// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tasklendar/config/gen/assets.gen.dart';

// Project imports:
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/core/utils/l10n.dart';
import 'package:tasklendar/core/utils/screen.dart';
import 'package:tasklendar/core/utils/validator.dart';
import 'package:tasklendar/presentation/components/button/middle_button.dart';
import 'package:tasklendar/presentation/components/button/social_button.dart';
import 'package:tasklendar/presentation/components/custom_loading/custom_loading.dart';
import 'package:tasklendar/presentation/components/text_field/base_text_field.dart';
import 'package:tasklendar/presentation/notifier/global_vars/snack_bar/snack_bar_notifier.dart';
import 'package:tasklendar/presentation/notifier/view_models/auth/sign_in_notifier.dart';
import 'package:tasklendar/presentation/state/auth/sign_in_state.dart';
import 'package:tasklendar/presentation/state/snack_bar/snack_bar_state.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignInNotifier viewModel = ref.watch(signInNotifierProvider.notifier);
    final SignInState state = ref.watch(signInNotifierProvider);
    final GlobalKey<FormState> formKey =
        useMemoized(() => GlobalKey<FormState>());
    final TextEditingController emailController = useTextEditingController();
    final TextEditingController passwordController = useTextEditingController();
    final double screenHeight = Screen.height;
    final double screenWidth = Screen.width;
    final double screenKeyboard = Screen.keyboard;

    final SnackBarState snackBarState = ref.watch(snackBarNotifierProvider);
    final snackBarNotifier = ref.read(snackBarNotifierProvider.notifier);

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
                              L10n.of.sign_in,
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
                          L10n.of.sign_in_sub,
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
                          L10n.of.welcome_back,
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
                      Form(
                        key: formKey,
                        child: SizedBox(
                          width: screenWidth * 0.8,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  L10n.of.email,
                                  style: AppTypography.body,
                                ),
                              ),
                              const Gap(10),
                              BaseTextField(
                                controller: emailController,
                                hintText: L10n.of.email,
                                validator: (value) =>
                                    Validator.validateEmail(value!, context),
                                onChanged: (value) {
                                  viewModel.updateState(
                                    state.copyWith(
                                      error: null,
                                    ),
                                  );
                                },
                              ),
                              const Gap(10),
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
                            ],
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
                            viewModel
                                .signIn(
                              email: emailController.text,
                              password: passwordController.text,
                            )
                                .then(
                              (value) {
                                if (value) {
                                  context.pop();
                                  snackBarNotifier.updateSnackBarStatus(
                                    snackBarState.copyWith(
                                      isShown: true,
                                      message:
                                          'Sign in success! Welcome back! 🎉',
                                    ),
                                  );
                                }
                                null;
                              },
                            );
                          }
                        },
                      ),
                      const Gap(20),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                          const Gap(10),
                          Text(
                            L10n.of.or_sign_in_with,
                            style: AppTypography.body,
                          ),
                          const Gap(10),
                          Expanded(
                            child: Divider(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ],
                      ),
                      const Gap(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialButton(
                            icon: FontAwesomeIcons.apple,
                            onPressed: () {},
                          ),
                          const Gap(20),
                          SocialButton(
                            icon: FontAwesomeIcons.google,
                            onPressed: () {
                              viewModel.signInWithGoogle().then(
                                (value) {
                                  if (value) {
                                    context.pop();
                                    snackBarNotifier.updateSnackBarStatus(
                                      snackBarState.copyWith(
                                        isShown: true,
                                        message:
                                            'Sign in success! Welcome back! 🎉',
                                      ),
                                    );
                                  }
                                  null;
                                },
                              );
                            },
                          ),
                        ],
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

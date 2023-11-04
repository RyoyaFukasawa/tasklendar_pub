import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/core/utils/l10n.dart';
import 'package:tasklendar/core/utils/screen.dart';
import 'package:tasklendar/core/utils/validator.dart';
import 'package:tasklendar/presentation/components/text_field/base_text_field.dart';
import 'package:tasklendar/presentation/notifier/global_vars/change_email/change_email_notifier.dart';
import 'package:tasklendar/presentation/notifier/global_vars/custom_modal_bottom_sheet/modal_bottom_sheet_notifier.dart';

class ChangeEmailPage extends HookConsumerWidget {
  const ChangeEmailPage({
    required Key key,
  })  : _key = key,
        super(key: key);

  final Key _key;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = Screen.height;
    final screenWidth = Screen.width;
    final TextEditingController newEmailController = useTextEditingController();
    final TextEditingController passwordController = useTextEditingController();
    final notifier = ref.read(changeEmailNotifierProvider.notifier);
    final state = ref.watch(changeEmailNotifierProvider);
    final modalBottomSheetNotifier =
        ref.read(modalBottomSheetNotifierProvider.notifier);

    final validateState = useState({
      'email': false,
      'password': false,
    });

    return Container(
      height: screenHeight * 0.5,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Form(
        key: state.formKey,
        child: SizedBox(
          width: screenWidth * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(20),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'New Email',
                  style: AppTypography.body,
                ),
              ),
              const Gap(10),
              BaseTextField(
                controller: newEmailController,
                hintText: 'tasklendar@todo.com',
                validator: (value) {
                  final String? error =
                      Validator.validateEmail(value!, context);
                  validateState.value['email'] = error == null;
                  return error;
                },
                onChanged: (value) {
                  notifier.updateState(
                    state.copyWith(
                      newEmail: value,
                    ),
                  );
                  final modalState = modalBottomSheetNotifier.getState(
                    _key,
                  );
                  if (modalState != null) {
                    modalBottomSheetNotifier.updateState(
                      _key,
                      modalState.copyWith(
                        isSave: validateState.value['email']! &&
                            validateState.value['password']!,
                      ),
                    );
                  }
                },
                autoFocus: true,
              ),
              const Gap(10),
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Password',
                  style: AppTypography.body,
                ),
              ),
              const Gap(10),
              BaseTextField(
                controller: passwordController,
                hintText: 'Password',
                useObscureText: true,
                validator: (value) {
                  final String? error =
                      Validator.validatePassword(value!, context);
                  validateState.value['password'] = error == null;
                  return error;
                },
                onChanged: (value) {
                  notifier.updateState(
                    state.copyWith(
                      password: value,
                    ),
                  );
                  final modalState = modalBottomSheetNotifier.getState(
                    _key,
                  );
                  if (modalState != null) {
                    modalBottomSheetNotifier.updateState(
                      _key,
                      modalState.copyWith(
                        isSave: validateState.value['email']! &&
                            validateState.value['password']!,
                      ),
                    );
                  }
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
    );
  }
}

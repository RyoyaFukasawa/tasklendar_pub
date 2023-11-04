// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

// Project imports:
import 'package:tasklendar/config/styles/app_borders.dart';
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/config/styles/app_opacity.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/presentation/components/default_design/default_button.dart';
import 'package:tasklendar/presentation/components/icon/app_bar_icon.dart';
import 'package:tasklendar/presentation/notifier/global_vars/custom_modal_bottom_sheet/modal_bottom_sheet_notifier.dart';
import 'package:tasklendar/presentation/state/custom_modal_bottom_sheet/modal_bottom_sheet_state.dart';

showCustomModalBottomSheet({
  required BuildContext context,
  required WidgetBuilder child,
  required Key key,
  Gradient? gradient,
  Color? closeButtonColor,
  bool? isScrollControlled,
  String? title,
  bool useTopBar = true,
  double horizontalPadding = 20,
  bool isBottomNavigationBar = true,
  bool isDismissible = true,
  bool enableSaveButton = false,
  bool initialSaveButtonState = true,
  Function(BuildContext context, WidgetRef ref)? onSaveButtonPressed,
}) {
  return showModalBottomSheet(
    isScrollControlled: isScrollControlled ?? false,
    context: context,
    isDismissible: isDismissible,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        AppBorders.radius,
      ),
    ),
    barrierColor: Theme.of(context).colorScheme.onBackground.withOpacity(
          AppOpacity.barrier,
        ),
    builder: (buildContext) => Consumer(
      key: key,
      builder: (context, ref, child) {
        final modalBottomSheetState =
            ref.watch(modalBottomSheetNotifierProvider);

        ModalBottomSheetState? state = modalBottomSheetState[key];

        if (state == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final newState = ModalBottomSheetState(
              isSave: initialSaveButtonState,
            );
            ref.read(modalBottomSheetNotifierProvider.notifier).updateState(
                  key,
                  newState,
                );
          });
        }

        return Container(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(
              AppBorders.radius,
            ),
            color: Theme.of(context).colorScheme.background,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (useTopBar)
                Container(
                  height: kToolbarHeight,
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: enableSaveButton
                      ? Row(
                          children: [
                            const Gap(20),
                            DefaultButton(
                              builder: (isHover, opacity) => Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.darkWhite,
                                ),
                                width: 30,
                                height: 30,
                                child: BaseIcon(
                                  Symbols.close_rounded,
                                  color: isHover
                                      ? closeButtonColor
                                              ?.withOpacity(opacity) ??
                                          AppColors.black.withOpacity(opacity)
                                      : closeButtonColor ?? AppColors.black,
                                  weight: 600,
                                  size: 23,
                                ),
                              ),
                              shape: BoxShape.circle,
                              onPressed: () {
                                buildContext.pop();
                              },
                            ),
                            const Spacer(),
                            if (title != null)
                              Transform.translate(
                                offset: const Offset(10, 0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    title,
                                    style: AppTypography.h3,
                                  ),
                                ),
                              ),
                            const Spacer(),
                            DefaultButton(
                              width: 50,
                              height: 30,
                              alignment: Alignment.center,
                              builder: (isHover, opacity) => Text(
                                'Done',
                                style: AppTypography.h5.copyWith(
                                  color: state?.isSave ?? false
                                      ? Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(
                                            isHover ? opacity : 1,
                                          )
                                      : Theme.of(context)
                                          .colorScheme
                                          .onBackground
                                          .withOpacity(AppOpacity.disabled),
                                ),
                              ),
                              onPressed: () {
                                if (state?.isSave == null) {
                                  return;
                                } else if (!state!.isSave) {
                                  return;
                                }
                                onSaveButtonPressed?.call(context, ref);
                              },
                            ),
                            const Gap(20),
                          ],
                        )
                      : Row(
                          children: [
                            const Gap(20),
                            if (title != null)
                              Text(
                                title,
                                style: AppTypography.h3,
                              ),
                            const Spacer(),
                            DefaultButton(
                              builder: (isHover, opacity) => Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.darkWhite,
                                ),
                                width: 30,
                                height: 30,
                                child: BaseIcon(
                                  Symbols.close_rounded,
                                  color: isHover
                                      ? closeButtonColor
                                              ?.withOpacity(opacity) ??
                                          AppColors.black.withOpacity(opacity)
                                      : closeButtonColor ?? AppColors.black,
                                  weight: 600,
                                  size: 23,
                                ),
                              ),
                              shape: BoxShape.circle,
                              onPressed: () {
                                buildContext.pop();
                              },
                            ),
                            const Gap(20),
                          ],
                        ),
                ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                // child: child(buildContext),
                child: child,
              ),
              if (isBottomNavigationBar) const Gap(kBottomNavigationBarHeight),
            ],
          ),
        );
      },
      child: child(buildContext),
    ),
  );
}

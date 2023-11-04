// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

// Project imports:
import 'package:tasklendar/config/styles/app_borders.dart';
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/config/styles/app_themes.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/core/extension/int_extension.dart';
import 'package:tasklendar/core/extension/string_extension.dart';
import 'package:tasklendar/core/utils/l10n.dart';
import 'package:tasklendar/core/utils/screen.dart';
import 'package:tasklendar/presentation/components/default_design/default_button.dart';
import 'package:tasklendar/presentation/components/icon/app_bar_icon.dart';
import 'package:tasklendar/presentation/components/text_field/base_text_field.dart';
import 'package:tasklendar/presentation/notifier/global_vars/select_color/select_color_notifier.dart';

class SelectColorPage extends HookConsumerWidget {
  const SelectColorPage({
    super.key,
    required Color initialColor,
  }) : _initialColor = initialColor;

  final Color _initialColor;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SelectColorNotifier selectColorNotifier =
        ref.watch(selectColorNotifierProvider.notifier);
    final Color selectedColor = ref.watch(selectColorNotifierProvider);
    final screenWidth = Screen.width;
    final screenHeight = Screen.height;
    final l10n = L10n.of;
    final theme = AppTheme.colorScheme;

    final hexController = useTextEditingController(
      text: _initialColor.value.toHexColorStr(),
    );

    final keyboardHeight = Screen.keyboard;

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        selectColorNotifier.updateState(_initialColor);
      });
      return null;
    }, []);

    return Container(
      width: screenWidth * 0.8,
      padding: EdgeInsets.only(
        bottom: keyboardHeight,
      ),
      child: Column(
        children: [
          const Gap(10),
          ColorPicker(
            padding: const EdgeInsets.all(0),
            wheelSquareBorderRadius: AppBorders.radius,
            hasBorder: false,
            borderRadius: AppBorders.radius,
            onColorChanged: (Color color) {
              selectColorNotifier.updateState(color);
              hexController.text = color.value.toHexColorStr();
            },
            color: selectedColor,
            enableShadesSelection: false,
            pickersEnabled: const <ColorPickerType, bool>{
              ColorPickerType.primary: false,
              ColorPickerType.accent: false,
              ColorPickerType.wheel: true,
              ColorPickerType.custom: false,
            },
            pickerTypeTextStyle: AppTypography.h5.copyWith(
              color: AppColors.placeholder,
            ),
            colorCodeHasColor: true,
            wheelDiameter: 180,
            selectedPickerTypeColor: AppColors.white,
            selectedColorIcon: Symbols.check_rounded,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 150,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Hex',
                        style: AppTypography.body,
                      ),
                    ),
                    const Gap(5),
                    SizedBox(
                      child: BaseTextField(
                        controller: hexController,
                        onChanged: (value) {
                          if (value.isValidHexColor()) {
                            String hexColor = value;
                            if (hexColor.startsWith('#')) {
                              hexColor = hexColor.substring(1);
                            }
                            selectColorNotifier.updateState(
                              Color(
                                int.parse(
                                  "ff$hexColor",
                                  radix: 16,
                                ),
                              ),
                            );
                          }
                        },
                        hintText: 'Hex',
                        fillColor: selectedColor,
                        textColor: _getTextColorForBackground(
                          selectedColor,
                        ),
                        cursorColor: _getTextColorForBackground(
                          selectedColor,
                        ),
                        autoFocus: true,
                      ),
                    ),
                  ],
                ),
              ),
              DefaultButton(
                onPressed: () {
                  Clipboard.setData(
                    ClipboardData(
                      text: hexController.text,
                    ),
                  );
                  final beforeText = hexController.text;
                  hexController.text = 'Copied!';
                  Future.delayed(
                    const Duration(
                      seconds: 1,
                    ),
                    () {
                      hexController.text = beforeText;
                    },
                  );
                },
                builder: (isHover, opacity) => BaseIcon(
                  Symbols.content_copy_rounded,
                  color: theme.onBackground.withOpacity(
                    isHover ? opacity : 1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getTextColorForBackground(Color backgroundColor) {
    // テキストカラーを選択するための閾値
    const threshold = 0.5;

    // 背景色の明るさを計算
    final brightness = backgroundColor.computeLuminance();

    // コントラスト比を計算
    final contrast = (brightness > threshold) ? Colors.black : Colors.white;

    return contrast;
  }
}

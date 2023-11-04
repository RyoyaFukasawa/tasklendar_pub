// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

// Project imports:
import 'package:tasklendar/config/styles/app_themes.dart';
import 'package:tasklendar/presentation/components/icon/app_bar_icon.dart';

class CustomCheckBox extends HookConsumerWidget {
  const CustomCheckBox({
    super.key,
    required this.isCheck,
  });

  final bool isCheck;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme theme = AppTheme.colorScheme;

    return Stack(
      children: [
        Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.3,
              color: theme.onBackground,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(
          height: 25,
          width: 25,
          child: Center(
            child: BaseIcon(
              isCheck ? Symbols.done_rounded : null,
              size: 25,
              color: theme.onBackground,
              weight: 500,
            ),
          ),
        ),
      ],
    );
  }
}

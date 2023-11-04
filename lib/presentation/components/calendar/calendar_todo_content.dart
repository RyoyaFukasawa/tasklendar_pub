// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:tasklendar/config/styles/app_typography.dart';

class CalendarTodoContent extends HookConsumerWidget {
  const CalendarTodoContent({
    super.key,
    required this.height,
    required this.width,
    required this.backgroundColor,
    required this.name,
    required this.color,
  });

  final double height;
  final double width;
  final Color backgroundColor;
  final String name;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        name,
        style: AppTypography.calendarTodo.copyWith(
          // color: AppTheme.colorScheme.background,
          color: getTextColorForBackground(
            color,
          ),
        ),
        maxLines: 1,
      ),
    );
  }

  Color getTextColorForBackground(Color backgroundColor) {
    // テキストカラーを選択するための閾値
    const threshold = 0.5;

    // 背景色の明るさを計算
    final brightness = backgroundColor.computeLuminance();

    // コントラスト比を計算
    final contrast = (brightness > threshold) ? Colors.black : Colors.white;

    return contrast;
  }
}

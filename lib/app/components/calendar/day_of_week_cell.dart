import 'package:flutter/material.dart';
import 'package:tasklendar/app/styles/app_typography.dart';
import 'package:tasklendar/app/theme/theme.dart';

class DayOfWeekCell extends StatelessWidget {
  const DayOfWeekCell({
    super.key,
    @required this.dayOfWeek,
  });

  final String? dayOfWeek;

  @override
  Widget build(Object context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Text(
          dayOfWeek!,
          style: TextStyle(
            color: AppTheme.colorScheme.onPrimary,
            fontSize: 15,
            fontFamily: AppTypography.getPreferredFont(),
          ),
        ),
      ),
    );
  }
}

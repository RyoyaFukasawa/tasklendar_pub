// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:tasklendar/core/enums/snack_bar_type.dart';

showCustomSnackBar({
  required BuildContext context,
  required Widget content,
  required SnackBarType type,
}) {
  Color switchBackGroundColor() {
    switch (type) {
      case SnackBarType.success:
        return Theme.of(context).colorScheme.tertiary;
      case SnackBarType.delete:
        return Theme.of(context).colorScheme.error;
      default:
        return Theme.of(context).colorScheme.error;
    }
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: content,
      backgroundColor: switchBackGroundColor(),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

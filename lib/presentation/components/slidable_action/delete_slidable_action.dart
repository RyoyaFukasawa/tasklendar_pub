// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

// Project imports:
import 'package:tasklendar/config/styles/app_themes.dart';

class DeleteSlidableAction extends HookConsumerWidget {
  const DeleteSlidableAction({
    super.key,
    this.onPressed,
  });

  final void Function(BuildContext)? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.colorScheme;

    return SlidableAction(
      onPressed: onPressed,
      backgroundColor: theme.secondary,
      foregroundColor: theme.onSecondary,
      icon: Symbols.delete_rounded,
    );
  }
}

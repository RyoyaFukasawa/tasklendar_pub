// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

// Project imports:
import 'package:tasklendar/config/styles/app_themes.dart';
import 'package:tasklendar/presentation/components/bottom_sheet/custom_modal_bottom_sheet.dart';
import 'package:tasklendar/presentation/components/icon/app_bar_icon.dart';
import 'package:tasklendar/presentation/notifier/view_models/app_page/app_page_notifier.dart';
import 'package:tasklendar/presentation/pages/add_todo/add_todo_page.dart';
import 'package:tasklendar/presentation/state/app_page/app_page_state.dart';

class CustomFloatingActionButton extends HookConsumerWidget {
  const CustomFloatingActionButton({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppPageState appPageState = ref.watch(appPageNotifierProvider);
    final ColorScheme theme = AppTheme.colorScheme;

    return FloatingActionButton(
      focusElevation: 1,
      hoverElevation: 1,
      disabledElevation: 1,
      highlightElevation: 1,
      backgroundColor: theme.background,
      elevation: 1,
      onPressed: () {
        showCustomModalBottomSheet(
          key: const Key('add_todo_modal_bottom_sheet'),
          context: context,
          child: (_) => AddTodoPage(
            groupId: appPageState.groupId,
            selectedDate: appPageState.selectedDate,
          ),
          isBottomNavigationBar: false,
          isScrollControlled: true,
          useTopBar: false,
          horizontalPadding: 0,
        );
      },
      child: BaseIcon(
        Symbols.edit_rounded,
        color: theme.primary,
        size: 30,
      ),
    );
  }
}

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/presentation/notifier/view_models/drawer/drawer_notifier.dart';
import 'package:tasklendar/presentation/provider/global_vars/shared_preferences/shared_preferences.dart';

class DrawerExpansionTile extends HookConsumerWidget {
  DrawerExpansionTile({
    required super.key,
    required this.title,
    required this.leading,
    this.onExpansionChanged,
    this.trailing,
    this.isExpanded = false,
    this.color,
    this.children = const [],
    this.isSelectedColor = true,
    this.margin = const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
    required this.isOpen,
  });

  final Function(bool)? onExpansionChanged;
  final Widget leading;
  final String title;
  final Widget? trailing;
  final bool isExpanded;
  final Color? color;
  final List<Widget> children;
  final bool isSelectedColor;
  final EdgeInsets margin;
  final bool isOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(drawerNotifierProvider);
    final notifier = ref.read(drawerNotifierProvider.notifier);
    final isOpenStatus = useState(isOpen);

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          if (isSelectedColor)
            Positioned(
              right: 0,
              left: 0,
              top: 0,
              bottom: 0,
              child: AnimatedOpacity(
                duration: const Duration(microseconds: 80000),
                opacity: state == key ? 1 : 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(.2),
                  ),
                ),
              ),
            ),
          ExpansionTile(
            initiallyExpanded: isOpenStatus.value,
            tilePadding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 10,
            ),
            childrenPadding: const EdgeInsets.only(
              top: 0,
            ),
            key: key,
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: leading,
              ),
            ),
            title: Text(
              title,
              style: AppTypography.h5.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: AnimatedRotation(
              turns: isOpenStatus.value ? 0.25 : 0,
              duration: const Duration(milliseconds: 250),
              child: trailing,
            ),
            onExpansionChanged: (bool value) {
              isOpenStatus.value = value;
              ref.read(sharedPreferencesProvider).setBool(
                    key.toString(),
                    value,
                  );
              if (onExpansionChanged != null) {
                onExpansionChanged!(value);
              }
            },
            children: children,
          ),
        ],
      ),
    );
  }
}

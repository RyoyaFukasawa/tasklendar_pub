// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/presentation/notifier/view_models/drawer/drawer_notifier.dart';
import 'package:tasklendar/presentation/state/drawer/drawer_state.dart';

class DrawerTile extends HookConsumerWidget {
  DrawerTile({
    super.key,
    required this.title,
    required this.leading,
    this.onTap,
    this.trailing,
    this.gradient,
    this.color,
    this.backgroundColor,
    this.margin = const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
    this.borderRadius = 10,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
  });

  final Function()? onTap;
  final Widget leading;
  final String title;
  final Widget? trailing;
  final Gradient? gradient;
  final Color? color;
  final Color? backgroundColor;
  final EdgeInsets margin;
  final double borderRadius;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DrawerState state = ref.watch(drawerNotifierProvider);
    final notifier = ref.read(drawerNotifierProvider.notifier);

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor,
      ),
      child: Stack(
        children: [
          Positioned(
            left: 5,
            top: 10,
            bottom: 10,
            child: Container(
              width: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: color,
                gradient: gradient,
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            top: 0,
            bottom: 0,
            child: AnimatedOpacity(
              duration: const Duration(microseconds: 80000),
              opacity: state.selectedKey == key ? 1 : 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  color: color?.withOpacity(.3) ?? AppColors.darkWhite,
                ),
              ),
            ),
          ),
          ListTile(
            key: key,
            contentPadding: padding,
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: gradient,
                // color: color,
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
            trailing: trailing,
            onTap: () {
              onTap!();
            },
          ),
        ],
      ),
    );
  }
}

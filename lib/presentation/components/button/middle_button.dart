// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:tasklendar/presentation/components/button/base_button.dart';

class MiddleButton extends ConsumerWidget {
  const MiddleButton({
    super.key,
    required Function()? onPressed,
    bool isBorder = false,
    Color? borderColor,
    required Widget child,
    Color? backgroundColor,
  })  : _onPressed = onPressed,
        _isBorder = isBorder,
        _borderColor = borderColor,
        _child = child,
        _backgroundColor = backgroundColor;

  final Function()? _onPressed;
  final bool _isBorder;
  final Color? _borderColor;
  final Widget _child;
  final Color? _backgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 350,
      ),
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        color: _backgroundColor ?? Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(30),
        border: _isBorder
            ? Border.all(
                color: _borderColor ?? Theme.of(context).colorScheme.primary,
              )
            : null,
      ),
      child: BaseButton(
        onPressed: _onPressed,
        width: double.infinity,
        radius: BorderRadius.circular(30),
        child: _child,
      ),
    );
  }
}

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:tasklendar/config/constraints/utils.dart';

class BaseButton extends HookConsumerWidget {
  const BaseButton({
    super.key,
    required Function()? onPressed,
    double? height,
    double? width,
    BorderRadiusGeometry? radius,
    required Widget child,
    Color? backgroundColor,
  })  : _onPressed = onPressed,
        _child = child,
        _height = height,
        _width = width,
        _radius = radius,
        _backgroundColor = backgroundColor;

  final Function()? _onPressed;
  final Widget _child;
  final double? _height;
  final double? _width;
  final BorderRadiusGeometry? _radius;
  final Color? _backgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: _height ?? 44,
      width: _width ?? 44,
      child: ElevatedButton(
        onPressed: _onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _backgroundColor ?? transparent,
          surfaceTintColor: transparent,
          shadowColor: transparent,
          shape: RoundedRectangleBorder(
            borderRadius: _radius ?? BorderRadius.circular(0),
          ),
          splashFactory: NoSplash.splashFactory,
          elevation: 0,
          padding: EdgeInsets.zero,
        ),
        child: _child,
      ),
    );
  }
}

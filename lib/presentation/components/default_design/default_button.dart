// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DefaultButton extends HookConsumerWidget {
  const DefaultButton({
    super.key,
    required Function(bool, double) builder,
    required Function() onPressed,
    Border? border,
    BorderRadiusGeometry? borderRadius,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    double? height,
    double? width,
    BoxShape? shape,
    BoxConstraints? constraints,
    Function(TapDownDetails)? onTapDown,
    AlignmentGeometry? alignment,
  })  : _builder = builder,
        _border = border,
        _borderRadius = borderRadius,
        _onPressed = onPressed,
        _backgroundColor = backgroundColor,
        _padding = padding,
        _height = height,
        _width = width,
        _shape = shape,
        _boxConstraints = constraints,
        _onTapDown = onTapDown,
        _alignment = alignment;

  final Function(bool, double) _builder;
  final Border? _border;
  final BorderRadiusGeometry? _borderRadius;
  final Function()? _onPressed;
  final Color? _backgroundColor;
  final EdgeInsetsGeometry? _padding;
  final double? _height;
  final double? _width;
  final BoxShape? _shape;
  final BoxConstraints? _boxConstraints;
  final Function(TapDownDetails)? _onTapDown;
  final AlignmentGeometry? _alignment;

  final double opacity = 0.5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> isHover = useState(false);

    return GestureDetector(
      onTap: () {
        Future.delayed(const Duration(milliseconds: 100), () {
          _onPressed?.call();
        });
      },
      onTapDown: (_) {
        _onTapDown?.call(_);
        isHover.value = true;
      },
      onTapUp: (_) {
        Future.delayed(const Duration(milliseconds: 50), () {
          isHover.value = false;
        });
      },
      onTapCancel: () {
        Future.delayed(const Duration(milliseconds: 50), () {
          isHover.value = false;
        });
      },
      child: Container(
        padding: _padding,
        height: _height,
        width: _width,
        constraints: _boxConstraints,
        decoration: BoxDecoration(
          color: color(_backgroundColor, isHover.value),
          borderRadius: _borderRadius,
          border: _border,
          shape: _shape ?? BoxShape.rectangle,
        ),
        alignment: _alignment,
        child: _builder(isHover.value, opacity),
      ),
    );
  }

  Color? color(Color? color, bool isHover) {
    if (color != null) {
      return isHover ? color.withOpacity(opacity) : color;
    }
    return null;
  }
}

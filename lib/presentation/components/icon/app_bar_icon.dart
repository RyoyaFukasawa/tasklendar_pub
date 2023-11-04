// Flutter imports:
import 'package:flutter/material.dart';

class BaseIcon extends StatelessWidget {
  const BaseIcon(
    IconData? icon, {
    super.key,
    Color? color,
    double size = 30,
    double? weight,
    double fill = 0,
  })  : _icon = icon,
        _color = color,
        _size = size,
        _weight = weight,
        _fill = fill;

  final IconData? _icon;
  final Color? _color;
  final double _size;
  final double? _weight;
  final double _fill;

  @override
  Widget build(BuildContext context) {
    return Icon(
      _icon,
      color: _color ?? Theme.of(context).colorScheme.onBackground,
      size: _size,
      weight: _weight,
      fill: _fill,
    );
  }
}

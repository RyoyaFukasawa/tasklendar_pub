import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  double? size;
  double? iconSize;
  Color? backgroundColor;
  Color? iconColor;
  Color? borderColor;
  IconData? icon;
  bool isChecked;
  BorderRadius? borderRadius;
  double? borderWidth;

  CustomCheckbox({
    Key? key,
    this.size,
    this.iconSize,
    this.backgroundColor,
    this.iconColor,
    this.icon,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    required this.isChecked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: size ?? 28,
      width: size ?? 28,
      duration: const Duration(seconds: 5),
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(5),
        color: isChecked ? backgroundColor : Colors.transparent,
        border: Border.all(
          width: borderWidth ?? 1,
          color: borderColor ?? Colors.black,
        ),
      ),
      child: isChecked
          ? Icon(
              icon ?? Icons.check,
              color: iconColor ?? Colors.black,
              size: iconSize ?? 29,
            )
          : null,
    );
  }
}

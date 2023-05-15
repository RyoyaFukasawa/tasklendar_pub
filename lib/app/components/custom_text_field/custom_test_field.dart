import 'package:flutter/material.dart';
import 'package:tasklendar/app/styles/app_typography.dart';
import 'package:tasklendar/app/theme/theme.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.labelText,
    this.obscureText,
    this.validator,
    this.onSaved,
    this.suffixIcon,
    this.focusNode,
    this.onTap,
    this.autofocus,
    required this.controller,
  });

  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final Function(String?)? onSaved;
  final Function()? onTap;
  final String? hintText;
  final String? labelText;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool? autofocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        fontFamily: 'EbiharaNoKuseji',
        fontSize: 18,
      ),
      autocorrect: false,
      autofocus: autofocus ?? false,
      cursorColor: AppTheme.colorScheme.onPrimary,
      cursorRadius: const Radius.circular(500),
      cursorWidth: 1,
      focusNode: focusNode,
      obscureText: obscureText ?? false,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText ?? '',
        //TODO 削除予定
        // hintStyle: TextStyle(
        //   color: Styles.disable,
        // ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.colorScheme.onPrimary,
            width: 1.5,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppTheme.colorScheme.onPrimary,
            width: 1.5,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: labelText,
        labelStyle: TextStyle(
          color: AppTheme.colorScheme.onPrimary,
          fontFamily: AppTypography.getPreferredFont(),
          fontSize: 20,
        ),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      onSaved: onSaved,
      onTap: onTap,
    );
  }
}

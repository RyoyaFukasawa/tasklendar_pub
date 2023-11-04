// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

// Project imports:
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/config/styles/app_typography.dart';
import 'package:tasklendar/presentation/components/button/base_button.dart';

class BaseTextField extends HookConsumerWidget {
  const BaseTextField({
    super.key,
    required TextEditingController controller,
    required String hintText,
    String? Function(String?)? validator,
    bool? useObscureText = false,
    void Function(String)? onChanged,
    void Function(String)? onFieldSubmitted,
    int? maxLength,
    bool autoFocus = false,
    Color? fillColor,
    Color? textColor,
    Color? cursorColor,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
  })  : _controller = controller,
        _hintText = hintText,
        _useObscureText = useObscureText,
        _validator = validator,
        _onChanged = onChanged,
        _onFieldSubmitted = onFieldSubmitted,
        _maxLength = maxLength,
        _autoFocus = autoFocus,
        _fillColor = fillColor,
        _textColor = textColor,
        _cursorColor = cursorColor,
        _keyboardType = keyboardType,
        _textInputAction = textInputAction;

  final TextEditingController _controller;
  final String _hintText;
  final bool? _useObscureText;
  final String? Function(String?)? _validator;
  final void Function(String)? _onChanged;
  final void Function(String)? _onFieldSubmitted;
  final int? _maxLength;
  final bool _autoFocus;
  final Color? _fillColor;
  final Color? _textColor;
  final Color? _cursorColor;
  final TextInputType? _keyboardType;
  final TextInputAction? _textInputAction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<bool> obscureText = useState(true);
    return TextFormField(
      style: AppTypography.body.copyWith(
        color: _textColor,
      ),
      textInputAction: _textInputAction,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: _keyboardType,
      cursorColor: _cursorColor,
      controller: _controller,
      maxLength: _maxLength,
      autofocus: _autoFocus,
      decoration: InputDecoration(
        isDense: true,
        hintText: _hintText,
        hintStyle: AppTypography.body.copyWith(
          color: AppColors.placeholder,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.only(
          top: 10,
          bottom: 8,
          right: 10,
          left: 10,
        ),
        fillColor: _fillColor,
        filled: true,
        errorStyle: AppTypography.error,
        suffixIcon: _useObscureText == true
            ? BaseButton(
                onPressed: () {
                  obscureText.value = !obscureText.value;
                },
                child: Icon(
                  obscureText.value
                      ? Symbols.visibility_rounded
                      : Symbols.visibility_off_rounded,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              )
            : null,
        suffixIconConstraints: BoxConstraints(
          maxHeight: 30,
          maxWidth: 40,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
      obscureText: _useObscureText! ? obscureText.value : false,
      validator: _validator,
      onChanged: _onChanged,
      onFieldSubmitted: _onFieldSubmitted,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}

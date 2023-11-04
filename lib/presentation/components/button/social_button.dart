// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:tasklendar/config/styles/app_colors.dart';
import 'package:tasklendar/presentation/components/button/base_button.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required IconData icon,
    Function()? onPressed,
  })  : _icon = icon,
        _onPressed = onPressed;

  final IconData _icon;
  final Function()? _onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: BaseButton(
        width: 50,
        height: 50,
        radius: BorderRadius.circular(10),
        onPressed: _onPressed,
        child: Icon(
          _icon,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/components/custom_bottom_navigation/controllers/custom_bottom_navigation_controller.dart';
import 'package:tasklendar/app/styles/app_typography.dart';
import 'package:tasklendar/app/theme/theme.dart';

class CustomBottomNavigation
    extends GetView<CustomBottomNavigationController> {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.check),
            label: 'Todo',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.calendar),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.mountain),
            label: 'Routine',
          ),
        ],
        currentIndex: controller.currentIndex.value,
        selectedItemColor: AppTheme.colorScheme.tertiary,
        onTap: controller.changePage,
        selectedLabelStyle: TextStyle(
          fontFamily: AppTypography.getPreferredFont(),
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: AppTypography.getPreferredFont(),
        ),
      ),
    );
  }
}

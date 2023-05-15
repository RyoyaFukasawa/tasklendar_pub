import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/components/drawer_list/controller/drawer_list_controller.dart';
import 'package:tasklendar/app/styles/app_typography.dart';
import 'package:tasklendar/generated/locales.g.dart';

class DrawerList extends GetView<DrawerListController> {
  const DrawerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: TextButton(
        child: Text(
          LocaleKeys.logout.tr,
          style: AppTypography.h5,
        ),
        onPressed: () {
          controller.signOut();
        },
      ),
      // child: ListView(
      //   children: [
      //     Container(
      //     ),
      //   ],
      // ),
    );
  }
}

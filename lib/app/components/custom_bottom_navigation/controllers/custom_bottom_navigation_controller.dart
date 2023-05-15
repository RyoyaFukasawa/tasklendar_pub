import 'dart:developer';

import 'package:get/get.dart';
import 'package:tasklendar/app/routes/app_pages.dart';

class CustomBottomNavigationController extends GetxController {
  static CustomBottomNavigationController get to => Get.find();

  final RxInt currentIndex = 0.obs;

  final List<String> pages = <String>[
    Routes.TODO,
    Routes.CALENDAR,
    Routes.ROUTINE,
  ];

  final int TODO_PAGE = 0;
  final int CALENDAR_PAGE = 1;
  final int ROUTINE_PAGE = 2;

  void changePage(int index, {String? param = ''}) {
    currentIndex.value = index;
    Get.toNamed('${pages[index]}$param');
  }
}
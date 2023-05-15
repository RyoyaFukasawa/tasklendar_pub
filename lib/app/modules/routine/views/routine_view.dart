import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tasklendar/app/app_controller.dart';
import 'package:tasklendar/app/components/calendar/controllers/calendar_component_controller.dart';
import 'package:tasklendar/app/components/custom_bottom_navigation/custom_bottom_navigation.dart';
import 'package:tasklendar/app/components/custom_floating_action_button/custom_floating_action_button.dart';
import 'package:tasklendar/app/modules/routine/components/routine_form.dart';
import 'package:tasklendar/app/store/data_store.dart';
import 'package:tasklendar/app/styles/app_colors.dart';

import '../controllers/routine_controller.dart';

class RoutineView extends GetView<RoutineController> {
  const RoutineView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // elevation: 0,
          // automaticallyImplyLeading: false,
          // centerTitle: false,
          // title: IconButton(
          //   padding: EdgeInsets.zero,
          //   constraints: const BoxConstraints(),
          //   onPressed: () {
          //     Get.toNamed(Routes.WELCOME);
          //     // _scaffoldKey.currentState!.openDrawer();
          //   },
          //   icon: Icon(
          //     FontAwesomeIcons.burger,
          //     color: Styles.gray,
          //   ),
          // ),
          ),
      body: Container(
        // child: ReorderableListView.builder(
        //   itemBuilder: (_, index) => Text(
        //     'test',
        //     key: Key('$index'),
        //   ),
        //   itemCount: 3,
        //   onReorder: (int oldIndex, int newIndex) {},
        // ),
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.blue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            margin: EdgeInsets.all(10),
            color: Colors.white,
            child: Text('Hello World!'),
          ),
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        widget: RoutineForm(
          appController: Get.find<AppController>(),
          calendarComponentController: Get.find<CalendarComponentController>(),
          dataStore: Get.find<DataStore>(),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

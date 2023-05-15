import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:tasklendar/app/app_controller.dart';
import 'package:tasklendar/app/components/calendar/controllers/calendar_component_controller.dart';
import 'package:tasklendar/app/components/custom_bottom_navigation/custom_bottom_navigation.dart';
import 'package:tasklendar/app/components/custom_floating_action_button/custom_floating_action_button.dart';
import 'package:tasklendar/app/components/drawer_list/drawer_list.dart';
import 'package:tasklendar/app/data/models/todo_model.dart';
import 'package:tasklendar/app/modules/todo/components/todo_form.dart';
import 'package:tasklendar/app/modules/todo/components/todo_list.dart';
import 'package:tasklendar/app/store/data_store.dart';
import 'package:tasklendar/app/styles/app_typography.dart';
import 'package:tasklendar/app/theme/theme.dart';

import '../controllers/todo_controller.dart';

class TodoView extends GetView<TodoController> {
  TodoView({
    Key? key,
    required DataStore dataStore,
    required AppController appController,
  })  : _dataStore = dataStore,
        _appController = appController,
        _pageController = PageController(
          initialPage: dataStore.currentDate.value.day - 1,
        ),
        super(key: key);

  // Store //
  final DataStore _dataStore;

  // Controller //
  final AppController _appController;
  final PageController _pageController;

  // Other //
  final DateTime now = DateTime.now();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final String? todoId = Get.parameters['task_id'];

  @override
  Widget build(BuildContext context) {
    if (todoId != null) {
      // Get the todo to edit.
      final Future<TodoModel?>? todo = controller.getTodo(todoId!);
      // Show the edit todo form.
      todo?.then((todoModel) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          try {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => TodoForm(
                todo: todoModel!,
                appController: Get.find<AppController>(),
                calendarComponentController:
                    Get.find<CalendarComponentController>(),
                dataStore: Get.find<DataStore>(),
              ),
            );
          } catch (e) {
            print('Error: $e');
          }
        });
      });
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
          icon: Icon(
            FontAwesomeIcons.burger,
            color: AppTheme.colorScheme.onPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _dataStore.setCurrentDateValue(now);
              _appController.goToPage(
                _pageController,
                now.day - 1,
              );
            },
            child: Text(
              'tody',
              style: AppTypography.h5,
            ),
          ),
        ],
      ),
      drawer: DrawerList(),
      body: SizedBox(
        width: double.infinity,
        child: Obx(() {
          final todoList = _dataStore.todoList;
          final Rx<DateTime> currentDate = _dataStore.currentDate;

          return PageView.builder(
            itemCount: _dataStore
                .calendarDaysList[currentDate.value.year]
                    ?[currentDate.value.month]!
                .length,
            onPageChanged: (index) {
              final newCurrentDate = DateTime(
                currentDate.value.year,
                currentDate.value.month,
                index + 1,
              );
              _dataStore.setCurrentDateValue(newCurrentDate);
            },
            controller: _pageController,
            itemBuilder: (context, index) {
              final targetKey = index + 1;
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      currentDate.value.year.toString(),
                      style: AppTypography.h3,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      controller.changeFormat(DateTime(
                        currentDate.value.year,
                        currentDate.value.month,
                        targetKey,
                      )),
                      style: AppTypography.title,
                    ),
                  ),
                  TodoList(
                    date: DateTime(
                      currentDate.value.year,
                      currentDate.value.month,
                      targetKey,
                    ),
                  ),
                ],
              );
            },
          );
        }),
      ),
      floatingActionButton: CustomFloatingActionButton(
        widget: TodoForm(
          appController: Get.find<AppController>(),
          calendarComponentController: Get.find<CalendarComponentController>(),
          dataStore: Get.find<DataStore>(),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

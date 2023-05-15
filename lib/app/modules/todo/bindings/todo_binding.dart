import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/components/calendar/controllers/calendar_component_controller.dart';
import 'package:tasklendar/app/components/drawer_list/controller/drawer_list_controller.dart';
import 'package:tasklendar/app/data/repository/firebase_auth_repository.dart';
import 'package:tasklendar/app/data/repository/todo_repository.dart';
import 'package:tasklendar/app/store/data_store.dart';

import '../controllers/todo_controller.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoController>(
      () => TodoController(
        todoRepository: TodoRepository(
          firebaseFirestore: FirebaseFirestore.instance,
          dataStore: Get.find<DataStore>(),
        ),
        dataStore: Get.find<DataStore>(),
      ),
    );
    Get.put(CalendarComponentController(
      dataStore: Get.find<DataStore>(),
    ));
    Get.put(DrawerListController(
      firebaseAuthRepository: FirebaseAuthRepository(),
    ));
  }
}

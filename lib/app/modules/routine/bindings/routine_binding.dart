import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/data/repository/routine_repository.dart';
import 'package:tasklendar/app/store/data_store.dart';

import '../controllers/routine_controller.dart';

class RoutineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoutineController>(
      () => RoutineController(
        routineRepository: RoutineRepository(
          dataStore: Get.find<DataStore>(),
          firebaseFirestore: FirebaseFirestore.instance,
        ),
      ),
    );
  }
}

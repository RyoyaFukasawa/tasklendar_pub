import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/data/repository/firebase_auth_repository.dart';
import 'package:tasklendar/app/store/data_store.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(
      SplashController(
        firebaseAuthRepository: FirebaseAuthRepository(),
        dataStore: Get.find<DataStore>(),
      ),
    );
  }
}

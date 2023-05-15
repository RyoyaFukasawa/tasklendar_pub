import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/app_controller.dart';
import 'package:tasklendar/app/data/repository/firebase_auth_repository.dart';
import 'package:tasklendar/app/data/repository/google_auth_repository.dart';
import 'package:tasklendar/app/data/repository/user_repository.dart';
import 'package:tasklendar/app/store/data_store.dart';

import '../controllers/sign_up_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(
      () => SignUpController(
        firebaseAuthRepository: FirebaseAuthRepository(),
        googleAuthRepository: GoogleAuthRepository(),
        dataStore: Get.find<DataStore>(),
        appController: Get.find<AppController>(),
      ),
    );
  }
}

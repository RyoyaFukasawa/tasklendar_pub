import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/app_controller.dart';
import 'package:tasklendar/app/data/repository/firebase_auth_repository.dart';
import 'package:tasklendar/app/data/repository/user_repository.dart';
import 'package:tasklendar/app/store/data_store.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(
      () => ResetPasswordController(
        firebaseAuthRepository: FirebaseAuthRepository(),
        appController: AppController(
          userRepository: UserRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
          dataStore: DataStore(),
        ),
      ),
    );
  }
}

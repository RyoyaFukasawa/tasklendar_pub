import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/data/repository/firebase_auth_repository.dart';
import 'package:tasklendar/app/routes/app_pages.dart';
import 'package:tasklendar/app/store/data_store.dart';

class SplashController extends GetxController {
  SplashController({
    required FirebaseAuthRepository firebaseAuthRepository,
    required DataStore dataStore,
  })  : _firebaseAuthRepository = firebaseAuthRepository,
        _dataStore = dataStore;

  // Repository //
  final FirebaseAuthRepository _firebaseAuthRepository;

  // Store //
  final DataStore _dataStore;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _checkLoginStatus();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> _checkLoginStatus() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    final User? user = await _firebaseAuthRepository.getUser();

    if (user != null) {
      _dataStore.setLoggedInUserValue(user);
      Get.offAllNamed(Routes.TODO);
    } else {
      Get.offAllNamed(Routes.WELCOME);
    }
  }
}

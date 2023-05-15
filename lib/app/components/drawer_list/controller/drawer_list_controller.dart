import 'package:get/get.dart';
import 'package:tasklendar/app/data/repository/firebase_auth_repository.dart';

class DrawerListController extends GetxController {
  DrawerListController({
    required FirebaseAuthRepository firebaseAuthRepository,
  }) : _firebaseAuthRepository = firebaseAuthRepository;

  final FirebaseAuthRepository _firebaseAuthRepository;

  Future<void> signOut() async {
    try {
      await _firebaseAuthRepository.signOut();
    } catch (e, stackTrace) {
      print('signOut failed: $e');
    }
  }
}

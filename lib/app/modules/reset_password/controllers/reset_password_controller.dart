import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/app_controller.dart';
import 'package:tasklendar/app/data/repository/firebase_auth_repository.dart';

class ResetPasswordController extends GetxController {
  ResetPasswordController({
    required FirebaseAuthRepository firebaseAuthRepository,
    required AppController appController,
  })  : _firebaseAuthRepository = firebaseAuthRepository,
        _appController = appController;

  // Repository //
  final FirebaseAuthRepository _firebaseAuthRepository;

  // Controller //
  final AppController _appController;

  // Rx //
  final Rx<bool> isLoading = false.obs;
  final RxMap<String, dynamic> errors = <String, dynamic>{}.obs;
  final Rx<bool> isObscure = true.obs;
  final formKey = GlobalKey<FormState>().obs;

  // Other //
  final TextEditingController emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> sendPasswordResetEmail(
    String email,
    void Function() sendEmailSuccess,
  ) async {
    errors.clear();
    isLoading.value = true;
    try {
      await _firebaseAuthRepository.sendPasswordResetEmail(email: email);

      sendEmailSuccess();
    } on FirebaseAuthException catch (e) {
      errors.value = _appController.handleFirebaseAuthException(e);
    } catch (e) {
      print('sendPasswordResetEmail failed: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

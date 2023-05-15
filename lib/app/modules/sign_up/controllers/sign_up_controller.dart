import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tasklendar/app/app_controller.dart';
import 'package:tasklendar/app/data/repository/firebase_auth_repository.dart';
import 'package:tasklendar/app/data/repository/google_auth_repository.dart';
import 'package:tasklendar/app/store/data_store.dart';
import 'package:tasklendar/generated/locales.g.dart';

class SignUpController extends GetxController {
  SignUpController({
    required FirebaseAuthRepository firebaseAuthRepository,
    required GoogleAuthRepository googleAuthRepository,
    required DataStore dataStore,
    required AppController appController,
  })  : _firebaseAuthRepository = firebaseAuthRepository,
        _googleAuthRepository = googleAuthRepository,
        _dataStore = dataStore,
        _appController = appController;

  // Repository //
  final FirebaseAuthRepository _firebaseAuthRepository;
  final GoogleAuthRepository _googleAuthRepository;

  // Store //
  final DataStore _dataStore;

  // Controller //
  final AppController _appController;

  // Rx //
  final Rx<bool> isLoading = false.obs;
  final RxMap<String, dynamic> errors = <String, dynamic>{}.obs;
  final Rx<bool> isObscure = true.obs;

  // Other //
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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

  Future<void> signUp(
    String email,
    String password,
    void Function() sendEmailSuccess,
  ) async {
    isLoading.value = true;
    errors.clear();
    try {
      await _firebaseAuthRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );

      // send email verification
      await _firebaseAuthRepository.sendEmailVerification();

      sendEmailSuccess();
    } on FirebaseAuthException catch (e) {
      errors.value = _appController.handleFirebaseAuthException(e);
    } catch (e) {
      print('register failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUpWithGoogle(
    void Function() authenticateSuccess,
  ) async {
    isLoading.value = true;
    errors.clear();
    try {
      final GoogleSignInAccount? googleUser =
          await _googleAuthRepository.signIn();

      if (googleUser == null) {
        errors['email'] = LocaleKeys.error_google_sign_in_failed.tr;
        return;
      }

      final isEmailRegistered =
          await _firebaseAuthRepository.isEmailAlreadyRegistered(
        email: googleUser.email,
      );

      if (isEmailRegistered) {
        errors['email'] = LocaleKeys.error_google_account_exist.tr;
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential? userCredential = await _firebaseAuthRepository
          .signInWithCredential(credential: credential);

      if (userCredential == null) {
        errors['email'] = LocaleKeys.error_google_sign_in_failed.tr;
        return;
      }

      _dataStore.setLoggedInUserValue(userCredential.user!);

      await _appController.addUserIfNeeded();

      authenticateSuccess();
    } on FirebaseAuthException catch (e) {
      errors.value = _appController.handleFirebaseAuthException(e);
    } catch (e) {
      print('Error signUpWith: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

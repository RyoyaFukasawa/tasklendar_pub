import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tasklendar/app/app_controller.dart';
import 'package:tasklendar/app/data/repository/firebase_auth_repository.dart';
import 'package:tasklendar/app/data/repository/google_auth_repository.dart';
import 'package:tasklendar/app/store/data_store.dart';
import 'package:tasklendar/generated/locales.g.dart';

class LoginController extends GetxController {
  LoginController({
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

  // State //
  final DataStore _dataStore;

  // Controller //
  final AppController _appController;

  // Rx //
  final Rx<bool> isLoading = false.obs;
  final RxMap<String, dynamic> errors = <String, dynamic>{}.obs;
  final Rx<bool> isObscure = true.obs;
  final formKey = GlobalKey<FormState>().obs;

  // Other //
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

  Future<void> login(
    String email,
    String password,
    void Function() loginSuccess,
  ) async {
    errors.clear();
    isLoading.value = true;
    try {
      await _firebaseAuthRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _dataStore.setLoggedInUserValue(await _firebaseAuthRepository.getUser());

      if (_dataStore.loggedInUser.value!.emailVerified) {
        errors['email'] = LocaleKeys.error_email_verification_required.tr;
        return;
      }

      await _appController.addUserIfNeeded();

      if (_dataStore.loggedInUser != null) {
        loginSuccess();
      }
    } on FirebaseAuthException catch (e) {
      errors.value = _appController.handleFirebaseAuthException(e);
    } catch (e) {
      print('login failed: $e');
    } finally {
      isLoading.value = false;
    }
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

  // Google Sign In //
  Future<void> loginWithGoogle(
    void Function() loginWithGoogleSuccess,
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

      if (!isEmailRegistered) {
        errors['email'] = LocaleKeys.error_google_account_not_exist.tr;
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

      _dataStore.setLoggedInUserValue(await _firebaseAuthRepository.getUser());

      if (_dataStore.loggedInUser != null) {
        loginWithGoogleSuccess();
      }
    } on FirebaseAuthException catch (e) {
      errors.value = _appController.handleFirebaseAuthException(e);
    } catch (e) {
      print('Error registerWithGoogle: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

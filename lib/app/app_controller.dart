import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/data/repository/user_repository.dart';
import 'package:tasklendar/app/store/data_store.dart';
import 'package:tasklendar/generated/locales.g.dart';

class AppController extends GetxController {
  AppController({
    required UserRepository userRepository,
    required DataStore dataStore,
  })  : _userRepository = userRepository,
        _dataStore = dataStore;

  final UserRepository _userRepository;
  final DataStore _dataStore;

  Future<void> addUserIfNeeded() async {
    try {
      DocumentSnapshot userDocSnapshot = await _userRepository.getUser(
        id: _dataStore.loggedInUser.value!.uid,
      );

      if (!userDocSnapshot.exists) {
        await _userRepository.addUser(
          id: _dataStore.loggedInUser.value!.uid,
          email: _dataStore.loggedInUser.value!.email!,
          createdAt: _dataStore.loggedInUser.value!.metadata.creationTime,
          updatedAt: _dataStore.loggedInUser.value!.metadata.lastSignInTime,
        );
      }
    } catch (e, stackTrace) {
      print('_addUserIfNeeded failed: $e');
    }
  }

  Map<String, dynamic> handleFirebaseAuthException(FirebaseAuthException e) {
    Map<String, dynamic> errors = {};
    switch (e.code) {
      // email //
      case 'user-not-found':
        errors['email'] = LocaleKeys.error_user_not_found.tr;
        break;
      case 'invalid-email':
        errors['email'] = LocaleKeys.error_invalid_email.tr;
        break;
      case 'user-disabled':
        errors['email'] = LocaleKeys.error_user_disabled.tr;
        break;
      case 'too-many-requests':
        errors['email'] = LocaleKeys.error_too_many_requests.tr;
        break;
      case 'internal-error':
        errors['email'] = LocaleKeys.error_internal_error.tr;
        break;
      case 'account-exists-with-different-credential':
        errors['email'] =
            LocaleKeys.error_account_exists_with_different_credential.tr;
        break;
      case 'invalid-credential':
        errors['email'] = LocaleKeys.error_invalid_credential.tr;
        break;
      case 'operation-not-allowed':
        errors['email'] = LocaleKeys.error_operation_not_allowed.tr;
        break;
      // password //
      case 'wrong-password':
        errors['password'] = LocaleKeys.error_wrong_password.tr;
        break;

      default:
        print('FirebaseAuthException failed: $e');
    }
    return errors;
  }

  void goToPage(PageController pageController, int page) {
    pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}

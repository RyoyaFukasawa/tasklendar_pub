import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasklendar/app/data/repository/firebase_auth_repository.dart';
import 'package:tasklendar/app/routes/app_pages.dart';
import 'package:tasklendar/app/store/data_store.dart';

class AuthMiddleware extends GetMiddleware {
  AuthMiddleware({
    required DataStore dataStore,
  }) : _dataStore = dataStore;

  // Store //
  final DataStore _dataStore;

  @override
  RouteSettings? redirect(String? route) {
    final user = _dataStore.loggedInUser.value;
    if (user == null) {
      return const RouteSettings(name: Routes.LOGIN);
    }
    return null;
  }
}

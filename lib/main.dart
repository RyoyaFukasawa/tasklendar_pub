import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tasklendar/app/app_controller.dart';
import 'package:tasklendar/app/components/custom_bottom_navigation/controllers/custom_bottom_navigation_controller.dart';
import 'package:tasklendar/app/data/repository/user_repository.dart';
import 'package:tasklendar/app/store/data_store.dart';
import 'package:tasklendar/app/theme/theme.dart';
import 'package:tasklendar/firebase_options.dart';
import 'package:tasklendar/generated/locales.g.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    GetMaterialApp(
      title: "Tasklendar",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      defaultTransition: Transition.noTransition,
      translationsKeys: AppTranslation.translations,
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      initialBinding: BindingsBuilder(
        () {
          Get.put(DataStore());
          Get.put(
            AppController(
              dataStore: Get.find<DataStore>(),
              userRepository: UserRepository(
                firebaseFirestore: FirebaseFirestore.instance,
              ),
            ),
          );
          Get.put(CustomBottomNavigationController());
        },
      ),
    ),
  );
}

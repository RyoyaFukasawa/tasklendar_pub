import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../middleware/auth_middleware.dart';
import '../app_controller.dart';
import '../components/calendar/controllers/calendar_component_controller.dart';
import '../data/repository/user_repository.dart';
import '../modules/calendar/bindings/calendar_binding.dart';
import '../modules/calendar/views/calendar_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/routine/bindings/routine_binding.dart';
import '../modules/routine/views/routine_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/test/bindings/test_binding.dart';
import '../modules/test/views/test_view.dart';
import '../modules/todo/bindings/todo_binding.dart';
import '../modules/todo/views/todo_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';
import '../store/data_store.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.TEST;
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.TODO,
      page: () => TodoView(
        dataStore: Get.find<DataStore>(),
        appController: AppController(
          dataStore: Get.find<DataStore>(),
          userRepository: UserRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
      ),
      binding: TodoBinding(),
    ),
    GetPage(
      name: _Paths.CALENDAR,
      page: () => CalendarView(
        dataStore: Get.find<DataStore>(),
        appController: AppController(
          dataStore: Get.find<DataStore>(),
          userRepository: UserRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        calendarComponentController: Get.find<CalendarComponentController>(),
      ),
      binding: CalendarBinding(),
    ),
    GetPage(
      name: _Paths.ROUTINE,
      page: () => const RoutineView(),
      binding: RoutineBinding(),
    ),
    GetPage(
      name: _Paths.TEST,
      page: () => const TestView(),
      binding: TestBinding(),
    ),
  ];
}

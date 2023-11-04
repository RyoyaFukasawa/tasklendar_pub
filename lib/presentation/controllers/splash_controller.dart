// // Flutter imports:
// import 'package:flutter/cupertino.dart';

// // Package imports:
// import 'package:flutter_native_splash/flutter_native_splash.dart';

// // Project imports:
// import 'package:tasklendar/core/logs/log.dart';
// import 'package:tasklendar/domain/entities/user_entity.dart';
// import 'package:tasklendar/domain/repository/auth_repository.dart';
// import 'package:tasklendar/presentation/controllers/base_controller.dart';

// class SplashController extends BaseController {
//   SplashController({
//     required AuthRepository authRepository,
//     required WidgetsBinding widgetsBinding,
//     required super.globalState,
//   })  : _widgetsBinding = widgetsBinding,
//         _authRepository = authRepository;

//   // repository //
//   final AuthRepository _authRepository;

//   final WidgetsBinding _widgetsBinding;

//   @override
//   Future<void> onInit() async {
//     super.onInit();

//     // stop the splash screen from auto hiding
//     FlutterNativeSplash.preserve(widgetsBinding: _widgetsBinding);

//     await initializeApp();
//     FlutterNativeSplash.remove();
//   }

//   Future<void> initializeApp() async {
//     try {
//       UserEntity? user = await _authRepository.fetchUser();

//       user ??= await _authRepository.signInAnonymously();

//       Log.debug(user.toString());

//       updateLoggedInUser(user);
//     } catch (e) {
//       Log.error(e.toString());
//     }
//   }
// }

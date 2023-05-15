import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final brightness = Get.theme.brightness;
    final imagePath = brightness == Brightness.dark
        ? 'assets/images/icon_dark.png'
        : 'assets/images/icon.png';

    return Scaffold(
      body: Center(
        child: Image(
          width: Get.width * 0.4,
          height: Get.height * 0.4,
          image: AssetImage(imagePath),
        ),
      ),
    );
  }
}

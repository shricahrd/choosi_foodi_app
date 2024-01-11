import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(ORANGE),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Image.asset(
            scr_splash,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

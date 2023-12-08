import 'dart:async';

import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/utils/app_preferences.dart';
import 'package:choosifoodi/model/login/user_data_model.dart';
import 'package:choosifoodi/screens/base_application/base_application.dart';
import 'package:choosifoodi/screens/create_account/create_account_screen.dart';
import 'package:choosifoodi/screens/login/login_screen.dart';
import 'package:choosifoodi/screens/login/start_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => StartScreen(),
      ));
    });
    // checkIsLogin();
  }

  void checkIsLogin() {
    AppPreferences.getIsLogin().then((value) => {
          if (value == true)
            {
              AppPreferences.getUserData().then((userData) => {
                    if (userData != null) {moveToHomeScreen(userData)}
                  })
            }
        });
  }

  void moveToHomeScreen(UserDataModel userData) {
    userDataModel = userData;
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => BaseApplication(),
    ));
  }

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
          ),
        ),
      ),
    );
  }

  onClickGetStart() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }

  onClickSignUp() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => CreateAccountScreen()));
  }
}

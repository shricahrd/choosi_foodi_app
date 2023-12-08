import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/utils/app_preferences.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/model/login/user_data_model.dart';
import 'package:choosifoodi/screens/base_application/base_application.dart';
import 'package:choosifoodi/screens/create_account/create_account_screen.dart';
import 'package:choosifoodi/screens/home/home_screen.dart';
import 'package:choosifoodi/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

UserDataModel? userDataModel = null;

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(WHITE),
                ),
                child: Image.asset(
                  app_logo,
                  width: 50,
                  height: 50,
                ),
              ),
              flex: 6,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(GREY),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(ORANGE),
                            ),
                            minimumSize: MaterialStateProperty.all<Size>(
                              Size(double.maxFinite, 50.0),
                            ),
                          ),
                          onPressed: onClickGetStart,
                          child: WidgetText.widgetRobotoMediumText(
                            "Get Started",
                            Colors.white,
                            20,
                            align: TextAlign.end,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        WidgetText.widgetRobotoRegularText(
                          "Don’t Have an Account?",
                          Color(BLACK),
                          16,
                          align: TextAlign.end,
                        ),
                        TextButton(
                          child: WidgetText.widgetRobotoMediumText(
                            "Sign Up",
                            Color(ORANGE),
                            20,
                            align: TextAlign.end,
                          ),
                          onPressed: onClickSignUp,
                        )
                      ],
                    )
                  ],
                ),
              ),
              flex: 4,
            )
          ],
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

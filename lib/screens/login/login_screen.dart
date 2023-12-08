import 'dart:convert';

import 'package:choosifoodi/core/http_utils/http_constants.dart';
import 'package:choosifoodi/core/http_utils/http_post_util.dart';
import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/utils/app_preferences.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/model/login/login_data_model.dart';
import 'package:choosifoodi/model/login/user_data_model.dart';
import 'package:choosifoodi/screens/base_application/base_application.dart';
import 'package:choosifoodi/screens/create_account/create_account_screen.dart';
import 'package:choosifoodi/screens/forgot_password/forgot_password_email_screen.dart';
import 'package:choosifoodi/screens/home/home_screen.dart';
import 'package:choosifoodi/screens/location_details/location_details_screen.dart';
import 'package:choosifoodi/screens/login/start_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoaderVisible = false;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: AppLoader(
            widget: Column(
              children: [
                Expanded(
                  child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(WHITE),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            app_icon,
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          WidgetText.widgetRobotoMediumText(
                            "Login",
                            Color(ORANGE),
                            28,
                            align: TextAlign.end,
                          ),
                        ],
                      )),
                  flex: 2,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(GREY),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        customTextInputField(
                            emailController,
                            "Enter your email",
                            "Email",
                            TextInputType.emailAddress),
                        customTextInputField(
                            passwordController,
                            "Enter Password",
                            "Password",
                            TextInputType.visiblePassword,
                            true),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.fromLTRB(0, 5, 40, 0),
                          child: InkWell(
                            onTap: onClickForgotPassword,
                            child: WidgetText.widgetRobotoMediumText(
                              "Forgot Password?",
                              Color(ORANGE),
                              16,
                              align: TextAlign.end,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  flex: 6,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(WHITE),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                          child: WidgetButton.widgetDefaultButton(
                              "Login", onClickLogin),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            WidgetText.widgetRobotoRegularText(
                              "Don't have an account?",
                              Color(BLACK),
                              16,
                              align: TextAlign.end,
                            ),
                            TextButton(
                              child: WidgetText.widgetRobotoMediumText(
                                "Sign up",
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
                  flex: 2,
                ),
              ],
            ),
            isLoading: _isLoaderVisible),
      ),
    );
  }

  Widget customTextInputField(TextEditingController editingController,
      String hintText, String lableText, TextInputType? keyboardType,
      [bool hidePassword = false]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(40, 20, 40, 2),
          child: WidgetText.widgetRobotoRegularText(
            lableText,
            Color(LABLECOLOR),
            20,
            align: TextAlign.end,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(40, 2, 40, 10),
          decoration: BoxDecoration(
            color: Color(WHITE),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          padding: EdgeInsets.fromLTRB(15, 3, 15, 3),
          child: TextFormField(
            obscureText: hidePassword,
            controller: editingController,
            textAlign: TextAlign.start,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Color(HINTCOLOR),
                fontSize: 16,
                fontFamily: FontRoboto,
                fontWeight: RobotoRegular,
              ),
              hintText: hintText,
            ),
            style: TextStyle(
              color: Color(BLACK),
              fontSize: 16,
              fontFamily: FontRoboto,
              fontWeight: RobotoMedium,
            ),
          ),
        )
      ],
    );
  }

  onClickForgotPassword() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ForgotPasswordEmailScreen()));
  }

  onClickLogin() {
    // if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
    //   callLoginAPI();
    // } else {
    //   showToastMessage("Please enter email and password");
    // }
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => BaseApplication()));
  }

  onClickSkip() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => LocationDetailsScreen(
              isUpdateLocation: false,
            )));
  }

  onClickSignUp() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => CreateAccountScreen()));
  }

  /*
  * Call Login API
  * */
  void callLoginAPI() {
    setState(() {
      _isLoaderVisible = !_isLoaderVisible;
    });

    final params = jsonEncode({
      HttpConstants.PARAMS_EMAIL: emailController.text,
      HttpConstants.PARAMS_PASSWORD: passwordController.text,
    });

    postRequest(HttpConstants.API_LOGIN, params).then((response) {
      setState(() {
        _isLoaderVisible = !_isLoaderVisible;
      });

      if (response.statusCode == 200) {
        LoginDataModel loginDataModel =
            LoginDataModelFromJson(response.body.toString());
        if (loginDataModel.meta.status) {
          userDataModel = loginDataModel.data;

          AppPreferences.setIsLogin(true);
          AppPreferences.setUserData(UserDataModelToJson(loginDataModel.data!));

          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => BaseApplication()));
        } else {
          showToastMessage(loginDataModel.meta.msg);
        }
      } else {
        throw Exception('Failed to load data.');
      }
    });
  }
}

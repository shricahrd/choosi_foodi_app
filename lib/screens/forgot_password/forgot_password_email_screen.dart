import 'dart:convert';

import 'package:choosifoodi/core/http_utils/http_constants.dart';
import 'package:choosifoodi/core/http_utils/http_post_util.dart';
import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/model/forgot_password/forgot_password_data_model.dart';
import 'package:choosifoodi/screens/forgot_password/enter_otp_screen.dart';
import 'package:flutter/material.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  @override
  _ForgotPasswordEmailScreenState createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  TextEditingController emailController = new TextEditingController();
  bool _isLoaderVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      body: SafeArea(
        child: AppLoader(
            widget: Stack(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 70,
                      ),
                      WidgetText.widgetRobotoBoldText(
                        "Forgot Password",
                        Color(ORANGE),
                        25,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Align(
                          alignment: Alignment.center,
                          child: WidgetText.widgetRobotoRegularText(
                              "Please enter your email address\nand we'll send you a link to get\nback into your account.",
                              Color(BLACK),
                              18,
                              align: TextAlign.center),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                        decoration: BoxDecoration(
                          color: Color(GREY),
                        ),
                        child: customTextInputField(
                            emailController,
                            "Enter Email",
                            "Email",
                            TextInputType.emailAddress),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 15,
                  left: 15,
                  right: 15,
                  child:
                      WidgetButton.widgetDefaultButton("Submit", onClickSubmit),
                ),
              ],
            ),
            isLoading: _isLoaderVisible),
      ),
    );
  }

  Widget customTextInputField(TextEditingController editingController,
      String hintText, String lableText, TextInputType? keyboardType) {
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

  onClickSubmit() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => EnterOTPScreen(
          email: emailController.text,
          requiredOTP: "2222",
        )));
    // if (emailController.text.isNotEmpty) {
    //   callForgotPasswordAPI();
    // } else {
    //   showToastMessage("Please enter email");
    // }
  }

  /*
  * Call Forgot Password API
  * */
  void callForgotPasswordAPI() {
    setState(() {
      _isLoaderVisible = !_isLoaderVisible;
    });

    final params = jsonEncode({
      HttpConstants.PARAMS_EMAIL: emailController.text,
    });
    postRequest(HttpConstants.API_FORGET_PASSWORD, params).then((response) {
      setState(() {
        _isLoaderVisible = !_isLoaderVisible;
      });

      if (response.statusCode == 200) {
        ForgotPasswordDataModel forgotPasswordDataModel =
            ForgotPasswordDataModelFromJson(response.body.toString());

        showToastMessage(forgotPasswordDataModel.meta.msg);

        if (forgotPasswordDataModel.meta.status) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => EnterOTPScreen(
                    email: emailController.text,
                    requiredOTP: "2222",
                  )));
        }
      } else {
        throw Exception('Failed to load data.');
      }
    });
  }
}

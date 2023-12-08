import 'dart:convert';

import 'package:choosifoodi/core/http_utils/http_constants.dart';
import 'package:choosifoodi/core/http_utils/http_post_util.dart';
import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/model/reset_password/reset_password_data_model.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String enteredOTP;
  final String email;

  const ResetPasswordScreen(
      {Key? key, required this.enteredOTP, required this.email})
      : super(key: key);

  @override
  _ResetPasswordScreenState createState() =>
      _ResetPasswordScreenState(enteredOTP, email);
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String enteredOTP = "";
  String email = "";
  bool _isLoaderVisible = false;
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  _ResetPasswordScreenState(String enteredOTP, String email) {
    this.enteredOTP = enteredOTP;
    this.email = email;
  }

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
                        "Reset Password",
                        Color(ORANGE),
                        25,
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                        decoration: BoxDecoration(
                          color: Color(GREY),
                        ),
                        child: Column(
                          children: [
                            customTextInputField(
                                passwordController,
                                "Enter Password",
                                "Password",
                                TextInputType.visiblePassword),
                            customTextInputField(
                                confirmPasswordController,
                                "Enter Confirm Password",
                                "Confirm Password",
                                TextInputType.visiblePassword),
                          ],
                        ),
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
            obscureText: true,
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
    // if (passwordController.text.isNotEmpty &&
    //     confirmPasswordController.text.isNotEmpty) {
    //   if (passwordController.text == confirmPasswordController.text) {
    //     callResetPasswordAPI();
    //   } else {
    //     showToastMessage("Password and Confirm password are not match");
    //   }
    // } else {
    //   showToastMessage("Please enter password and confirm password");
    // }
    Navigator.of(context).pop(false);
  }

  /*
  * Call Reset Password API
  * */
  void callResetPasswordAPI() {
    setState(() {
      _isLoaderVisible = !_isLoaderVisible;
    });

    final params = jsonEncode({
      HttpConstants.PARAMS_PASSWORD: passwordController.text,
      HttpConstants.PARAMS_CONFIRM_PASSWORD: confirmPasswordController.text,
      HttpConstants.PARAMS_EMAIL: email,
      HttpConstants.PARAMS_OTP: enteredOTP,
    });

    postRequest(HttpConstants.API_RESET_PASSWORD, params).then((response) {
      setState(() {
        _isLoaderVisible = !_isLoaderVisible;
      });

      if (response.statusCode == 200) {
        ResetPasswordDataModel resetPasswordDataModel =
            ResetPasswordDataModelFromJson(response.body.toString());

        showToastMessage(resetPasswordDataModel.meta.msg);

        if (resetPasswordDataModel.meta.status) {
          Navigator.of(context).pop(false);
        }
      } else {
        throw Exception('Failed to load data.');
      }
    });
  }
}

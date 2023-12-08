import 'dart:convert';

import 'package:choosifoodi/core/http_utils/http_constants.dart';
import 'package:choosifoodi/core/http_utils/http_post_util.dart';
import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/model/registration/registration_data_model.dart';
import 'package:choosifoodi/screens/foodi_goal/foodi_goal_add_edit.dart';
import 'package:choosifoodi/screens/location_details/location_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool _isLoaderVisible = false;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                app_icon,
                                width: 35,
                                height: 35,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              WidgetText.widgetRobotoMediumText(
                                "Create an Account",
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
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            customTextInputField(emailController, "Enter Email",
                                "Email", TextInputType.emailAddress),
                            customTextInputField(
                                passwordController,
                                "Enter Password",
                                "Password",
                                TextInputType.visiblePassword,
                                true),
                            customTextInputField(
                                phoneNumberController,
                                "Phone Number",
                                "Phone Number",
                                TextInputType.phone),
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
                                  "Next", onClickNext),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextButton(
                              onPressed: onClickSetupLater,
                              child: WidgetText.widgetRobotoRegularText(
                                "Setup Later",
                                Color(ORANGE),
                                16,
                                align: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),
                      flex: 2,
                    ),
                  ],
                ),
                isLoading: _isLoaderVisible)),
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

  onClickSetupLater() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => LocationDetailsScreen(
              isUpdateLocation: false,
            )));
  }

  onClickNext() {
    // if (emailController.text.isNotEmpty &&
    //     passwordController.text.isNotEmpty &&
    //     phoneNumberController.text.isNotEmpty) {
    //   callRegistrationAPI();
    // } else {
    //   showToastMessage("Please enter all required fields");
    // }

    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => FoodiGoalAddEditScreen(
              isEditFoodiGoal: false,
              isFromHome: false,
              isFromSignup: true,
            )));
  }

  /*
 * Call Registration API
 * */
  void callRegistrationAPI() {
    setState(() {
      _isLoaderVisible = !_isLoaderVisible;
    });

    final params = jsonEncode({
      HttpConstants.PARAMS_EMAIL: emailController.text,
      HttpConstants.PARAMS_PASSWORD: passwordController.text,
      HttpConstants.PARAMS_PHONE_NUMBER: phoneNumberController.text,
    });

    postRequest(HttpConstants.API_REGISTRATION, params).then((response) {
      setState(() {
        _isLoaderVisible = !_isLoaderVisible;
      });

      if (response.statusCode == 200) {
        RegistrationDataModel registrationDataModel =
            RegistrationDataModelFromJson(response.body.toString());

        showToastMessage(registrationDataModel.meta.msg);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => FoodiGoalAddEditScreen(
                  isEditFoodiGoal: false,
                  isFromHome: false,
                  isFromSignup: true,
                )));
      } else {
        throw Exception('Failed to load data.');
      }
    });
  }
}

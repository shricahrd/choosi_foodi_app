import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/widgets/widget_card.dart';
import '../Controller/change_pwd_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final ChangePwdController changePwdController =
      Get.put(ChangePwdController());

  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();
    changePwdController.passwordController.clear();
    changePwdController.confirmPasswordController.clear();
    super.initState();
  }

  @override
  void dispose() {
    changePwdController.onClose();
    changePwdController.passwordController.clear();
    changePwdController.confirmPasswordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context, change_password, false ),
      body: SafeArea(
        child: GetBuilder<ChangePwdController>(builder: (logic) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  padding: EdgeInsets.all(25),
                  width: double.infinity,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      customTextInputField(
                          logic.passwordController,
                          enter_new_password,
                          new_password,
                          TextInputType.text,
                          TextInputAction.next),
                      SizedBox(
                        height: 15,
                      ),
                      customTextInputField(
                          logic.confirmPasswordController,
                          confirm_new_password,
                          confirm_password,
                          TextInputType.text,
                          TextInputAction.done),
                      SizedBox(
                        height: 25,
                      ),
                      logic.isLoaderVisible == false
                          ? WidgetButton.widgetDefaultButton(set_password,
                              () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                              if (logic.passwordController.text.isNotEmpty &&
                                  logic.confirmPasswordController.text
                                      .isNotEmpty) {
                                if (logic.passwordController.text ==
                                    logic.confirmPasswordController.text) {
                                  if (logic.passwordController.length >= 6 &&
                                      logic.confirmPasswordController.length >=
                                          6) {
                                     logic.changePasswordApi(
                                        password: logic.passwordController.text,
                                        confirmPassword: logic
                                            .confirmPasswordController.text);
                                  } else {
                                    showToastMessage("Password must be more than 6 digits or characters");
                                  }
                                } else {
                                  showToastMessage("Password do not match", toastGravity: ToastGravity.CENTER);
                                }
                              } else {
                                showToastMessage("Please enter all required fields");
                              }
                            })
                          : Center(
                              child: CircularProgressIndicator(
                                color: Color(ORANGE),
                              ),
                            ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color(WHITE),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget customTextInputField(
      TextEditingController editingController,
      String hintText,
      String lableText,
      TextInputType? keyboardType,
      TextInputAction action) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetText.widgetPoppinsMediumText(
          lableText,
          Color(0xff3E4958),
          16,
          align: TextAlign.end,
        ),
        Card(
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
              color: Color(WHITE),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: TextFormField(
              controller: editingController,
              textAlign: TextAlign.start,
              keyboardType: keyboardType,
              obscureText: true,
              textInputAction: action,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Color(0xff8C8989),
                  fontSize: 16,
                  fontFamily: FontPoppins,
                  fontWeight: PoppinsRegular,
                ),
                hintText: hintText,
              ),
              style: TextStyle(
                color: Color(0xff3E4958),
                fontSize: 16,
                fontFamily: FontPoppins,
                fontWeight: PoppinsRegular,
              ),
            ),
          ),
        )
      ],
    );
  }
}

import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../controller/reset_pwd_controller.dart';

class ResetPasswordScreen extends StatelessWidget {

  final String mobile;

   ResetPasswordScreen(
      {Key? key, required this.mobile})
      : super(key: key);


  final ResetPwdController resetPwdController = Get.put(ResetPwdController());
  final _networkController = Get.find<GetXNetworkManager>();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(WHITE),
      body: SafeArea(
        child: GetBuilder<ResetPwdController>(
        builder: (logic) {
          return appLoader(
              widget:
                  Column(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 3,
                        child: SingleChildScrollView(
                          child: Container(
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
                                        TextInputType.visiblePassword,
                                        TextInputAction.next,
                                      ),
                                      customTextInputField(
                                        confirmPasswordController,
                                        // "Enter Confirm Password",
                                        confirm_password,
                                        confirm_password,
                                        TextInputType.visiblePassword,
                                        TextInputAction.done,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                          child: WidgetButton.widgetDefaultButton(submit, () {
                            if(_networkController.connectionType != 0) {
                              FocusScope.of(context).unfocus();
                              if (passwordController.text.isNotEmpty &&
                                  confirmPasswordController.text.isNotEmpty) {
                                if (passwordController.text ==
                                    confirmPasswordController.text) {
                                  if(passwordController.text.length >=6 && confirmPasswordController.text.length >=6) {
                                    logic.callResetPasswordAPI(mobile: mobile,
                                        password: passwordController.text);
                                  }else{
                                    showToastMessage(pwdMoreThan6Msg);
                                  }
                                } else {
                                  showToastMessage(
                                      pwdNotMatchMsg);
                                }
                              } else {
                                showToastMessage(
                                    plzCompeteAllMsg);
                              }
                            }else{
                              showToastMessage(check_internet);
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
              isLoading: logic.isLoaderVisible);
        }
        ),
      ),
    );
  }

  Widget customTextInputField(TextEditingController editingController,
      String hintText, String lableText, TextInputType? keyboardType,   TextInputAction? textInputAction,) {
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
            textInputAction: textInputAction,
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

}

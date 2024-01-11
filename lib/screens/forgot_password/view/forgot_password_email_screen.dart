import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/forgot_password/controller/forgot_pwd_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_images_utils.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';

class ForgotPasswordEmailScreen extends StatefulWidget{
  @override
  State<ForgotPasswordEmailScreen> createState() => _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final ForgotPwdController forgotPwdController = Get.put(ForgotPwdController());

  final _networkController = Get.find<GetXNetworkManager>();

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(WHITE),
        body: SafeArea(
          child:  GetBuilder<ForgotPwdController>(
          builder: (logic) {

            bool mobileValid = RegExp(r"(^(?:[+0]9)?[0-9]{10,15}$)").hasMatch(logic.phoneNumberController.text);
            // bool mobileValid = RegExp(r"(^(?:[+0]9)?[0-9]{10,15}$)").hasMatch(logic.phoneNumberController.text);

            return appLoader(
                widget:  Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 15, top: 20),
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset(
                            ic_right_side_arrow,
                            width: 25,
                            color: Color(ORANGE),
                            height: 20,
                          ),
                        ),
                      ),
                      Flexible(
                          flex: 3,
                          child: SingleChildScrollView(
                            child: Column(
                        children: [
                            SizedBox(
                              height: 60,
                            ),
                            WidgetText.widgetRobotoBoldText(
                              forgotPassword,
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
                                    "Please enter your mobile number\nand we'll send you a link to get\nback into your account.",
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
                                logic.phoneNumberController,
                                enter_mobile_number,
                                mobile_number,
                                TextInputType.phone),
                          ),

                        ],
                      ),
                          )),
                    Flexible(
                        // flex: 1,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          child: WidgetButton.widgetDefaultButton(submit, () {
                            FocusScope.of(context).unfocus();
                            if(_networkController.connectionType != 0) {
                              if (logic.phoneNumberController.text.isNotEmpty) {
                                if(logic.phoneNumberController.text.length == 10) {
                                  if (mobileValid == true) {
                                    logic.callForgotPasswordAPI(
                                        mobile: "${logic.phoneNumberController.text}");
                                  } else {
                                    showToastMessage(
                                        "Please enter Proper Mobile Number", toastGravity: ToastGravity.CENTER);
                                  }
                                }else{
                                  showToastMessage("Please enter 10 digit mobile number",  toastGravity: ToastGravity.CENTER);
                                }
                              } else {
                                showToastMessage(enter_mobile,  toastGravity: ToastGravity.CENTER);
                              }
                            }else{
                              showToastMessage(check_internet,  toastGravity: ToastGravity.CENTER, );
                            }
                          }),
                        ),),

                    ],
                  ),
                ),
                isLoading: logic.isLoaderVisible);
          }
          ),
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
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
            ],
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
              prefixIcon:Text("+1", style: TextStyle(
                color: Color(BLACK),
                fontSize: 16,
                fontFamily: FontRoboto,
                fontWeight: RobotoMedium,
              )),
              hintStyle: TextStyle(
                color: Color(HINTCOLOR),
                fontSize: 16,
                fontFamily: FontRoboto,
                fontWeight: RobotoRegular,
              ),
              hintText: hintText,
            ),
            onChanged: (val) {
              setState(() {});
            },
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
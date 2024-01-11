import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/create_account/controller/signup_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keyboard_hider/keyboard_hider.dart';
import 'package:pinput/pinput.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';

class CreateAccountScreen extends StatefulWidget {
  static const String routeName = '/signupUser';

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final SignupController vendorProfileGetController =
      Get.put(SignupController());
  FocusNode focusNode = FocusNode();
  final _networkController = Get.find<GetXNetworkManager>();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.transparent, //change your color here
        ),
        toolbarHeight: 60,
        elevation: 0,
        shadowColor: Color(HINTCOLOR),
        backgroundColor: Color(WHITE),
        flexibleSpace: Container(
          height: double.infinity,
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
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
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(WHITE),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: SafeArea(
          child: GetBuilder<SignupController>(
            builder: (logic) {
              bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(logic.emailController.text);

              // bool mobileValid = RegExp(r"(^(?:[+0]9)?[0-9]{10,11}$)").hasMatch(logic.phoneNumberController.text);
              // bool emailValid = RegExp(r'\S+@\S+\.\S+').hasMatch(logic.emailController.text);
             /* bool fNameValid =
                  RegExp(r"^[a-zA-Z]+").hasMatch(logic.fNameController.text);
              bool lNameValid =
                  RegExp(r"^[a-zA-Z]+").hasMatch(logic.lNameController.text);*/

              return appLoader(
                widget: Column(
                  children: [
                    Flexible(
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
                        ),
                      ),
                      flex: 2,
                      fit: FlexFit.tight,
                    ),
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(GREY),
                        ),
                        child: SingleChildScrollView(
                          child: KeyboardHider(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                customTextInputField(
                                  logic.emailController,
                                  "Enter Email",
                                  "Email",
                                  TextInputType.emailAddress,
                                  TextInputAction.next,
                                  false, false, true,
                                ),
                                customTextInputField(
                                  logic.phoneNumberController,
                                  "Enter Phone Number",
                                  "Phone Number",
                                  TextInputType.phone,
                                  TextInputAction.next,
                                  false,true, false
                                ),
                                customTextInputField(
                                    logic.passwordController,
                                    "Enter Password",
                                    "Password",
                                    TextInputType.visiblePassword,
                                    TextInputAction.done,
                                    true, false, true),
                              ],
                            ),
                          ),
                        ),
                      ),
                      flex: 5,
                      fit: FlexFit.tight,
                    ),
                    Flexible(child:      SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(WHITE),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin:
                              EdgeInsets.fromLTRB(40, 10, 40, 0),
                              child: WidgetButton.widgetDefaultButton(
                                  "Next", () async {
                                if (_networkController.connectionType != 0) {
                                  FocusScope.of(context).unfocus();
                                  if (logic.emailController.text.isNotEmpty &&
                                      logic.passwordController.text
                                          .isNotEmpty &&
                                      logic.phoneNumberController.text
                                          .isNotEmpty) {
                                    debugPrint('EmailValid: $emailValid');
                                    if (emailValid == true) {
                                      // if (mobileValid == true) {
                                      if (logic.phoneNumberController.length == 10) {
                                        if (logic.passwordController.length >= 6) {
                                          logic.callRegistrationAPI();
                                        } else {
                                          showToastMessage(
                                              "Password must be more than 6 digits or characters");
                                        }
                                      }else {
                                        showToastMessage("Please enter 10 digit mobile number");
                                      }
                                    } else {
                                      showToastMessage(
                                          plzEnterProperEmailMsg);
                                    }
                                  } else {
                                    showToastMessage(
                                        "Please enter all required fields");
                                  }
                                } else {
                                  showToastMessage(check_internet);
                                }
                              }),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),flex: 2,)
                  ],
                ),
                isLoading: logic.isLoaderVisible,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget customTextInputField(
      TextEditingController editingController,
      String hintText,
      String lableText,
      TextInputType? keyboardType,
      TextInputAction? textInputAction,
      [bool isPassword = false, bool isMobile = false, bool isEmail = false]) {
    // final LoginController loginController = Get.put(LoginController());
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
            obscureText: isPassword,
            controller: editingController,
            textAlign: TextAlign.start,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            inputFormatters: isMobile ? [
              LengthLimitingTextInputFormatter(10),
            ] : [],
            textCapitalization: isEmail ? TextCapitalization.none : TextCapitalization.sentences,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Color(HINTCOLOR),
                fontSize: 16,
                fontFamily: FontRoboto,
                fontWeight: RobotoRegular,
              ),
              hintText: hintText, 
            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
              prefixIcon:  isMobile ? Text("+1", style: TextStyle(
                color: Color(BLACK),
                fontSize: 16,
                fontFamily: FontRoboto,
                fontWeight: RobotoMedium,
              )) : Text(''),
            ),
            // onEditingComplete: () => FocusScope.of(context).nextFocus(),
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

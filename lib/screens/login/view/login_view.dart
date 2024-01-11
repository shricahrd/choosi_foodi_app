import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/forgot_password/view/forgot_password_email_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keyboard_hider/keyboard_hider.dart';
import 'package:pinput/pinput.dart';
import '../../../core/utils/app_color_utils.dart';
import '../../../core/utils/app_preferences.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../../../core/widgets/widget_button.dart';
import '../../../routes/all_routes.dart';
import '../controller/login_controller.dart';

class LoginView extends StatefulWidget {
  static const String routeName = '/login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController userOTPVerifyController = Get.put(LoginController());
  final _networkController = Get.find<GetXNetworkManager>();
  dynamic fireToken;

  @override
  void initState() {
    // AuthService().handleAuthState();
    setFirebaseToken();
    super.initState();
  }

  void setFirebaseToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      print("FCM Token : ${token}"); // Print the Token in Console
      AppPreferences.setFireToken(token.toString());
      print("FCM Set Token : ${token}");
    }).catchError((onError) {});

    getFirebaseToken();
  }

  getFirebaseToken() async {
    fireToken = await AppPreferences.getFireToken();
    print('FireToken ===> $fireToken');
  }

  @override
  void dispose() {
    userOTPVerifyController.uNameController.clear();
    userOTPVerifyController.passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GetBuilder<LoginController>(
          builder: (logic) {
            return appLoader(
                widget: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          Get.offAllNamed(AllRoutes.start);
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
                      flex: IsCustomerApp? 1 : 2,
                      fit: FlexFit.tight,
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
                              login,
                              Color(ORANGE),
                              28,
                              align: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        child: KeyboardHider(
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
                                    logic.uNameController,
                                    enter_mobile_number,
                                    mobile_number,
                                    TextInputType.phone,
                                    TextInputAction.next, false, true),
                                customTextInputField(
                                    logic.passwordController,
                                    enter_password,
                                    password,
                                    TextInputType.visiblePassword,
                                    TextInputAction.done,
                                    true),
                                // IsCustomerApp ?
                                Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.fromLTRB(0, 5, 40, 0),
                                  child: InkWell(
                                    onTap: onClickForgotPassword,
                                    child: WidgetText.widgetRobotoMediumText(
                                      forgot_password,
                                      Color(ORANGE),
                                      16,
                                      align: TextAlign.end,
                                    ),
                                  ),
                                ),
                                    // : Container(),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                      color: Color(WHITE),
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                                      // margin: EdgeInsets.fromLTRB(40, 30, 40, 0),
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      child: WidgetButton.widgetDefaultButton(
                                          login, () async {
                                        FocusScope.of(context).unfocus();
                                        if (_networkController.connectionType != 0) {
                                          if (logic.uNameController.text.isNotEmpty) {
                                            if (logic.passwordController.text.isNotEmpty) {
                                              if(logic.uNameController.length <= 11) {
                                                if(logic.isEnable == true) {
                                                  logic.callLoginAPI(
                                                    mobile: "${logic.uNameController.text}",
                                                      password: logic.passwordController.text,
                                                      token: fireToken);
                                                }
                                              }else{
                                                showToastMessage(mobile11digitMsg);
                                              }
                                            } else {
                                              showToastMessage(enter_password);
                                            }
                                          } else {
                                            showToastMessage(enter_mobile_number);
                                          }
                                        } else {
                                          showToastMessage(
                                              check_internet);
                                        }
                                        // Get.offAllNamed(AllRoutes.baseRestaurant);
                                      }
                                      ),
                                    )),
                                IsCustomerApp?
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(WHITE),
                                  ),
                                  child: Column(
                                    children: [
                                      WidgetText.widgetRobotoRegularText(
                                        'or',
                                        Color(BLACK),
                                        16,),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                         var result = await logic.currentUser();
                                         // print('UId: ${result?.providerData[0].uid}');
                                          if(result?.uid.isNotEmpty == true){
                                            logic.callSocialLoginAPI(
                                              email: result?.email ?? "",
                                              authId:  result?.providerData[0].uid ?? "",
                                              photo:  result?.photoURL ?? "",
                                              firstname:  result?.displayName?.split(' ').first ?? "",
                                              lastname:  result?.displayName?.split(' ').last ?? "",
                                            );
                                            // await Get.to(() => NewHome());
                                          }
                                        },
                                        child: Card(
                                          elevation: 1,
                                          color: Color(WHITE),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(100.0),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Image.asset(
                                              google_logo,
                                              width: 50,
                                              height: 50,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      flex: 6,
                      fit: FlexFit.tight,
                    ),
                  ],
                ),
                isLoading: logic.isLoaderVisible);
          },
        )
      ),
    );
  }

  Widget customTextInputField(
      TextEditingController editingController,
      String hintText,
      String lableText,
      TextInputType? keyboardType,
      TextInputAction? textInputAction,
      [bool isPassword = false, bool isMobile = false,]) {
    // final LoginController loginController = Get.put(LoginController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(40, 20, 40, 2),
          child: WidgetText.widgetRegularText(
            lableText,
            align: TextAlign.end,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(40, 2, 40, 10),
          decoration: BoxDecoration(
            color: Color(WHITE),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          padding: EdgeInsets.fromLTRB(15,
              isMobile ?
              3 : 0, 15, isMobile ? 3 : 0),
          child: TextFormField(
            obscureText: isPassword,
            controller: editingController,
            textAlign: TextAlign.start,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            inputFormatters: isMobile ? [
              LengthLimitingTextInputFormatter(11),
            ] : [],
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
              prefixIcon:  isMobile ? Text("+1", style: TextStyle(
                color: Color(BLACK),
                fontSize: 16,
                fontFamily: FontRoboto,
                fontWeight: RobotoMedium,
              )): Text(''),
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

  onClickForgotPassword() async {
    await Get.to(() => ForgotPasswordEmailScreen());
    setState(() {
      userOTPVerifyController.isLoaderVisible = false;
      FocusScope.of(context).unfocus();
      userOTPVerifyController.uNameController.clear();
      userOTPVerifyController.passwordController.clear();
    });
  }
}

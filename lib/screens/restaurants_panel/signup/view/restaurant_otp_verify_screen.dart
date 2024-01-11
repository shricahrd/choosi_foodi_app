import 'dart:async';
import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/restaurants_panel/signup/view/tabs/signup_tab_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/utils/app_images_utils.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import '../controller/restaurant_otp_verify_controller.dart';

class RestaurantOTPVerifyScreen extends StatefulWidget {
  final String mobile;

  const RestaurantOTPVerifyScreen(
      {Key? key, required this.mobile,})
      : super(key: key);

  @override
  _EnterOTPScreenState createState() =>
      _EnterOTPScreenState(mobile,);
}

class _EnterOTPScreenState extends State<RestaurantOTPVerifyScreen> {

  _EnterOTPScreenState(
    String mobile,) {
    this.mobile = mobile;
  }

  final RestaurantOTPVerifyController restaurantOTPVerifyController =
      Get.put(RestaurantOTPVerifyController());
  TextEditingController otpController = new TextEditingController();
  final _networkController = Get.find<GetXNetworkManager>();
  String mobile = "";
  bool isProcessing = false;
  String? _verificationCode;
  // String enteredOTP = "";
  String email = "";
  String requiredOTP = "";
  final interval = const Duration(seconds: 1);
  bool timerClose = false;
  bool loadApiImage = false;
  FocusNode _focusNode = FocusNode();

  // final
  int timerMaxSeconds = 30;
  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: '
      '${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  @override
  void initState() {
    mobile = widget.mobile;
    debugPrint('mobile ====> $mobile');
    debugPrint('Start Time');
    startTimeout();
    _verifyPhone();
    super.initState();
  }

  startTimeout() {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      currentSeconds = timer.tick;
      if (mounted) {
        setState(() {
          if (timer.tick >= timerMaxSeconds) {
            timer.cancel();
            debugPrint('setState:');
            otpController.clear();
            timerClose = true;
            isProcessing = false;
          }
        });
      }
    });
  }

  isResendOtp() async {
    if (mounted) {
      timerClose = false;

      setState(() {
        timerMaxSeconds = 30;
        currentSeconds = 0;
        startTimeout();
      });
    }
  }

  _verifyPhone() async {

    debugPrint('Inside Verify Phone: +1$mobile');
    setState(() {
      isProcessing = true;
    });
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+1$mobile',
        verificationCompleted: (PhoneAuthCredential credential) async {
          setState(() {
            isProcessing = false;
          });
          debugPrint('verifyPhoneNumber');
        },
        verificationFailed: (FirebaseAuthException e) {
          // showToastMessage(e.toString());
          debugPrint('verificationFailed');
          debugPrint('FirebaseAuthException: $e');
          debugPrint(e.message);
          showToastMessage(e.message.toString());
          setState(() {
            isProcessing = false;
          });
        },
        codeSent: (String? verficationID, int? resendToken) {
          debugPrint('codeSent');
          showToastMessage(otpSuccessSendMsg);
          if(mounted) {
            setState(() {
              isProcessing = false;
            });
          }
          _verificationCode = verficationID;
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          debugPrint('codeAutoRetrievalTimeout');
          if(mounted) {
            setState(() {
              isProcessing = false;
            });
          }
          _verificationCode = verificationID;
        },
        timeout: Duration(seconds: 120));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(WHITE),
      body: SafeArea(
          child: GetBuilder<RestaurantOTPVerifyController>(builder: (logic) {
            if (logic.otpText != 0) {
              otpController.text = logic.otpText.toString();
            }
            return Container(
              height: MediaQuery.of(context).size.height,
              // color: Colors.blue,
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              child: Stack(
                children: [
                  ListView(
                    shrinkWrap: true,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(
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
                      SizedBox(
                        height: 70,
                      ),
                      WidgetText.widgetRobotoBoldText(
                        "Enter Temporary Password",
                        Color(ORANGE),
                        25,align: TextAlign.center
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Align(
                          alignment: Alignment.center,
                          child: WidgetText.widgetRobotoRegularText(
                              "We have sent a temporary password with a\n6-digit-code to your mobile",
                              Color(BLACK),
                              14,
                              align: TextAlign.center),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                        child: customTextInputField(otpController),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      isProcessing == true
                          ? Center(
                        child: CircularProgressIndicator(
                          color: Color(ORANGE),
                        ),
                      )
                          : Container(),
                      timerClose == false ? Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          WidgetText.widgetRobotoRegularText(
                              "Resend in", Color(DARKGREY), 16,
                              align: TextAlign.center),
                          SizedBox(
                            width: 5,
                          ),
                          WidgetText.widgetRobotoRegularText(
                              timerText,
                              // "00:29",
                              Color(BLACK),
                              16,
                              align: TextAlign.center),
                        ],
                      )
                          : InkWell(
                        onTap: () {
                          setState(() {
                            if(_networkController.connectionType != 0) {
                              // isVerifiedOtp();
                              isResendOtp();
                              _verifyPhone();
                            }else{
                              showToastMessage(check_internet);
                            }
                          });
                        },
                        child: WidgetText.widgetRobotoRegularText(
                            "Resend the otp again", Color(ORANGE), 16,
                            align: TextAlign.center),
                      ),
                      SizedBox(height: 150.0)
                    ],
                  ),
                  loadApiImage == false
                      ? Positioned(
                    bottom: 15,left: 0, right: 0,
                        child: WidgetButton.widgetDefaultButton("Submit", () async {
                            if(_networkController.connectionType != 0) {
                              if (otpController.text != "") {
                                setState(() {
                                  loadApiImage = !loadApiImage;
                                });
                                if (otpController
                                    .text.length == 6) {
                                  try {
                                    debugPrint('In try method');
                                    await FirebaseAuth.instance
                                        .signInWithCredential(
                                      PhoneAuthProvider.credential(
                                          verificationId:
                                          _verificationCode.toString(),
                                          smsCode: otpController.text),)
                                        .then((value) async {
                                      dynamic uid;
                                      debugPrint('In try value: $value');
                                      if (value.user != null) {
                                        uid = FirebaseAuth
                                            .instance.currentUser!.uid;
                                        debugPrint('UserId: $uid');
                                        Get.offAll(() => SignupTabScreen(mobile: mobile,));
                                      } else {
                                        debugPrint('UserId null : $uid');
                                        debugPrint('Else Value: $value');
                                      }
                                    });
                                  } catch (e) {
                                    debugPrint('Else catch Value: ${e
                                        .toString()}');
                                    showToastMessage(inCorrectOTPMsg);
                                    // showToastMessage(e.toString());
                                    setState(() {
                                      loadApiImage = false;
                                    });
                                  }
                                } else {
                                  setState(() {
                                    loadApiImage = false;
                                  });
                                  showToastMessage("Please enter Otp");
                                }
                              } else {
                                showToastMessage("Please enter Otp");
                              }
                            }else{
                              showToastMessage(check_internet);
                            }
                        }),
                      )  : Center(
                    child: CircularProgressIndicator(
                      color: Color(ORANGE),
                    ),
                  ),
                ],
              ),
            );
          })),
    );
  }


  Widget customTextInputField(TextEditingController controller) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Color(WHITE),
        // border: Border.all(color: Color(GREY3)),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.95),
            blurRadius: 1.0,
            offset: Offset(1.0, 2.0),
          ),
        ],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color(ORANGE),),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Pinput(
      length: 6,
      focusNode: _focusNode,
      androidSmsAutofillMethod:  AndroidSmsAutofillMethod.smsRetrieverApi,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      controller: controller,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin) =>
      {otpController.text = pin},
      onSubmitted: (pin) async {},
    );
  }

  @override
  void dispose() {
    currentSeconds = 0;
    super.dispose();
  }
}

import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/reset_password/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class EnterOTPScreen extends StatefulWidget {
  final String requiredOTP;
  final String email;

  const EnterOTPScreen(
      {Key? key, required this.requiredOTP, required this.email})
      : super(key: key);

  @override
  _EnterOTPScreenState createState() =>
      _EnterOTPScreenState(requiredOTP, email);
}

class _EnterOTPScreenState extends State<EnterOTPScreen> {
  String enteredOTP = "";
  String requiredOTP = "";
  String email = "";

  _EnterOTPScreenState(String requiredOTP, String email) {
    this.requiredOTP = requiredOTP;
    this.email = email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      body: SafeArea(
        child: Stack(
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
                    "Enter Temporary Password",
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
                          "We have sent a temporary password with a\n4-digit-code to your email",
                          Color(BLACK),
                          14,
                          align: TextAlign.center),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                    child: customTextInputField(),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      WidgetText.widgetRobotoRegularText(
                          "Resend in", Color(DARKGREY), 16,
                          align: TextAlign.center),
                      SizedBox(
                        width: 5,
                      ),
                      WidgetText.widgetRobotoRegularText("00:29", Color(BLACK), 16,
                          align: TextAlign.center),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 15,
              left: 15,
              right: 15,
              child: WidgetButton.widgetDefaultButton("Submit", onClickSubmit),
            ),
          ],
        ),
      ),
    );
  }

  Widget customTextInputField() {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Pinput(
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      // validator: (s) {
      //   return s == requiredOTP ? null : 'OTP is incorrect';
      // },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin) => {enteredOTP = pin},
    );
  }

  onClickSubmit() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => ResetPasswordScreen(
              enteredOTP: enteredOTP,
              email: email,
            )));
  }
}

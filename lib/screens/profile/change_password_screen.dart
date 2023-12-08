import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Color(WHITE),
              ),
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Image.asset(
                      ic_back,
                      width: 18,
                      height: 18,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  WidgetText.widgetPoppinsRegularText(
                    "Change Password",
                    Color(BLACK),
                    16,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                padding: EdgeInsets.all(25),
                width: double.infinity,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    customTextInputField(emailController, "Enter new password",
                        "New Password", TextInputType.emailAddress),
                    SizedBox(
                      height: 15,
                    ),
                    customTextInputField(
                        emailController,
                        "Enter confirm password",
                        "Confirm Password",
                        TextInputType.phone),
                    SizedBox(
                      height: 25,
                    ),
                    WidgetButton.widgetDefaultButton("Set Password", () {}),
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
        ),
      ),
    );
  }

  Widget customTextInputField(TextEditingController editingController,
      String hintText, String lableText, TextInputType? keyboardType) {
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
          color: Color(WHITE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: TextFormField(
              controller: editingController,
              textAlign: TextAlign.start,
              keyboardType: keyboardType,
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

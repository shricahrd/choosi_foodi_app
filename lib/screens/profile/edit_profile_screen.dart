import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
                    "Edit Profile",
                    Color(BLACK),
                    16,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    ic_profile_place_holder,
                    height: 110,
                    width: 110,
                  ),
                ),
                Positioned(
                  child: InkWell(
                    onTap: () {},
                    child: Image.asset(
                      ic_edit,
                      height: 40,
                      width: 40,
                    ),
                  ),
                  bottom: 0,
                  right: 15,
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Divider(
              color: Color(LIGHTDIVIDERCOLOR),
              height: 2,
              thickness: 2,
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
                    customTextInputField(emailController, "+91 9988776655",
                        "Mobile", TextInputType.phone),
                    SizedBox(
                      height: 15,
                    ),
                    customTextInputField(emailController,
                        "sumangosain@gmail.com", "Email", TextInputType.emailAddress),
                    SizedBox(
                      height: 25,
                    ),
                    WidgetButton.widgetDefaultButton("Save changes", () {}),
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

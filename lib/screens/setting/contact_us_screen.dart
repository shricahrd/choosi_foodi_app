import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/setting/abount_us_screen.dart';
import 'package:choosifoodi/screens/setting/privacy_policy.dart';
import 'package:choosifoodi/screens/setting/return_policy_screen.dart';
import 'package:choosifoodi/screens/setting/terms_screen.dart';
import 'package:flutter/material.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController emailController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.transparent, //change your color here
        ),
        toolbarHeight: 60,
        shadowColor: Colors.transparent,
        backgroundColor: Color(WHITE),
        flexibleSpace: Container(
          height: double.infinity,
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
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
              WidgetText.widgetPoppinsRegularText(
                "Contact Us",
                Color(BLACK),
                18,
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child:  ListView(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
          physics: BouncingScrollPhysics(),
          children: [
            Card(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 7.5),
              color: Color(WHITE),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              shadowColor: Color(BLACK),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: WidgetText.widgetPoppinsRegularText(
                        "Email", Color(0xff575757), 16),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
                    child: WidgetText.widgetPoppinsMediumText(
                        "info@choosifoodi.com", Color(BLACK), 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Color(LIGHTDIVIDERCOLOR),
                    height: 2,
                    thickness: 2,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: WidgetText.widgetPoppinsRegularText(
                        "Phone number", Color(0xff575757), 16),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
                    child: WidgetText.widgetPoppinsMediumText(
                        "+91 9966554488", Color(BLACK), 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 7.5, 0, 0),
              child: WidgetText.widgetPoppinsMediumText(
                "Contact Us",
                Color(BLACK),
                18,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: WidgetText.widgetPoppinsRegularText(
                "Call us or send a message and we ll respond as soon as possible",
                Color(0xff646161),
                14,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            customTextInputField(emailController, "Enter your name",
                "Name*", TextInputType.emailAddress, 1),
            SizedBox(
              height: 10,
            ),
            customTextInputField(emailController, "Enter your email",
                "Email*", TextInputType.emailAddress, 1),
            SizedBox(
              height: 10,
            ),
            customTextInputField(emailController, "Enter your message",
                "Message*", TextInputType.emailAddress, 3),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: WidgetButton.widgetDefaultButton("Send", () {}),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputFieldWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetText.widgetPoppinsRegularText(
            "Name*",
            Color(LIGHTGREYCOLORICON),
            14,
          ),
        ],
      ),
    );
  }

  onClickTerms() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => TermsScreen()));
  }

  onClickAboutUs() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => AboutUsScreen()));
  }

  onClickPrivacyPolicy() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => PrivacyPolicyScreen()));
  }

  onClickReturnPolicy() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ReturnPolicyScreen()));
  }

  Widget customTextInputField(
      TextEditingController editingController,
      String hintText,
      String lableText,
      TextInputType? keyboardType,
      int maxLine) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetText.widgetPoppinsMediumText(
            lableText,
            Color(0xff676767),
            14,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            decoration: BoxDecoration(
              color: Color(WHITE),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: Color(LIGHTGREYCOLORICON)),
            ),
            padding: EdgeInsets.fromLTRB(15, 3, 15, 3),
            child: TextFormField(
              maxLines: maxLine,
              controller: editingController,
              textAlign: TextAlign.start,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Color(HINTCOLOR),
                  fontSize: 16,
                  fontFamily: FontPoppins,
                  fontWeight: PoppinsRegular,
                ),
                hintText: "",
              ),
              style: TextStyle(
                color: Color(BLACK),
                fontSize: 16,
                fontFamily: FontPoppins,
                fontWeight: PoppinsRegular,
              ),
            ),
          )
        ],
      ),
    );
  }
}

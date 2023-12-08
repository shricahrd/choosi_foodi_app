import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/utils/app_preferences.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/cart/cart_screen.dart';
import 'package:choosifoodi/screens/food_detail/foodi_facts.dart';
import 'package:choosifoodi/screens/food_log/food_log_screen.dart';
import 'package:choosifoodi/screens/foodi_goal/foodi_goal_add_edit.dart';
import 'package:choosifoodi/screens/login/start_screen.dart';
import 'package:choosifoodi/screens/orders/orders_screen.dart';
import 'package:choosifoodi/screens/profile/profile_screen.dart';
import 'package:choosifoodi/screens/setting/abount_us_screen.dart';
import 'package:choosifoodi/screens/setting/contact_us_screen.dart';
import 'package:choosifoodi/screens/setting/faq_screen.dart';
import 'package:choosifoodi/screens/setting/privacy_policy.dart';
import 'package:choosifoodi/screens/setting/return_policy_screen.dart';
import 'package:choosifoodi/screens/setting/terms_screen.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
  }

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
              child: WidgetText.widgetPoppinsRegularText(
                "More",
                Color(BLACK),
                18,
              ),
            ),
            Divider(
              color: Color(LIGHTDIVIDERCOLOR),
              height: 2,
              thickness: 2,
            ),
            Flexible(
              child: ListView(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                physics: BouncingScrollPhysics(),
                children: [
                  _menuWidget("My Profile", onClickProfile),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("My Orders", onClickOrder),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("Foodi Goal", onClickFoodiGoal),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("Food Log", onClickFoodiLog),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("Cart", onClickCart),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("Foodi Facts", onClickFoodiFacts),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Color(LIGHTDIVIDERCOLOR),
                    height: 2,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("Contact us", onClickContactUs),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("About us", onClickAboutUs),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("FAQs", onClickFaq),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("Terms & condition", onClickTerms),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("Privacy Policy", onClickPrivacyPolicy),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(ORANGE),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(
                          Size(double.maxFinite, 55.0),
                        ),
                      ),
                      onPressed: showLogOutAlertDialog,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            ic_logout,
                            height: 20,
                            width: 20,
                            color: Color(WHITE),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          WidgetText.widgetPoppinsRegularText(
                            "Logout",
                            Colors.white,
                            16,
                            align: TextAlign.end,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              flex: 1,
              fit: FlexFit.tight,
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuWidget(String title, VoidCallback function) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: InkWell(
        onTap: function,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child:
                  WidgetText.widgetPoppinsRegularText(title, Color(BLACK), 16),
            ),
            Image.asset(
              ic_left_side_arrow,
              height: 15,
              color: Color(BLACK),
              width: 15,
            )
          ],
        ),
      ),
    );
  }

  Future<void> showLogOutAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Alert',
            style: TextStyle(
                color: Color(BLACK), fontSize: 20, fontWeight: FontWeight.w600),
          ),
          content: Text(
            'Are you sure? You want to logout?',
            style: TextStyle(
                color: Color(BLACK), fontSize: 14, fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                    color: Color(BLACK),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Ok',
                style: TextStyle(
                    color: Color(BLACK),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                AppPreferences.clearPreferenceData();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => StartScreen()),
                    (r) => false);
              },
            ),
          ],
        );
      },
    );
  }

  onClickProfile() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()));
  }

  onClickOrder() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => OrdersScreen()));
  }

  onClickFoodiGoal() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => FoodiGoalAddEditScreen(
            isEditFoodiGoal: false, isFromHome: false,isFromSignup: false,)));
  }

  onClickFoodiLog() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => FoodLogScreen()));
  }

  onClickCart() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => CartScreen()));
  }

  onClickFoodiFacts() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => FoodiFactsScreen()));
  }

  onClickFaq() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => FaqScreen()));
  }

  onClickContactUs() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ContactUsScreen()));
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
}

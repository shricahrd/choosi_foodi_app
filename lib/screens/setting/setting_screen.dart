import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/cart/view/cart_screen.dart';
import 'package:choosifoodi/screens/food_detail/view/foodi_facts.dart';
import 'package:choosifoodi/screens/food_log/view/food_log_screen.dart';
import 'package:choosifoodi/screens/foodi_goal/view/foodi_goal_add_edit.dart';
import 'package:choosifoodi/screens/setting/view/abount_us_screen.dart';
import 'package:choosifoodi/screens/contact_us/view/contact_us_screen.dart';
import 'package:choosifoodi/screens/setting/view/faq_screen.dart';
import 'package:choosifoodi/screens/setting/view/privacy_policy.dart';
import 'package:choosifoodi/screens/setting/view/terms_screen.dart';
import 'package:flutter/material.dart';
import '../../core/utils/app_strings_constants.dart';
import '../foodi_goal/view/foodi_goal_result.dart';
import '../orders/view/orders_screen.dart';
import '../profile/view/profile_screen.dart';

class SettingScreen extends StatefulWidget {
  final bool isEditFoodiGoal;

  SettingScreen({required this.isEditFoodiGoal});

  @override
  _SettingScreenState createState() => _SettingScreenState(isEditFoodiGoal);
}

class _SettingScreenState extends State<SettingScreen> {
  bool isEditFoodiGoal = false;

  _SettingScreenState(bool isEditFoodiGoal){
    this.isEditFoodiGoal = isEditFoodiGoal;
  }

  @override
  void initState() {
    debugPrint('isEditFoodiGoal: $isEditFoodiGoal');
    super.initState();
  }
  // FoodiGoalResultScreen

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
                  _menuWidget("Contact Us", onClickContactUs),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("About Us", onClickAboutUs),
                /*  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("FAQs", onClickFaq),*/
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("Terms & Condition", onClickTerms),
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
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
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
            wantLogout,
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
                'Yes',
                style: TextStyle(
                    color: Color(BLACK),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                tokenExpire();
                // AppPreferences.clearPreferenceData();
                // Get.offAndToNamed(AllRoutes.start);
              },
            ),
          ],
        );
      },
    );
  }

  onClickProfile() {
      debugPrint('OnTap to Profile');
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()));
  }

  onClickOrder() {
      debugPrint('OnTap to Order');
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => OrderScreen()));
  }

  onClickFoodiGoal() {
    debugPrint('isEditFoodiGoal: $isEditFoodiGoal');
    if(isEditFoodiGoal == true) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) =>
              FoodiGoalResultScreen(
                isFromHome: false,isEdit: true,)));
    }else{
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) =>
              FoodiGoalAddEditScreen(
                isEditFoodiGoal: false, isFromHome: false,)));
    }
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

}

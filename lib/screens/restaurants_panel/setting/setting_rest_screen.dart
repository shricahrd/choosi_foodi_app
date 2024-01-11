import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/food_detail/view/foodi_facts.dart';
import 'package:choosifoodi/screens/restaurants_panel/ledger/view/ledger_screen.dart';
import 'package:choosifoodi/screens/restaurants_panel/profileRest/view/profile_rest_screen.dart';
import 'package:choosifoodi/screens/restaurants_panel/restaurant_menu/view/restaurant_menu.dart';
import 'package:choosifoodi/screens/setting/view/abount_us_screen.dart';
import 'package:choosifoodi/screens/contact_us/view/contact_us_screen.dart';
import 'package:choosifoodi/screens/setting/view/faq_screen.dart';
import 'package:choosifoodi/screens/setting/view/privacy_policy.dart';
import 'package:choosifoodi/screens/setting/view/terms_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../analytics/view/analytics_view_screen.dart';
import '../category/view/category_list.dart';
import '../deals/view/deals_screen.dart';
import '../delivery/view/delivery_charges_screen.dart';
import '../order/view/orders_mgmt_screen.dart';
import '../slots/view/hours_mgmt_screen.dart';

class SettingRestScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingRestScreen> {
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
                16,
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
                  _menuWidget("Profile", onClickProfile),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("Menu", onClickMenu),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("Order Management", onClickOrderScreen),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("Category Management", onClickCategory),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("Ledger", onClickLedger),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("Analytics", onClickAnalytics),
                  SizedBox(
                    height: 20,
                  ),
                   _menuWidget("Hours of Operation", onClickSlots),
                  SizedBox(
                    height: 20,
                  ),
                   _menuWidget("Deals", onClickCoupon),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("Delivery", onClickDeliveryCharge),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("Privacy Policy", onClickPrivacyPolicy),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("Terms & Conditions", onClickTerms),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              flex: 1,
              fit: FlexFit.tight,
            ),
            Container(
              height: 60,
              width: 300,
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
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
                    WidgetText.widgetPoppinsMediumText(
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
              color: Color(ORANGE),
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
          backgroundColor: Color(WHITE),
          elevation: 2,
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
                'No',
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
              },
            ),
          ],
        );
      },
    );
  }

  onClickProfile() {
    Get.to(()=> ProfileRestScreen(
      isFromHome: false,
    ));
  }

  onClickMenu() {
    Get.to(()=> RestaurantMenuScreen());
  }

  onClickOrderScreen() {
    Get.to(()=> OrderManagementScreen( isFromHome: false,));
  }

  onClickLedger() {
    Get.to(()=> LedgerScreen());
  }

  onClickAnalytics() {
    Get.to(()=> RestaurantAnalytics());
  }

  onClickCoupon() {
    Get.to(()=> DealsScreen());
  }

  onClickDeliveryCharge() {
    Get.to(()=> DeliveryChargesScreen());
  }

  onClickFoodiFacts() {
    Get.to(()=> FoodiFactsScreen());
  }

  onClickFaq() {
    Get.to(()=> FaqScreen());
  }

  onClickContactUs() {
    Get.to(()=> ContactUsScreen());
  }

  onClickSlots() {
    Get.to(()=> HoursMgmtScreen());
  }

  onClickTerms() {
    Get.to(()=> TermsScreen());
  }

  onClickAboutUs() {
    Get.to(()=> AboutUsScreen());
  }

  onClickPrivacyPolicy() {
    Get.to(()=> PrivacyPolicyScreen());
  }

  onClickCategory() {
    Get.to(()=> CategoryList());
  }

}

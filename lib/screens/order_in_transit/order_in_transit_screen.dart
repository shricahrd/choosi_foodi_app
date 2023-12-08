import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/base_application/base_application.dart';
import 'package:choosifoodi/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class OrderInTransitDialogScreen extends StatefulWidget {
  @override
  _OrderInTransitDialogScreenState createState() =>
      _OrderInTransitDialogScreenState();
}

class _OrderInTransitDialogScreenState
    extends State<OrderInTransitDialogScreen> {
  bool macroCal = true;
  int _dietaryValue = 0;
  double _distanceValue = 10.0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: SafeArea(
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff10000000),
              ),
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                decoration: BoxDecoration(
                  color: Color(WHITE),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Image.asset(
                        ic_sheet_divider,
                        width: 200,
                        height: 5,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: Container(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: WidgetText.widgetRobotoMediumText(
                                  "Preparing Your Order",
                                  Color(ORANGE),
                                  20,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                child: WidgetText.widgetRobotoRegularText(
                                  "Arrives between 7:46PM-:00PM",
                                  Color(LIGHTERHINTCOLOR),
                                  12,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Image.asset(
                                temp_img_map,
                                fit: BoxFit.fill,
                                width: double.infinity,
                                height: 220,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      app_icon,
                                      width: 28,
                                      height: 28,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      width: 50,
                                      child: Divider(
                                        thickness: 1,
                                        color: Color(ORANGE),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Image.asset(
                                      ic_store,
                                      width: 28,
                                      height: 22,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      width: 50,
                                      child: Divider(
                                        thickness: 1,
                                        color: Color(LIGHTGREYCOLORICON),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Image.asset(
                                      ic_car,
                                      width: 32,
                                      height: 24,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      width: 50,
                                      child: Divider(
                                        thickness: 1,
                                        color: Color(LIGHTGREYCOLORICON),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Image.asset(
                                      ic_home,
                                      width: 28,
                                      height: 25,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(30, 15, 0, 0),
                                child: WidgetText.widgetRobotoRegularText(
                                  "Vinnie Vegans is preparing your order",
                                  Color(LIGHTERHINTCOLOR),
                                  12,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                                child: Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: Color(DIVIDERCOLOR)),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(30, 15, 0, 0),
                                child: WidgetText.widgetRobotoMediumText(
                                  "Details",
                                  Color(BLACK),
                                  20,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                                child: Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: Color(DIVIDERCOLOR)),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(30, 15, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: WidgetText.widgetRobotoRegularText(
                                        "Order from:",
                                        Color(BLACK),
                                        16,
                                      ),
                                      flex: 3,
                                      fit: FlexFit.tight,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: WidgetText.widgetRobotoRegularText(
                                        "Vegan Vinnies",
                                        Color(BLACK),
                                        16,
                                      ),
                                      flex: 7,
                                      fit: FlexFit.tight,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                                child: Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: Color(DIVIDERCOLOR)),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(30, 15, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: WidgetText.widgetRobotoRegularText(
                                        "Delivery to:",
                                        Color(BLACK),
                                        16,
                                      ),
                                      flex: 3,
                                      fit: FlexFit.tight,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: WidgetText.widgetRobotoRegularText(
                                        "240 Parsons Avenue",
                                        Color(BLACK),
                                        16,
                                      ),
                                      flex: 6,
                                      fit: FlexFit.tight,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: Image.asset(
                                        ic_left_side_arrow,
                                        width: 20,
                                        height: 20,
                                        color: Color(LIGHTGREYCOLORICON),
                                      ),
                                      flex: 1,
                                      fit: FlexFit.tight,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 15, 0, 0),
                                child: Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: Color(DIVIDERCOLOR)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        onWillPop: _onWillPop);
  }

  Future<bool> _onWillPop() async {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => BaseApplication()), (r) => false);

    return false;
  }

  onClickFilterApply() {
    Navigator.of(context).pop(true);
  }
}

import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_radio_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/group_orders/create_group_screen.dart';
import 'package:choosifoodi/screens/order_checkout/payment_screen.dart';
import 'package:flutter/material.dart';

class CheckoutPaymentScreen extends StatefulWidget {
  @override
  _CheckoutPaymentScreenState createState() => _CheckoutPaymentScreenState();
}

class _CheckoutPaymentScreenState extends State<CheckoutPaymentScreen> {
  int _deliveryTipValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 60,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: WidgetText.widgetRobotoRegularText(
                      "Vegan Vinnies",
                      Color(BLACK),
                      20,
                    ),
                  ),
                  Positioned(
                    left: 5,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(false);
                        },
                        child: WidgetText.widgetRobotoRegularText(
                          "Cancel",
                          Color(ORANGE),
                          14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    WidgetText.widgetRobotoMediumText(
                      "Delivery Details",
                      Color(BLACK),
                      16,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                        height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  WidgetText.widgetRobotoRegularText(
                                    "240 Parsons Avenue",
                                    Color(BLACK),
                                    16,
                                  ),
                                  WidgetText.widgetRobotoRegularText(
                                    "Columbus, OH",
                                    Color(SUBTEXT),
                                    16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Image.asset(
                            ic_left_side_arrow,
                            height: 18,
                            width: 18,
                            color: Color(GREYCOLORICON),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                        height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  WidgetText.widgetRobotoRegularText(
                                    "Phone Number",
                                    Color(BLACK),
                                    16,
                                  ),
                                  WidgetText.widgetRobotoRegularText(
                                    "555-555-5555",
                                    Color(SUBTEXT),
                                    16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Image.asset(
                            ic_left_side_arrow,
                            height: 18,
                            width: 18,
                            color: Color(GREYCOLORICON),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                        height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                    SizedBox(
                      height: 30,
                    ),
                    WidgetText.widgetRobotoRegularText(
                      "Payment",
                      Color(BLACK),
                      16,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    WidgetText.widgetRobotoRegularText(
                      "Delivery Tip",
                      Color(BLACK),
                      16,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _deliveryTipValue = 0;
                                });
                              },
                              child: _deliveryTipValue == 0
                                  ? WidgetRadioButton.selectedRadioButton("\$3")
                                  : WidgetRadioButton.unselectedRadioButton(
                                      "\$3"),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _deliveryTipValue = 1;
                                });
                              },
                              child: _deliveryTipValue == 1
                                  ? WidgetRadioButton.selectedRadioButton("\$4")
                                  : WidgetRadioButton.unselectedRadioButton(
                                      "\$4"),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _deliveryTipValue = 2;
                                });
                              },
                              child: _deliveryTipValue == 2
                                  ? WidgetRadioButton.selectedRadioButton("\$5")
                                  : WidgetRadioButton.unselectedRadioButton(
                                      "\$5"),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _deliveryTipValue = 3;
                                });
                              },
                              child: _deliveryTipValue == 3
                                  ? WidgetRadioButton.selectedRadioButton(
                                      "Other")
                                  : WidgetRadioButton.unselectedRadioButton(
                                      "Other"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                        height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 15, 15, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      WidgetText.widgetRobotoRegularText(
                                        "Payment",
                                        Color(BLACK),
                                        16,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: WidgetText.widgetRobotoRegularText(
                                            "MasterCard...111",
                                            Color(BLACK),
                                            16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Image.asset(
                                        ic_left_side_arrow,
                                        height: 18,
                                        width: 18,
                                        color: Color(GREYCOLORICON),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: Color(DIVIDERCOLOR)),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: WidgetButton.widgetDefaultButton(
                  "Place Order", onClickPlaceOrder),
            ),
          ],
        ),
      ),
    );
  }

  onClickPlaceOrder() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => PaymentScreen()));
  }

  onClickGroupOrder() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => CreateGroupScreen()));
  }
}

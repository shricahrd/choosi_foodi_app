import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/food_detail/food_detail_screen.dart';
import 'package:choosifoodi/screens/order_in_transit/order_in_transit_screen.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
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
              alignment: Alignment.centerLeft,
              child: Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: WidgetText.widgetRobotoRegularText(
                      "Payment",
                      Color(BLACK),
                      20,
                    ),
                  ),
                  Positioned(
                    left: 15,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Image.asset(
                          ic_right_side_arrow,
                          width: 18,
                          height: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    WidgetText.widgetRobotoMediumText(
                      "Saved Payment Methods",
                      Color(BLACK),
                      16,
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
                                  padding: EdgeInsets.fromLTRB(0, 15, 15, 15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.asset(
                                        ic_master_card,
                                        height: 24,
                                        width: 34,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              WidgetText.widgetRobotoRegularText(
                                                "MasterCard...111",
                                                Color(BLACK),
                                                16,
                                              ),
                                              WidgetText.widgetRobotoRegularText(
                                                "Exp.01/2020",
                                                Color(LIGHTHINTCOLOR),
                                                16,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      index == 0
                                          ? Image.asset(
                                              ic_select_round_radio,
                                              height: 22,
                                              width: 22,
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                                Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: Color(DIVIDERCOLOR)),
                              ],
                            ),
                          );
                        }),
                    SizedBox(
                      height: 30,
                    ),
                    WidgetText.widgetRobotoMediumText(
                      "Add Payment Methods",
                      Color(BLACK),
                      16,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                        height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        index == 0
                                            ? ic_paypal
                                            : index == 1
                                                ? ic_apple_pay
                                                : ic_cards,
                                        height: 24,
                                        width: 34,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: WidgetText.widgetRobotoRegularText(
                                            index == 0
                                                ? "Paypal"
                                                : index == 1
                                                    ? "Apple Pay"
                                                    : "Credit/Debit Card",
                                            Color(BLACK),
                                            16,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
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
              child:
                  WidgetButton.widgetDefaultButton("Next", onClickPlaceOrder),
            ),
          ],
        ),
      ),
    );
  }

  onClickPlaceOrder() {
    FoodDetailScreen.setIsGroupOrder(false);

    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => OrderInTransitDialogScreen()));
  }
}

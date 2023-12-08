import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_radio_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/address/address_screen.dart';
import 'package:choosifoodi/screens/base_application/base_application.dart';
import 'package:choosifoodi/screens/coupons/coupons_code_screen.dart';
import 'package:choosifoodi/screens/group_orders/create_group_screen.dart';
import 'package:choosifoodi/screens/order_checkout/checkout_payment_screen.dart';
import 'package:flutter/material.dart';

class OrderCheckoutScreen extends StatefulWidget {
  @override
  _OrderCheckoutScreenState createState() => _OrderCheckoutScreenState();
}

class _OrderCheckoutScreenState extends State<OrderCheckoutScreen> {
  int _orderTypeValue = 0;

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
              Flexible(
                child: WidgetText.widgetPoppinsRegularText(
                  "Checkout",
                  Color(BLACK),
                  18,
                ),
                flex: 1,
                fit: FlexFit.tight,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _orderTypeValue = 0;
                              });
                            },
                            child: _orderTypeValue == 0
                                ? WidgetRadioButton.selectedRadioButton(
                                    "Delivery")
                                : WidgetRadioButton.unselectedRadioButton(
                                    "Delivery"),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _orderTypeValue = 1;
                              });
                            },
                            child: _orderTypeValue == 1
                                ? WidgetRadioButton.selectedRadioButton(
                                    "Pickup")
                                : WidgetRadioButton.unselectedRadioButton(
                                    "Pickup"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
              SizedBox(
                height: _orderTypeValue == 1 ? 15 : 0,
              ),
              _orderTypeValue == 1
                  ? WidgetText.widgetPoppinsMediumText(
                      "Time slot",
                      Color(BLACK),
                      16,
                    )
                  : Container(),
              _orderTypeValue == 1
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              cancelOrderDialog(context);
                            },
                            child: Card(
                              elevation: 5,
                              color: Color(WHITE),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                                child: WidgetText.widgetPoppinsRegularText(
                                  "4:30PM - 6:30 PM",
                                  Color(DARKGREY),
                                  16,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                      ],
                    )
                  : Container(),
              SizedBox(
                height: 15,
              ),
              WidgetText.widgetPoppinsMediumText(
                "Mr. Rajesh Verma",
                Color(BLACK),
                14,
              ),
              WidgetText.widgetPoppinsRegularText(
                "9988776655",
                Color(BLACK),
                14,
              ),
              WidgetText.widgetPoppinsRegularText(
                "H.No. 524, 2nd Floor, Nehru Place, New Delhi\nDelhi - 110019",
                Color(LIGHTTEXTCOLOR),
                14,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: WidgetButton.widgetDefaultButton(
                        "Change address", onClickChangeAddress),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Divider(height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
              SizedBox(
                height: 15,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  temp_img_food1,
                                  width: 110,
                                  height: 95,
                                  fit: BoxFit.fill,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      WidgetText.widgetPoppinsMediumText(
                                        "Apricot Chicken",
                                        Color(BLACK),
                                        16,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      WidgetText.widgetPoppinsMediumText(
                                        "\$124",
                                        Color(ORANGE),
                                        14,
                                      )
                                    ],
                                  ),
                                ),
                                Image.asset(
                                  ic_delete,
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.fill,
                                ),
                              ],
                            ),
                            Positioned(
                              right: 0,
                              bottom: 5,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                                decoration: BoxDecoration(
                                  color: Color(WHITE),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                      color: Color(BORDERCOLOR), width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.asset(
                                      ic_descrease,
                                      width: 15,
                                      height: 15,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    WidgetText.widgetPoppinsMediumText(
                                      "1",
                                      Color(BLACK),
                                      14,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Image.asset(
                                      ic_increase,
                                      width: 15,
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                decoration: BoxDecoration(
                                  color: Color(0xffF9F7F8),
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    WidgetText.widgetPoppinsRegularText(
                                      "Calories",
                                      Color(BLACK),
                                      13,
                                    ),
                                    WidgetText.widgetPoppinsMediumText(
                                      "34g",
                                      Color(BLACK),
                                      14,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                decoration: BoxDecoration(
                                  color: Color(0xffF9F7F8),
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    WidgetText.widgetPoppinsRegularText(
                                      "Fat",
                                      Color(BLACK),
                                      13,
                                    ),
                                    WidgetText.widgetPoppinsMediumText(
                                      "34g",
                                      Color(BLACK),
                                      14,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                decoration: BoxDecoration(
                                  color: Color(0xffF9F7F8),
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    WidgetText.widgetPoppinsRegularText(
                                      "Carbs",
                                      Color(BLACK),
                                      13,
                                    ),
                                    WidgetText.widgetPoppinsMediumText(
                                      "34g",
                                      Color(BLACK),
                                      14,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                decoration: BoxDecoration(
                                  color: Color(0xffF9F7F8),
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    WidgetText.widgetPoppinsRegularText(
                                      "Protein",
                                      Color(BLACK),
                                      13,
                                    ),
                                    WidgetText.widgetPoppinsMediumText(
                                      "34g",
                                      Color(BLACK),
                                      14,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(DIVIDERCOLOR)),
                      ],
                    );
                  }),
              SizedBox(
                height: 10,
              ),
              WidgetText.widgetPoppinsMediumText(
                "Total",
                Color(BLACK),
                16,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      decoration: BoxDecoration(
                        color: Color(WHITE),
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Color(ORANGE), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          WidgetText.widgetPoppinsRegularText(
                            "Calories",
                            Color(BLACK),
                            13,
                          ),
                          WidgetText.widgetPoppinsMediumText(
                            "34g",
                            Color(BLACK),
                            14,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      decoration: BoxDecoration(
                        color: Color(WHITE),
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Color(ORANGE), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          WidgetText.widgetPoppinsRegularText(
                            "Fat",
                            Color(BLACK),
                            13,
                          ),
                          WidgetText.widgetPoppinsMediumText(
                            "34g",
                            Color(BLACK),
                            14,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      decoration: BoxDecoration(
                        color: Color(WHITE),
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Color(ORANGE), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          WidgetText.widgetPoppinsRegularText(
                            "Carbs",
                            Color(BLACK),
                            13,
                          ),
                          WidgetText.widgetPoppinsMediumText(
                            "34g",
                            Color(BLACK),
                            14,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      decoration: BoxDecoration(
                        color: Color(WHITE),
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Color(ORANGE), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          WidgetText.widgetPoppinsRegularText(
                            "Protein",
                            Color(BLACK),
                            13,
                          ),
                          WidgetText.widgetPoppinsMediumText(
                            "34g",
                            Color(BLACK),
                            14,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: onClickApplyCoupon,
                child: Card(
                  elevation: 5,
                  color: Color(WHITE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: Row(
                      children: [
                        Image.asset(
                          ic_offer,
                          height: 22,
                          width: 22,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: WidgetText.widgetPoppinsRegularText(
                            "Apply Coupon",
                            Color(BLACK),
                            14,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          ic_left_side_arrow,
                          color: Color(BLACK),
                          height: 20,
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(WHITE),
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Color(ORANGE), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WidgetText.widgetPoppinsMediumText(
                      "Price Details",
                      Color(BLACK),
                      18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: WidgetText.widgetPoppinsMediumText(
                              "Amount (2 items)",
                              Color(BLACK),
                              14,
                            ),
                          ),
                        ),
                        WidgetText.widgetPoppinsMediumText(
                          "\$202",
                          Color(ORANGE),
                          14,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: WidgetText.widgetPoppinsMediumText(
                              "Tax",
                              Color(BLACK),
                              14,
                            ),
                          ),
                        ),
                        WidgetText.widgetPoppinsMediumText(
                          "\$14",
                          Color(ORANGE),
                          14,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: WidgetText.widgetPoppinsMediumText(
                              "Discount",
                              Color(BLACK),
                              14,
                            ),
                          ),
                        ),
                        WidgetText.widgetPoppinsMediumText(
                          "\$10",
                          Color(ORANGE),
                          14,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: WidgetText.widgetPoppinsMediumText(
                              "Delivery charges",
                              Color(BLACK),
                              14,
                            ),
                          ),
                        ),
                        WidgetText.widgetPoppinsMediumText(
                          "\$4",
                          Color(ORANGE),
                          14,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Color(LIGHTDIVIDERCOLOR),
                      height: 1,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: WidgetText.widgetPoppinsMediumText(
                              "Total",
                              Color(BLACK),
                              16,
                            ),
                          ),
                        ),
                        WidgetText.widgetPoppinsMediumText(
                          "\$230",
                          Color(ORANGE),
                          16,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              WidgetButton.widgetDefaultButton(
                  "Proceed to checkout", onClickProcessToCheckOut),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  onClickChangeAddress() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => AddressScreen()));
  }

  onClickProcessToCheckOut() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => BaseApplication()),
        (r) => false);
  }

  onClickApplyCoupon() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => CouponsCodeScreen()));
  }

  onClickContinue() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => CheckoutPaymentScreen()));
  }

  onClickGroupOrder() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => CreateGroupScreen()));
  }

  void cancelOrderDialog(BuildContext mContext) {
    showDialog(
        context: mContext,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.0)),
            //this right here
            child: Container(
              height: 250,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: WidgetText.widgetPoppinsMediumText(
                      "Set Time Slot",
                      Color(BLACK),
                      18,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Card(
                            elevation: 5,
                            color: Color(WHITE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              child: WidgetText.widgetPoppinsRegularText(
                                "9:00 AM - 11:00 AM",
                                Color(DARKGREY),
                                12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Card(
                            elevation: 5,
                            color: Color(WHITE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              child: WidgetText.widgetPoppinsRegularText(
                                "11:00 AM - 12:30 PM",
                                Color(DARKGREY),
                                12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Card(
                            elevation: 5,
                            color: Color(WHITE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              child: WidgetText.widgetPoppinsRegularText(
                                "12:30 PM - 2:00 PM",
                                Color(DARKGREY),
                                12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Card(
                            elevation: 5,
                            color: Color(WHITE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(10),
                              child: WidgetText.widgetPoppinsRegularText(
                                "2:00 PM - 3:30 PM",
                                Color(DARKGREY),
                                12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  WidgetButton.widgetDefaultButton("Submit", () {
                    Navigator.pop(context);
                  }),
                ],
              ),
            ),
          );
        });
  }
}

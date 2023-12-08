import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/order_checkout/order_checkout_screen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
                  "Cart",
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
                                        height: 3,
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
                  "Proceed to checkout", onClickOrderCheckOut),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  onClickOrderCheckOut() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => OrderCheckoutScreen()));
  }
}

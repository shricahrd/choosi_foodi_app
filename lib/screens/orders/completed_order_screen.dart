import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/orders/order_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompletedOrdersScreen extends StatefulWidget {
  @override
  _CompletedOrdersScreenState createState() => _CompletedOrdersScreenState();
}

class _CompletedOrdersScreenState extends State<CompletedOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.transparent, //change your color here
        ),
        toolbarHeight: 60,
        shadowColor: Color(HINTCOLOR),
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
                "Completed orders",
                Color(BLACK),
                18,
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Color(WHITE),
          ),
          padding: EdgeInsets.all(15),
          width: double.infinity,
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Color(WHITE),
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Color(ORANGE), width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          WidgetText.widgetPoppinsRegularText(
                            "Order ID: ",
                            Color(SUBTEXT),
                            12,
                          ),
                          WidgetText.widgetPoppinsBoldText(
                            "CF1645",
                            Color(DARKGREY),
                            12,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            temp_img_food1,
                            width: 80,
                            height: 70,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                WidgetText.widgetPoppinsMediumText(
                                  "Mean Green Lean",
                                  Color(BLACK),
                                  16,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    WidgetText.widgetPoppinsRegularText(
                                      "Total amount: ",
                                      Color(SUBTEXT),
                                      10,
                                    ),
                                    WidgetText.widgetPoppinsMediumText(
                                      "\$124",
                                      Color(BLACK),
                                      10,
                                    )
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    WidgetText.widgetPoppinsRegularText(
                                      "Delivered on date: ",
                                      Color(SUBTEXT),
                                      10,
                                    ),
                                    WidgetText.widgetPoppinsMediumText(
                                      "15-2-22",
                                      Color(BLACK),
                                      10,
                                    )
                                  ],
                                ),
                              ],
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
                                    Color(SUBTEXT),
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
                                    Color(SUBTEXT),
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
                                    Color(SUBTEXT),
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
                                    Color(SUBTEXT),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        OrderDetailsScreen(
                                          orderStatus: 1,
                                        )));
                              },
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                decoration: BoxDecoration(
                                  color: Color(ORANGE),
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                ),
                                alignment: Alignment.center,
                                child: WidgetText.widgetPoppinsMediumText(
                                  "View details",
                                  Color(WHITE),
                                  13,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                              decoration: BoxDecoration(
                                color: Color(WHITE),
                                shape: BoxShape.rectangle,
                                border:
                                    Border.all(color: Color(ORANGE), width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)),
                              ),
                              alignment: Alignment.center,
                              child: WidgetText.widgetPoppinsMediumText(
                                "Reorder",
                                Color(ORANGE),
                                13,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

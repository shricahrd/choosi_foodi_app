import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_radio_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/cart/cart_screen.dart';
import 'package:choosifoodi/screens/food_detail/food_item_add_screen.dart';
import 'package:choosifoodi/screens/group_orders/create_group_screen.dart';
import 'package:choosifoodi/screens/view_group_order_dialog/view_group_order_dialog_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class FoodiFactsScreen extends StatefulWidget {
  @override
  _FoodiFactsScreenState createState() => _FoodiFactsScreenState();
}

class _FoodiFactsScreenState extends State<FoodiFactsScreen> {
  int _orderTypeValue = 0;
  int _addItemInCart = 0;

  List<String> images = [
    temp_img_food1,
    temp_img_food2,
    temp_img_food2,
    temp_img_food1,
    temp_img_food2,
    temp_img_food2
  ];

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
                    "Foodi Facts",
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
        body: Container(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image.asset(
                              temp_img_food1,
                              height: 190,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: WidgetText.widgetPoppinsMediumText(
                              "Noodle",
                              Color(BLACK),
                              16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: WidgetText.widgetPoppinsRegularText(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy  ",
                              Color(SUBTEXT),
                              10,
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
                    ],
                  ),
                );
              }),
        ));
  }
}

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

class FoodDetailScreen extends StatefulWidget {
  static bool _isGroupOrder = false;

  static bool getIsGroupOrder() {
    return _isGroupOrder;
  }

  static void setIsGroupOrder(bool bool) {
    _isGroupOrder = bool;
  }

  @override
  _FoodDetailScreenState createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
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
                  "Breakfast club",
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
      body: Stack(
        children: [
          SafeArea(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Stack(
                  children: [
                    Image.asset(
                      temp_img_food_1_1,
                      height: 210,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      right: 0,
                      top: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(ORANGE),
                              blurRadius: 3.0,
                            ),
                          ],
                          color: Color(ORANGE),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0),
                          ),
                        ),
                        height: 30,
                        width: 70,
                        alignment: Alignment.center,
                        child: WidgetText.widgetPoppinsMediumText(
                            "Open", Color(WHITE), 14),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(WHITE),
                              blurRadius: 3.0,
                            ),
                          ],
                          color: Color(WHITE),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        height: 35,
                        width: 90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              ic_timer,
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            WidgetText.widgetPoppinsMediumText(
                                "27 min", Color(BLACK), 14)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WidgetText.widgetPoppinsMediumText(
                              "The Breakfast Club", Color(BLACK), 18),
                          SizedBox(
                            height: 10,
                          ),
                          WidgetText.widgetPoppinsMediumText(
                              "Italian", Color(SUBTEXTBLACKCOLOR), 16),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                ic_location_pin,
                                height: 25,
                                width: 25,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              WidgetText.widgetPoppinsMediumText(
                                  "5 miles", Color(BLACK), 14),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              WidgetText.widgetPoppinsMediumText(
                                  "Delivery : ", Color(BLACK), 14),
                              SizedBox(
                                width: 3,
                              ),
                              WidgetText.widgetPoppinsBoldText(
                                  "Available", Color(BLACK), 14),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          FoodDetailScreen._isGroupOrder
                              ? Container(
                                  width: 250,
                                  child: WidgetButton.widgetDefaultButton(
                                      "VIEW GROUP ORDER",
                                      onClickViewGroupOrder),
                                )
                              : Container(
                                  width: 250,
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Color(ORANGE),
                                      ),
                                      minimumSize:
                                          MaterialStateProperty.all<Size>(
                                        Size(double.maxFinite, 55.0),
                                      ),
                                    ),
                                    onPressed: onClickGroupOrder,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          ic_plus,
                                          height: 18,
                                          width: 18,
                                          color: Color(WHITE),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        WidgetText.widgetPoppinsMediumText(
                                          "CREATE GROUP ORDER",
                                          Colors.white,
                                          16,
                                          align: TextAlign.end,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 15,
                          ),
                          FoodDetailScreen._isGroupOrder
                              ? Container()
                              : Row(
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
                                                  ? WidgetRadioButton
                                                      .selectedRadioButton(
                                                          "Delivery")
                                                  : WidgetRadioButton
                                                      .unselectedRadioButton(
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
                                                  ? WidgetRadioButton
                                                      .selectedRadioButton(
                                                          "Pickup")
                                                  : WidgetRadioButton
                                                      .unselectedRadioButton(
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
                        ],
                      ),
                    ),
                    Divider(
                        height: 5,
                        thickness: 5,
                        color: Color(LIGHTDIVIDERCOLOR)),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: WidgetText.widgetPoppinsMediumText(
                        "Foodi Menu",
                        Color(BLACK),
                        18,
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
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
                                            "BBQ Chicken Breast",
                                            Color(BLACK),
                                            16,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 3, 10, 3),
                                            decoration: BoxDecoration(
                                              color: Color(WHITE),
                                              shape: BoxShape.rectangle,
                                              border: Border.all(
                                                  color: Color(BORDERCOLOR),
                                                  width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
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
                                                WidgetText
                                                    .widgetPoppinsMediumText(
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
                                          SizedBox(
                                            height: 10,
                                          ),
                                          WidgetText.widgetPoppinsMediumText(
                                            "\$124",
                                            Color(ORANGE),
                                            14,
                                          )
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
                                        padding:
                                            EdgeInsets.fromLTRB(0, 15, 0, 15),
                                        decoration: BoxDecoration(
                                          color: Color(0xffF9F7F8),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                        padding:
                                            EdgeInsets.fromLTRB(0, 15, 0, 15),
                                        decoration: BoxDecoration(
                                          color: Color(0xffF9F7F8),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                        padding:
                                            EdgeInsets.fromLTRB(0, 15, 0, 15),
                                        decoration: BoxDecoration(
                                          color: Color(0xffF9F7F8),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                        padding:
                                            EdgeInsets.fromLTRB(0, 15, 0, 15),
                                        decoration: BoxDecoration(
                                          color: Color(0xffF9F7F8),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                // Align(
                                //   alignment: Alignment.centerLeft,
                                //   child: WidgetText.widgetPoppinsMediumText(
                                //     "Food description",
                                //     Color(BLACK),
                                //     14,
                                //   ),
                                // ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: WidgetText.widgetPoppinsRegularText(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry lorem Ipsum has been the industry's standard",
                                    Color(BLACK),
                                    14,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: InkWell(
                                        onTap: onClickItemAddOrder,
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 10, 0, 10),
                                          decoration: BoxDecoration(
                                            color: Color(ORANGE),
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7)),
                                          ),
                                          alignment: Alignment.center,
                                          child: WidgetText
                                              .widgetPoppinsMediumText(
                                            "Add to cart",
                                            Color(WHITE),
                                            14,
                                          ),
                                        ),
                                      ),
                                      flex: 1,
                                      fit: FlexFit.loose,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 10, 0, 10),
                                          decoration: BoxDecoration(
                                            color: Color(ORANGE),
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7)),
                                          ),
                                          alignment: Alignment.center,
                                          child: WidgetText
                                              .widgetPoppinsMediumText(
                                            "Buy Now",
                                            Color(WHITE),
                                            14,
                                          ),
                                        ),
                                      ),
                                      flex: 1,
                                      fit: FlexFit.loose,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: Container(),
                                      flex: 1,
                                      fit: FlexFit.loose,
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
                            ),
                          );
                        }),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: WidgetText.widgetPoppinsMediumText(
                        "Ratings & Reviews",
                        Color(BLACK),
                        18,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          WidgetText.widgetPoppinsMediumText(
                            "4.5/5",
                            Color(BLACK),
                            18,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          WidgetText.widgetPoppinsRegularText(
                            "(150 reviews)",
                            Color(LIGHTTEXTCOLOR),
                            12,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          RatingStars(
                            value: 3.5,
                            onValueChanged: (v) {},
                            starBuilder: (index, color) => Icon(
                              Icons.star_rounded,
                              color: color,
                            ),
                            maxValueVisibility: false,
                            valueLabelVisibility: false,
                            starCount: 5,
                            starSpacing: 2,
                            starSize: 20,
                            starColor: Color(0xffFFD633),
                            starOffColor: Color(0xffC1C1C1),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Divider(
                          height: 0.2,
                          thickness: 0.2,
                          color: Color(DIVIDERCOLOR)),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 2,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                WidgetText.widgetPoppinsMediumText(
                                    "Suman Gosain", Color(BLACK), 16),
                                SizedBox(
                                  width: 5,
                                ),
                                RatingStars(
                                  value: 3.5,
                                  onValueChanged: (v) {},
                                  starBuilder: (index, color) => Icon(
                                    Icons.star_rounded,
                                    color: color,
                                  ),
                                  maxValueVisibility: false,
                                  valueLabelVisibility: false,
                                  starCount: 5,
                                  starSpacing: 2,
                                  starSize: 20,
                                  starColor: Color(0xffFFD633),
                                  starOffColor: Color(0xffC1C1C1),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                WidgetText.widgetPoppinsRegularText(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                    Color(SUBTEXT),
                                    14),
                                SizedBox(
                                  height: 5,
                                ),
                                WidgetText.widgetPoppinsRegularText(
                                    "14th Feb, 2022",
                                    Color(LIGHTTEXTCOLOR),
                                    12),
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
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: WidgetText.widgetPoppinsRegularText(
                          "View all", Color(ORANGE), 16,
                          decoration: TextDecoration.underline),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ],
            ),
          ),
          _addItemInCart == 0
              ? Container()
              : Positioned(
                  bottom: 15,
                  left: 20,
                  right: 20,
                  child: Container(
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
                      onPressed: onClickViewCart,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            ic_cart,
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          WidgetText.widgetRobotoMediumText(
                            "View Order (${_addItemInCart})",
                            Colors.white,
                            16,
                            align: TextAlign.end,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  onClickViewGroupOrder() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ViewGroupOrderDialogScreen()));
  }

  onClickViewCart() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => CartScreen()));
  }

  onClickItemAddOrder() async {
    var result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            FoodItemAddScreen(isGroupOrder: FoodDetailScreen._isGroupOrder)));
    if (result) {
      setState(() {
        _addItemInCart = _addItemInCart + 1;
      });
    }
  }

  onClickGroupOrder() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => CreateGroupScreen()));
  }
}

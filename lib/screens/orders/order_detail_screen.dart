import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class OrderDetailsScreen extends StatefulWidget {
  int orderStatus = 0; //0->Upcoming, 1->Completed, 2->Canceled

  OrderDetailsScreen({Key? key, required this.orderStatus}) : super(key: key);

  @override
  _OrderDetailsScreenState createState() =>
      _OrderDetailsScreenState(orderStatus);
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int orderStatus = 0;

  _OrderDetailsScreenState(int orderStatus) {
    this.orderStatus = orderStatus;
  }

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
                orderStatus == 0 ? "Upcoming order" : "Details",
                Color(BLACK),
                18,
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(15),
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(WHITE),
                shape: BoxShape.rectangle,
                border: Border.all(color: Color(ORANGE), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    temp_img_food1,
                    width: 80,
                    height: 70,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    width: 15,
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
                        WidgetText.widgetPoppinsMediumText(
                          orderStatus == 0
                              ? "Confirmed"
                              : orderStatus == 1
                                  ? "Completed"
                                  : "Canceled",
                          Color(ORANGE),
                          14,
                        )
                      ],
                    ),
                  ),
                ],
              ),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              WidgetText.widgetPoppinsRegularText(
                                "Order ID",
                                Color(SUBTEXT),
                                14,
                              ),
                              WidgetText.widgetPoppinsMediumText(
                                "CF1645",
                                Color(BLACK),
                                14,
                              ),
                            ],
                          ),
                        ),
                        flex: 1,
                        fit: FlexFit.tight,
                      ),
                      orderStatus == 2
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                WidgetText.widgetPoppinsRegularText(
                                  "Receipt",
                                  Color(SUBTEXT),
                                  14,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                    color: Color(ORANGE),
                                    shape: BoxShape.rectangle,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  alignment: Alignment.center,
                                  child: WidgetText.widgetPoppinsMediumText(
                                    "View",
                                    Color(WHITE),
                                    13,
                                  ),
                                )
                              ],
                            ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WidgetText.widgetPoppinsRegularText(
                        "Order Placed on date",
                        Color(SUBTEXT),
                        14,
                      ),
                      WidgetText.widgetPoppinsMediumText(
                        "15-2-22",
                        Color(BLACK),
                        14,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WidgetText.widgetPoppinsRegularText(
                        orderStatus == 0
                            ? "Upcoming order"
                            : orderStatus == 1
                                ? "Delivered on date"
                                : "Order Canceled on date",
                        Color(SUBTEXT),
                        14,
                      ),
                      WidgetText.widgetPoppinsMediumText(
                        "17-2-22",
                        Color(BLACK),
                        14,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WidgetText.widgetPoppinsRegularText(
                        "Items",
                        Color(SUBTEXT),
                        14,
                      ),
                      WidgetText.widgetPoppinsMediumText(
                        "1 x Veg cheese sandwich",
                        Color(BLACK),
                        14,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
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
                            14,
                          ),
                        ),
                      ),
                      WidgetText.widgetPoppinsMediumText(
                        "\$230",
                        Color(ORANGE),
                        14,
                      )
                    ],
                  ),
                ],
              ),
            ),
            orderStatus == 1
                ? Container(
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
                          "Delivery details",
                          Color(BLACK),
                          18,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        WidgetText.widgetPoppinsMediumText(
                          "Suman Gosain",
                          Color(BLACK),
                          14,
                        ),
                        WidgetText.widgetPoppinsRegularText(
                          "House No. - 354, Kalkaji Ext. New Delhi - 110019",
                          Color(SUBTEXT),
                          14,
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
                      ],
                    ),
                  )
                : Container(),
            orderStatus == 1
                ? SizedBox(
                    height: 15,
                  )
                : Container(),
            orderStatus == 1
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            rateUsDialog(context);
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
                              "Rate Us",
                              Color(WHITE),
                              14,
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
                            border: Border.all(color: Color(ORANGE), width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          alignment: Alignment.center,
                          child: WidgetText.widgetPoppinsMediumText(
                            "Reorder",
                            Color(ORANGE),
                            14,
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  void rateUsDialog(BuildContext mContext) {
    showDialog(
        context: mContext,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            //this right here
            child: Container(
              height: 400,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Card(
                        elevation: 5,
                        color: Color(WHITE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Image.asset(
                            ic_cross,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: WidgetText.widgetPoppinsMediumText(
                      "Rating & Review",
                      Color(BLACK),
                      18,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: RatingStars(
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
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  WidgetText.widgetPoppinsRegularText(
                    "Your feedback",
                    Color(BLACK),
                    14,
                  ),
                  Card(
                    elevation: 5,
                    color: Color(WHITE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        minLines: 3,
                        maxLines: 3,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Color(0xff8C8989),
                            fontSize: 16,
                            fontFamily: FontPoppins,
                            fontWeight: PoppinsRegular,
                          ),
                          hintText: "",
                        ),
                        style: TextStyle(
                          color: Color(0xff3E4958),
                          fontSize: 16,
                          fontFamily: FontPoppins,
                          fontWeight: PoppinsRegular,
                        ),
                      ),
                    ),
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

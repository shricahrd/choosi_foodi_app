import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/food_detail/food_detail_screen.dart';
import 'package:choosifoodi/screens/order_checkout/payment_screen.dart';
import 'package:flutter/material.dart';

class ViewGroupOrderDialogScreen extends StatefulWidget {
  @override
  _ViewGroupOrderDialogScreenState createState() =>
      _ViewGroupOrderDialogScreenState();
}

class _ViewGroupOrderDialogScreenState
    extends State<ViewGroupOrderDialogScreen> {
  bool macroCal = true;

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
                  "Group order",
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
          child: Card(
            margin: EdgeInsets.all(20),
            color: Color(WHITE),
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          WidgetText.widgetPoppinsMediumText(
                            "Your Group Order",
                            Color(BLACK),
                            22,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              WidgetText.widgetPoppinsMediumText(
                                "Order from :",
                                Color(BLACK),
                                16,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.loose,
                                child: WidgetText.widgetPoppinsBoldText(
                                  "Vegan Vinnies",
                                  Color(BLACK),
                                  16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 200,
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Color(ORANGE),
                                ),
                                minimumSize: MaterialStateProperty.all<Size>(
                                  Size(double.maxFinite, 50.0),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    ic_plus,
                                    height: 18,
                                    width: 18,
                                    color: Color(WHITE),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  WidgetText.widgetPoppinsMediumText(
                                    "INVITEES",
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
                          WidgetText.widgetPoppinsRegularText(
                            "You can still invite people to your order!",
                            Color(BLACK),
                            14,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Flexible(
                              fit: FlexFit.tight,
                              flex: 1,
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: 2,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(WHITE),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                              color: Color(ORANGE), width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        child: Column(
                                          children: [
                                            WidgetText.widgetPoppinsRegularText(
                                              "Brittany(You)",
                                              Color(BLACK),
                                              20,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  15, 0, 0, 0),
                                              child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: 3,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 15, 0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              WidgetText
                                                                  .widgetPoppinsRegularText(
                                                                "1.",
                                                                Color(BLACK),
                                                                16,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Expanded(
                                                                child: WidgetText
                                                                    .widgetPoppinsRegularText(
                                                                  "Food Item Title",
                                                                  Color(BLACK),
                                                                  16,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              WidgetText
                                                                  .widgetPoppinsRegularText(
                                                                "+0.99",
                                                                Color(BLACK),
                                                                16,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })

                              /*   child: ListView(
                                physics: BouncingScrollPhysics(),
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(WHITE),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          color: Color(ORANGE), width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child: Column(
                                      children: [
                                        WidgetText.widgetPoppinsRegularText(
                                          "Brittany(You)",
                                          Color(BLACK),
                                          20,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(15, 0, 0, 0),
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: 3,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 15, 0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          WidgetText
                                                              .widgetPoppinsRegularText(
                                                            "1.",
                                                            Color(BLACK),
                                                            16,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Expanded(
                                                            child: WidgetText
                                                                .widgetPoppinsRegularText(
                                                              "Food Item Title",
                                                              Color(BLACK),
                                                              16,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          WidgetText
                                                              .widgetPoppinsRegularText(
                                                            "+0.99",
                                                            Color(BLACK),
                                                            16,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                              */

                              ),
                        ],
                      ),
                    ),
                  ),
                  flex: 1,
                  fit: FlexFit.loose,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 5, 15),
                        child: WidgetButton.widgetDefaultButton(
                            "Checkout", onClickCheckOut),
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      fit: FlexFit.tight,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(5, 0, 15, 15),
                        child: WidgetButton.widgetDefaultButton(
                            "Cancel Group Order", onClickCancelGroupOrder,
                            bgColor: RED),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  onClickCancelGroupOrder() {
    showCancelGroupOrderDialog(context);
  }

  void showCancelGroupOrderDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            //this right here
            child: Container(
                height: 230,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
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
                    WidgetText.widgetPoppinsRegularText(
                      "Cancel Group Order?",
                      Color(BLACK),
                      18,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop(context);
                      },
                      child: WidgetText.widgetPoppinsRegularText(
                        "Keep Order",
                        Color(BLACK),
                        16,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop(context);
                        FoodDetailScreen.setIsGroupOrder(false);
                        Navigator.of(context).pop(context);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                FoodDetailScreen()));
                      },
                      child: WidgetText.widgetPoppinsRegularText(
                        "Cancel Order",
                        Color(RED),
                        16,
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  // void showCancelGroupOrderDialog(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return CustomDialogBox();
  //       });
  // }

  onClickCheckOut() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => PaymentScreen()));
  }
}

class CustomDialogBox extends StatefulWidget {
  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            WidgetText.widgetPoppinsRegularText(
              "Cancel Group Order?",
              Color(BLACK),
              22,
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop(context);
              },
              child: WidgetText.widgetPoppinsRegularText(
                "Keep Order",
                Color(BLACK),
                18,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop(context);
                FoodDetailScreen.setIsGroupOrder(false);
                Navigator.of(context).pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => FoodDetailScreen()));
              },
              child: WidgetText.widgetPoppinsRegularText(
                "Cancel Order",
                Color(RED),
                18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

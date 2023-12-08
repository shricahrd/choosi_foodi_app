import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class FoodLogHistoryScreen extends StatefulWidget {
  @override
  _FoodLogHistoryScreenState createState() => _FoodLogHistoryScreenState();
}

class _FoodLogHistoryScreenState extends State<FoodLogHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(GREY),
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
                "History",
                Color(BLACK),
                18,
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 70,
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              alignment: Alignment.centerLeft,
              child: WidgetText.widgetRobotoRegularText(
                "08/20/2022",
                Color(ORANGE),
                16,
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      WidgetText.widgetPoppinsRegularText(
                                        "Mean Green Lean",
                                        Color(BLACK),
                                        16,
                                      ),
                                      WidgetText.widgetPoppinsRegularText(
                                        "1 Serving",
                                        Color(SUBTEXT),
                                        16,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                InkWell(
                                  onTap: () {
                                    showEditServeDialog(context);
                                  },
                                  child: Image.asset(
                                    ic_edit_2,
                                    width: 20,
                                    height: 20,
                                    color: Color(ORANGE),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Image.asset(
                                    ic_delete,
                                    width: 20,
                                    height: 20,
                                    color: Color(RED),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showEditServeDialog(BuildContext mContext) {
    showDialog(
        context: mContext,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: 200,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: WidgetText.widgetPoppinsMediumText(
                      "Mean Green Lean",
                      Color(BLACK),
                      18,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    elevation: 5,
                    color: Color(WHITE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: TextFormField(
                        initialValue: "1",
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Color(0xff8C8989),
                            fontSize: 16,
                            fontFamily: FontPoppins,
                            fontWeight: PoppinsRegular,
                          ),
                          hintText: "Enter your servings",
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
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: WidgetButton.widgetDefaultButton("Cancel", () {
                        Navigator.pop(context);
                      })),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: WidgetButton.widgetDefaultButton("Submit", () {
                        Navigator.pop(context);
                      })),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

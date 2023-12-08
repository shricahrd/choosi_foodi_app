import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class GroupOrderHomeScrollScreen extends StatefulWidget {
  @override
  _GroupOrderHomeScrollScreenState createState() =>
      _GroupOrderHomeScrollScreenState();
}

class _GroupOrderHomeScrollScreenState
    extends State<GroupOrderHomeScrollScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Color(WHITE),
              ),
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    ic_right_side_arrow,
                    width: 18,
                    height: 18,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  WidgetText.widgetRobotoRegularText(
                    "Back",
                    Color(BLACK),
                    14,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(WHITE),
                ),
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            ic_plus,
                            width: 20,
                            height: 20,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          WidgetText.widgetRobotoRegularText(
                            "Add Group Order",
                            Color(ORANGE),
                            20,
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        WidgetText.widgetRobotoRegularText(
                                          "1",
                                          Color(BLACK),
                                          14,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        WidgetText.widgetRobotoRegularText(
                                          "Food Item Title",
                                          Color(BLACK),
                                          14,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: WidgetText.widgetRobotoRegularText(
                                              "Edit",
                                              Color(BLUE),
                                              14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: Color(DIVIDERCOLOR)),
                                ],
                              );
                            })),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(WHITE),
              ),
              padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
              child: WidgetButton.widgetDefaultButton("Checkout", onClickNext),
            ),
          ],
        ),
      ),
    );
  }

  onClickNext() {
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (BuildContext context) => JoinGroupOrderScreen()));
  }
}

import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class FoodiGoalResultScreen extends StatefulWidget {
  @override
  _FoodiGoalResultScreenState createState() => _FoodiGoalResultScreenState();
}

class _FoodiGoalResultScreenState extends State<FoodiGoalResultScreen> {
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
                "FoodiGoal",
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
            Expanded(
              child: Container(
                margin: EdgeInsets.all(15),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 255,
                      mainAxisSpacing: 10),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(ORANGE),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.asset(
                            app_icon,
                            height: 70,
                            width: 70,
                            color: Color(WHITE),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          WidgetText.widgetPoppinsMediumText(
                              index == 0
                                  ? "Calories"
                                  : index == 1
                                      ? "Fat"
                                      : index == 2
                                          ? "Carbs"
                                          : "Protein",
                              Color(WHITE),
                              16),
                          SizedBox(
                            height: 5,
                          ),
                          WidgetText.widgetPoppinsRegularText(

                              index == 0
                                  ? ""
                                  : index == 1
                                  ? "Included Saturated fat"
                                  : index == 2
                                  ? "Includes Sugar"
                                  : "",

                               Color(WHITE), 12),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(WHITE),
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: WidgetText.widgetPoppinsRegularText(
                                "1083/day", Color(ORANGE), 16),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(WHITE),
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: WidgetText.widgetPoppinsRegularText(
                                "100/meal", Color(ORANGE), 16),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onClickPassword() {}
}

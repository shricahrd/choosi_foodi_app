import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrackOrderScreen extends StatefulWidget {
  @override
  _TrackOrderScreenState createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  List<Step> steps = [
    Step(
      title: WidgetText.widgetPoppinsRegularText(
        "Order reveived",
        Color(SUBTEXT),
        16,
      ),
      content: Text(''),
      isActive: true,
      state: StepState.complete,
    ),
    Step(
      title: WidgetText.widgetPoppinsRegularText(
        'Being prepared',
        Color(SUBTEXT),
        16,
      ),
      content: Text(''),
      isActive: true,
      state: StepState.complete,
    ),
    Step(
      title: WidgetText.widgetPoppinsRegularText(
        'Out for delivery',
        Color(SUBTEXT),
        16,
      ),
      content: Text(''),
      isActive: false,
      state: StepState.indexed,
    ),
    Step(
      title: WidgetText.widgetPoppinsRegularText(
        'Delivered',
        Color(SUBTEXT),
        16,
      ),
      content: Text(''),
      isActive: false,
      state: StepState.indexed,
    ),
  ];
  
  int current_step = 3;

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
                "Track Orders",
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
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(WHITE),
                shape: BoxShape.rectangle,
                border: Border.all(color: Color(ORANGE), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          WidgetText.widgetPoppinsRegularText(
                            "Date: ",
                            Color(SUBTEXT),
                            12,
                          ),
                          WidgetText.widgetPoppinsMediumText(
                            "24, Feb 2022",
                            Color(BLACK),
                            12,
                          ),
                          Expanded(child: Container()),
                          DotsIndicator(
                            dotsCount: 1,
                            position: 0,
                            decorator: DotsDecorator(
                              color: Colors.black87, // Inactive color
                              activeColor: Color(ORANGE),
                            ),
                          ),
                          WidgetText.widgetPoppinsMediumText(
                            "Order received",
                            Color(ORANGE),
                            12,
                          ),
                        ],
                      ),
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
                            SizedBox(
                              height: 5,
                            ),
                            WidgetText.widgetPoppinsRegularText(
                              "Total : \$230",
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
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Theme(
                      data: ThemeData(
                        primarySwatch: Colors.orange,
                        primaryTextTheme: TextTheme(
                          caption: TextStyle(
                            color: Color(SUBTEXT),
                            fontSize: 16,
                            fontFamily: FontPoppins,
                            fontWeight: PoppinsRegular,
                          ),
                        ),
                        colorScheme: ColorScheme.light(primary: Colors.orange),
                      ),
                      child: Stepper(
                        controlsBuilder: (context, _) {
                          return Container();
                        },
                        currentStep: this.current_step,
                        steps: steps,
                        type: StepperType.vertical,
                        onStepTapped: (step) {
                          setState(() {
                            //  current_step = step;
                          });
                        },
                        onStepContinue: () {
                          setState(() {
                            if (current_step < steps.length - 1) {
                              current_step = current_step + 1;
                            } else {
                              current_step = 0;
                            }
                          });
                        },
                        onStepCancel: () {
                          setState(() {
                            if (current_step > 0) {
                              current_step = current_step - 1;
                            } else {
                              current_step = 0;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

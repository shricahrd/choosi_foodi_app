import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_radio_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/foodi_goal/foodi_goal_result.dart';
import 'package:choosifoodi/screens/location_details/location_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class FoodiGoalAddEditScreen extends StatefulWidget {
  final bool isEditFoodiGoal;
  final bool isFromSignup;
  final bool isFromHome;

  const FoodiGoalAddEditScreen(
      {Key? key,
      required this.isEditFoodiGoal,
      required this.isFromSignup,
      required this.isFromHome})
      : super(key: key);

  @override
  _FoodiGoalAddEditScreenState createState() =>
      _FoodiGoalAddEditScreenState(isEditFoodiGoal, isFromSignup, isFromHome);
}

class _FoodiGoalAddEditScreenState extends State<FoodiGoalAddEditScreen> {
  int _genderValue = 0;
  int _goalValue = 0;
  int _activityValue = 0;
  bool isEditFoodiGoal = false;
  bool isFromHome = false;
  bool isFromSignup = false;
  bool foodiGoal = true;

  _FoodiGoalAddEditScreenState(
      bool isEditFoodiGoal, bool isFromSignup, bool isFromHome) {
    this.isEditFoodiGoal = isEditFoodiGoal;
    this.isFromSignup = isFromSignup;
    this.isFromHome = isFromHome;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              isFromHome
                  ? Container(
                      height: 20,
                    )
                  : InkWell(
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
                decoration: BoxDecoration(
                  color: Color(WHITE),
                ),
                padding: EdgeInsets.all(15),
                width: double.infinity,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isEditFoodiGoal
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      WidgetText.widgetRobotoRegularText(
                                        "FoodiGoal",
                                        Color(BLACK),
                                        16,
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      WidgetText.widgetRobotoRegularText(
                                        "You can turn your macro calculator on/off depending on your foodi intention.",
                                        Color(LIGHTERHINTCOLOR),
                                        12,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      WidgetText.widgetRobotoRegularText(
                                        "Edit Goal",
                                        Color(BLUE),
                                        14,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                                  alignment: Alignment.topRight,
                                  child: FlutterSwitch(
                                    width: 50.0,
                                    height: 30.0,
                                    padding: 2.0,
                                    toggleSize: 25,
                                    activeColor: Color(ORANGE),
                                    value: foodiGoal,
                                    onToggle: (value) {
                                      setState(() {
                                        foodiGoal = !foodiGoal;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: isEditFoodiGoal ? 20 : 0,
                      ),
                      WidgetText.widgetPoppinsRegularText(
                        "Gender",
                        Color(BLACK),
                        16,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () => updateGender(1),
                              child: _genderValue == 1
                                  ? WidgetRadioButton.selectedRadioButton(
                                      "Female")
                                  : WidgetRadioButton.unselectedRadioButton(
                                      "Female"),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => updateGender(0),
                              child: _genderValue == 0
                                  ? WidgetRadioButton.selectedRadioButton(
                                      "Male")
                                  : WidgetRadioButton.unselectedRadioButton(
                                      "Male"),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => updateGender(2),
                              child: _genderValue == 2
                                  ? WidgetRadioButton.selectedRadioButton("N/A")
                                  : WidgetRadioButton.unselectedRadioButton(
                                      "N/A"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      WidgetText.widgetPoppinsRegularText(
                        "What's your goal?",
                        Color(BLACK),
                        16,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () => updateGoal(0),
                              child: _goalValue == 0
                                  ? WidgetRadioButton.selectedRadioButton(
                                      "Lose Weight")
                                  : WidgetRadioButton.unselectedRadioButton(
                                      "Lose Weight"),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => updateGoal(1),
                              child: _goalValue == 1
                                  ? WidgetRadioButton.selectedRadioButton(
                                      "Maintain Weight")
                                  : WidgetRadioButton.unselectedRadioButton(
                                      "Maintain Weight"),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => updateGoal(2),
                              child: _goalValue == 2
                                  ? WidgetRadioButton.selectedRadioButton(
                                      "Gain Weight")
                                  : WidgetRadioButton.unselectedRadioButton(
                                      "Gain Weight"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      WidgetText.widgetPoppinsRegularText(
                        "Activity Level",
                        Color(BLACK),
                        16,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () => updateActivity(0),
                              child: _activityValue == 0
                                  ? WidgetRadioButton.selectedRadioButton(
                                      "Light")
                                  : WidgetRadioButton.unselectedRadioButton(
                                      "Light"),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => updateActivity(1),
                              child: _activityValue == 1
                                  ? WidgetRadioButton.selectedRadioButton(
                                      "Moderate")
                                  : WidgetRadioButton.unselectedRadioButton(
                                      "Moderate"),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => updateActivity(2),
                              child: _activityValue == 2
                                  ? WidgetRadioButton.selectedRadioButton(
                                      "Active")
                                  : WidgetRadioButton.unselectedRadioButton(
                                      "Active"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Flexible(
                            child: GestureDetector(
                              onTap: () => updateActivity(3),
                              child: _activityValue == 3
                                  ? WidgetRadioButton.selectedRadioButton(
                                      "Very Active")
                                  : WidgetRadioButton.unselectedRadioButton(
                                      "Very Active"),
                            ),
                            flex: 3,
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: GestureDetector(
                              onTap: () => updateActivity(4),
                              child: _activityValue == 4
                                  ? WidgetRadioButton.selectedRadioButton(
                                      "Extremely Active")
                                  : WidgetRadioButton.unselectedRadioButton(
                                      "Extremely Active"),
                            ),
                            flex: 4,
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: GestureDetector(
                              onTap: () => {},
                              child: Container(),
                            ),
                            flex: 2,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      WidgetText.widgetPoppinsRegularText(
                        "How many meals do you eat in a day?",
                        Color(BLACK),
                        16,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      WidgetText.widgetPoppinsRegularText(
                        "10",
                        Color(DARKGREY),
                        16,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                          height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                      SizedBox(
                        height: 10,
                      ),
                      WidgetText.widgetPoppinsRegularText(
                        "Age",
                        Color(BLACK),
                        16,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      WidgetText.widgetPoppinsRegularText(
                        "30",
                        Color(DARKGREY),
                        16,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                          height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                      SizedBox(
                        height: 10,
                      ),
                      WidgetText.widgetPoppinsRegularText(
                        "Height",
                        Color(BLACK),
                        16,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      WidgetText.widgetPoppinsRegularText(
                        "5,5",
                        Color(DARKGREY),
                        16,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                          height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                      SizedBox(
                        height: 10,
                      ),
                      WidgetText.widgetPoppinsRegularText(
                        "Weight",
                        Color(BLACK),
                        16,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      WidgetText.widgetPoppinsRegularText(
                        "165",
                        Color(DARKGREY),
                        16,
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Divider(
                          height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(WHITE),
              ),
              padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
              child: WidgetButton.widgetDefaultButton(
                  isEditFoodiGoal ? "Save" : "Calculate Foodi Goal",
                  onClickCalculateFoodiGoal),
            ),
          ],
        ),
      ),
    );
  }

  onClickCalculateFoodiGoal() {
    if (isFromSignup) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => LocationDetailsScreen(
                isUpdateLocation: false,
              )));
    } else if (isFromHome) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => FoodiGoalResultScreen()));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => FoodiGoalResultScreen()));
    }
  }

  updateGender(int value) {
    setState(() {
      _genderValue = value;
    });
  }

  updateGoal(int value) {
    setState(() {
      _goalValue = value;
    });
  }

  updateActivity(int value) {
    setState(() {
      _activityValue = value;
    });
  }

  onClickPassword() {}
}

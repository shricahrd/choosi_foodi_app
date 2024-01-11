import 'dart:convert';
import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_radio_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import '../../../core/http_utils/http_constants.dart';
import '../../../core/utils/app_font_utils.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../routes/all_routes.dart';
import '../../base_application/base_application.dart';
import '../../base_application/base_controller.dart';
import '../controller/foodi_goal_view_controller.dart';
import 'foodi_goal_result.dart';

class FoodiGoalAddEditScreen extends StatefulWidget {
  final bool isEditFoodiGoal;
  final bool isFromHome;

  const FoodiGoalAddEditScreen(
      {Key? key,
      required this.isEditFoodiGoal,
      required this.isFromHome})
      : super(key: key);

  @override
  _FoodiGoalAddEditScreenState createState() =>
      _FoodiGoalAddEditScreenState(isEditFoodiGoal,isFromHome);
}

class _FoodiGoalAddEditScreenState extends State<FoodiGoalAddEditScreen> {
  // FoodieViewController
  final FoodieViewController foodieViewController =
      Get.put(FoodieViewController());
  final tabBarItemControllerController = Get.find<TabBarItemController>();
  int _genderValue = 0;
  int _goalValue = 0;
  int _activityValue = 0;
  bool isEditFoodiGoal = false;
  bool isFromHome = false;
  bool isFromSignup = false;
  bool foodiGoal = true;
  String selGenderName = male;
  String selGoalValue = loseWeight;
  String selActivityLevel = light;
  bool isAllFilled = false;

  _FoodiGoalAddEditScreenState(
      bool isEditFoodiGoal, bool isFromHome) {
    this.isEditFoodiGoal = isEditFoodiGoal;
    this.isFromHome = isFromHome;
  }

  TextEditingController mealCtr = TextEditingController();
  TextEditingController ageCtr = TextEditingController();
  TextEditingController heightCtr = TextEditingController();
  TextEditingController weightCtr = TextEditingController();

  @override
  void initState() {
    foodieViewController.isLoaderVisible = false;
    foodieViewController.isFoodGoalUpdate = false;
    super.initState();
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
              isFromHome || isFromSignup
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
                foodiGoalTitle,
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
                                        foodiGoalTitle,
                                        Color(BLACK),
                                        16,
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      WidgetText.widgetRobotoRegularText(
                                        turnOnFoodiCal,
                                        Color(LIGHTERHINTCOLOR),
                                        12,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      WidgetText.widgetRobotoRegularText(
                                        editGoal,
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
                        sex,
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
                              onTap: () {
                                setState(() {
                                  updateGender(1);
                                  selGenderName = female;
                                  debugPrint('Selected Gender: $selGenderName');
                                });
                              },
                              child: _genderValue == 1
                                  ? WidgetRadioButton.selectedRadioButton(
                                      female)
                                  : WidgetRadioButton.unselectedRadioButton(
                                      female),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  updateGender(0);
                                  selGenderName = male;
                                  debugPrint('Selected Gender: $selGenderName');
                                });
                              },
                              child: _genderValue == 0
                                  ? WidgetRadioButton.selectedRadioButton(male)
                                  : WidgetRadioButton.unselectedRadioButton(
                                      male),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  updateGender(2);
                                  selGenderName = notAccepted;
                                  debugPrint('Selected Gender: $selGenderName');
                                });
                              },
                              child: _genderValue == 2
                                  ? WidgetRadioButton.selectedRadioButton(
                                      notAccepted)
                                  : WidgetRadioButton.unselectedRadioButton(
                                      notAccepted),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      WidgetText.widgetPoppinsRegularText(
                        whatGoal,
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
                              onTap: () {
                                setState(() {
                                  updateGoal(0);
                                  selGoalValue = loseWeight;
                                  debugPrint('Selected Goal: $selGoalValue');
                                });
                              },
                              child: _goalValue == 0
                                  ? WidgetRadioButton.selectedRadioButton(
                                      loseWeight)
                                  : WidgetRadioButton.unselectedRadioButton(
                                      loseWeight),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  updateGoal(1);
                                  selGoalValue = maintainWeight;
                                  debugPrint('Selected Goal: $selGoalValue');
                                });
                              },
                              child: _goalValue == 1
                                  ? WidgetRadioButton.selectedRadioButton(
                                      maintainWeight)
                                  : WidgetRadioButton.unselectedRadioButton(
                                      maintainWeight),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  updateGoal(2);
                                  selGoalValue = gainWeight;
                                  debugPrint('Selected Goal: $selGoalValue');
                                });
                              },
                              child: _goalValue == 2
                                  ? WidgetRadioButton.selectedRadioButton(
                                      gainWeight)
                                  : WidgetRadioButton.unselectedRadioButton(
                                      gainWeight),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      WidgetText.widgetPoppinsRegularText(
                        activityLevel,
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
                              onTap: () {
                                setState(() {
                                  updateActivity(0);
                                  selActivityLevel = light;
                                  debugPrint('Selected Level: $selActivityLevel');
                                });
                              },
                              child: _activityValue == 0
                                  ? WidgetRadioButton.selectedRadioButton(light)
                                  : WidgetRadioButton.unselectedRadioButton(
                                      light),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  updateActivity(1);
                                  selActivityLevel = moderate;
                                  debugPrint('Selected Level: $selActivityLevel');
                                });
                              },
                              child: _activityValue == 1
                                  ? WidgetRadioButton.selectedRadioButton(
                                      moderate)
                                  : WidgetRadioButton.unselectedRadioButton(
                                      moderate),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  updateActivity(2);
                                  selActivityLevel = activeVal;
                                  debugPrint('Selected Level: $selActivityLevel');
                                });
                              },
                              child: _activityValue == 2
                                  ? WidgetRadioButton.selectedRadioButton(
                                      activeVal)
                                  : WidgetRadioButton.unselectedRadioButton(
                                      activeVal),
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
                              onTap: () {
                                setState(() {
                                  updateActivity(3);
                                  selActivityLevel = veryActive;
                                  debugPrint('Selected Level: $selActivityLevel');
                                });
                              },
                              child: _activityValue == 3
                                  ? WidgetRadioButton.selectedRadioButton(
                                      veryActive)
                                  : WidgetRadioButton.unselectedRadioButton(
                                      veryActive),
                            ),
                            flex: 3,
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  updateActivity(4);
                                  selActivityLevel = extreamLevel;
                                  debugPrint('Selected Level: $selActivityLevel');
                                });
                              },
                              child: _activityValue == 4
                                  ? WidgetRadioButton.selectedRadioButton(
                                      extreamLevel)
                                  : WidgetRadioButton.unselectedRadioButton(
                                      extreamLevel),
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
                      customTextInputField(
                        mealCtr,
                        enterMeals,
                        mealInDay,
                        TextInputType.number,
                        TextInputAction.next,
                      ),
                      Divider(
                          height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                      SizedBox(
                        height: 10,
                      ),
                      customTextInputField(
                        ageCtr,
                        "Enter Age",
                        age,
                        TextInputType.number,
                        TextInputAction.next,
                      ),
                      Divider(
                          height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                      SizedBox(
                        height: 10,
                      ),
                      customTextInputField(
                        heightCtr,
                        "Enter Height in Inches",
                        height,
                        TextInputType.number,
                        TextInputAction.next,
                      ),
                      Divider(
                          height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                      SizedBox(
                        height: 10,
                      ),
                      customTextInputField(
                        weightCtr,
                        "Enter Weight",
                        weight,
                        TextInputType.number,
                        TextInputAction.done,
                      ),
                      Divider(
                          height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                    ],
                  ),
                ),
              ),
            ),
            GetBuilder<FoodieViewController>(builder: (logic) {
            return !logic.isFoodGoalUpdate
                  ? Container(
                      decoration: BoxDecoration(
                        color: Color(WHITE),
                      ),
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 30),
                      child: WidgetButton.widgetDefaultButton(
                          isEditFoodiGoal ? save :isAllFilled == false ? calGoal : next, () async {
                        FocusScope.of(context).unfocus();
                        var value1 = double.parse(mealCtr.text);
                        var value2 = double.parse(ageCtr.text);
                        var value3 = double.parse(heightCtr.text);
                        var value4 = double.parse(weightCtr.text);

                      if(value1 >0 && value2 >0 && value3 >0 && value4 >0){
                          if (mealCtr.text.length <= 2) {
                            if (ageCtr.text.length <= 3) {
                            if (heightCtr.text.length <= 4) {
                            if (weightCtr.text.length <= 4) {
                              final params = jsonEncode({
                                HttpConstants.PARAMS_REST_GENDER: selGenderName.toUpperCase(),
                                HttpConstants.PARAMS_REST_USERGOAL: selGoalValue.toUpperCase(),
                                HttpConstants.PARAMS_REST_ACTIVITY_LEVEL: selActivityLevel.toUpperCase(),
                                HttpConstants.PARAMS_REST_AGE: ageCtr.text,
                                HttpConstants.PARAMS_REST_HEIGHT: heightCtr.text,
                                HttpConstants.PARAMS_REST_WEIGHT: weightCtr.text,
                                HttpConstants.PARAMS_REST_MEALS: mealCtr.text,
                              });
                              await logic.callFoodGoalUpdateAPI(params: params);
                              if(logic.deleteCartModel.meta?.status == true){
                                setState(() {
                                  logic.isFoodGoalUpdate = false;
                                });

                                // Get.offAllNamed(AllRoutes.baseUser);
                                if(isFromHome == true) {
                                  setState(() {
                                    tabBarItemControllerController.changeTabIndex(true);
                                  });
                                  // Get.to(() => FoodiGoalResultScreen(isFromHome: false,isEdit: false));
                                }else{
                                  Get.back(result: true);
                                }
                              }
                            } else {
                              showToastMessage('Weight is Too much');
                            }
                            } else {
                              showToastMessage('Height is Too much');
                            }
                          } else {
                              showToastMessage('Age is Too much');
                          }
                        } else {
                          showToastMessage('Meals is Too much');
                        }
                      }
                        else {
                        showToastMessage('Negative values not allowed');
                        }
                      }),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: Color(ORANGE),
                      ),
                    );
            })
          ],
        ),
      ),
    );
  }

  Widget customTextInputField(
      TextEditingController editingController,
      String hintText,
      String lableText,
      TextInputType? keyboardType,
      TextInputAction? textInputAction,
      [bool isPassword = false]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 2),
          child: WidgetText.widgetPoppinsRegularText(
            lableText,
            Color(BLACK),
            16,
            align: TextAlign.end,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
          decoration: BoxDecoration(
            color: Color(WHITE),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
          child: TextFormField(
            obscureText: isPassword,
            controller: editingController,
            textAlign: TextAlign.start,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9\.]")),],
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Color(HINTCOLOR),
                fontSize: 16,
                fontFamily: FontRoboto,
                fontWeight: RobotoRegular,
              ),
              hintText: hintText,
            ),
            onChanged: (val){
              if(mealCtr.text.isNotEmpty && ageCtr.text.isNotEmpty && heightCtr.text.isNotEmpty && weightCtr.text.isNotEmpty){
                setState(() {
                  isAllFilled = true;
                });
              }
            },
            style: TextStyle(
              color: Color(BLACK),
              fontSize: 16,
              fontFamily: FontRoboto,
              fontWeight: RobotoMedium,
            ),
          ),
        )
      ],
    );
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

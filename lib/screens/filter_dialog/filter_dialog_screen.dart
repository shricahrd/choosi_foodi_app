import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_radio_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../foodi_goal/view/foodi_goal_add_edit.dart';

class FilterDialogScreen extends StatefulWidget {
  var filterValue;

  FilterDialogScreen({this.filterValue,});

  @override
  _FilterDialogScreenState createState() => _FilterDialogScreenState();
}

class _FilterDialogScreenState extends State<FilterDialogScreen> {
  bool macroCal = false;
  // String _dietaryValue = "Vegetarian";
  double _distanceValue = 500.0;
  List filterfoodList = [];
  var distance;
  // List isCheked = [false, false, false, false, false];

  List<Map> availablefoodType = [
    {"name": "Vegetarian", "isChecked": false},
    {"name": "Vegan", "isChecked": false},
    {"name": "Pescatarian", "isChecked": false,},
    {"name": "Keto", "isChecked": false},
    {"name": "Dairy Free", "isChecked": false},
  ];

  @override
  void initState() {
    print('foodType : ${widget.filterValue.toString()}');
   if(widget.filterValue != null){
     filterfoodList = widget.filterValue[0];
     for(int i = 0; i<filterfoodList.length; i++){
       print('foodType List $i: ${filterfoodList[i]}');
     }
     getFoodTypeCheck();
     distance = widget.filterValue[1].toString();
     print('distance: $distance');
     _distanceValue = double.parse(distance);
     print('_distanceValue: $_distanceValue');
   }
    super.initState();
  }

  getFoodTypeCheck() {
    print('getFoodTypeCheck');
    for (int i = 0; i < filterfoodList.length; i++) {
      if (filterfoodList[i] == availablefoodType[i]['name']) {
        availablefoodType[i]["isChecked"] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff10000000),
          ),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Color(WHITE),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Image.asset(
                        ic_sheet_divider,
                        width: 200,
                        height: 5,
                      ),
                    ),
                    Positioned(
                      child: InkWell(
                        onTap: onClickFilterApply,
                        child: Image.asset(
                          ic_close,
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WidgetText.widgetRobotoMediumText(
                            "Filters",
                            Color(ORANGE),
                            20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    WidgetText.widgetPoppinsMediumText(
                                      "Foodi Goal",
                                      Color(BLACK),
                                      16,
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    WidgetText.widgetPoppinsRegularText(
                                      "You can turn your Foodi Goal on/off depending on your food intention.",
                                      Color(LIGHTERHINTCOLOR),
                                      12,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: ()=> Get.to(FoodiGoalAddEditScreen(
                                        isEditFoodiGoal: false, isFromHome: false,)),
                                      child: WidgetText.widgetPoppinsRegularText(
                                        "Edit Goal",
                                        Color(ORANGE),
                                        14,
                                      ),
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
                                  value: macroCal,
                                  onToggle: (value) {
                                    setState(() {
                                      macroCal = !macroCal;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          WidgetText.widgetPoppinsMediumText(
                            "Dietary Restrictions",
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
                                      availablefoodType[0]['name'] = "Vegetarian";
                                      availablefoodType[0]['isChecked'] = !availablefoodType[0]['isChecked'];
                                    });
                                  },
                                  child:  availablefoodType[0]['isChecked'] == true
                                      ? WidgetRadioButton.selectedRadioButton(
                                          "Vegetarian")
                                      : WidgetRadioButton.unselectedRadioButton(
                                          "Vegetarian"),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      availablefoodType[1]['name'] = "Vegan";
                                      availablefoodType[1]['isChecked'] = !availablefoodType[1]['isChecked'];
                                    });
                                  },
                                  child:  availablefoodType[1]['isChecked'] == true
                                      ? WidgetRadioButton.selectedRadioButton(
                                          "Vegan")
                                      : WidgetRadioButton.unselectedRadioButton(
                                          "Vegan"),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      availablefoodType[2]['name'] = "Pescatarian";
                                      availablefoodType[2]['isChecked'] = !availablefoodType[2]['isChecked'];
                                    });
                                  },
                                  child:  availablefoodType[2]['isChecked'] == true
                                      ? WidgetRadioButton.selectedRadioButton(
                                          "Pescatarian")
                                      : WidgetRadioButton.unselectedRadioButton(
                                          "Pescatarian"),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      availablefoodType[3]['name'] = "Keto";
                                      availablefoodType[3]['isChecked'] = !availablefoodType[3]['isChecked'];
                                    });
                                  },
                                  child: availablefoodType[3]['isChecked'] == true
                                      ? WidgetRadioButton.selectedRadioButton(
                                          "Keto")
                                      : WidgetRadioButton.unselectedRadioButton(
                                          "Keto"),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      availablefoodType[4]['name'] = "Dairy Free";
                                      availablefoodType[4]['isChecked'] = !availablefoodType[4]['isChecked'];
                                    });
                                  },
                                  child: availablefoodType[4]['isChecked'] == true
                                      ? WidgetRadioButton.selectedRadioButton(
                                          "Dairy Free")
                                      : WidgetRadioButton.unselectedRadioButton(
                                          "Dairy Free"),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          WidgetText.widgetPoppinsMediumText(
                            "Distance",
                            Color(BLACK),
                            16,
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          SfSlider(
                            min: 0.0,
                            max: 500.0,
                            interval: 1,
                            activeColor: Color(ORANGE),
                            inactiveColor: Color(GREY),
                            value: _distanceValue,
                            showTicks: false,
                            showLabels: false,
                            enableTooltip: false,
                            minorTicksPerInterval: 1,
                            thumbIcon: new Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            onChanged: (dynamic value) {
                              setState(() {
                                _distanceValue = value;
                                print('_distanceValue: $_distanceValue');
                              });
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: WidgetText.widgetPoppinsRegularText(
                                      "0mi",
                                      Color(BLACK),
                                      16,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: WidgetText.widgetPoppinsRegularText(
                                      // "500mi",
                                      _distanceValue.ceil().toString() +"mi",
                                      Color(BLACK),
                                      16,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: WidgetButton.widgetDefaultButton(
                      "Apply", onClickFilterApply),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  onClickFilterApply() {
    List foodTypeList = [];
    for (int i = 0; i < availablefoodType.length; i++) {
      if (availablefoodType[i]["isChecked"] == true) {
        foodTypeList.add(availablefoodType[i]["name"]);
        print('Dietry List: $foodTypeList');
      }
    }
    Get.back(result: [
      foodTypeList,
      _distanceValue.ceil().toString(),
    ]);
    // Navigator.of(context).pop(true);
  }
}


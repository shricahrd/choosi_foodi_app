import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_radio_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterDialogScreen extends StatefulWidget {
  @override
  _FilterDialogScreenState createState() => _FilterDialogScreenState();
}

class _FilterDialogScreenState extends State<FilterDialogScreen> {
  bool macroCal = true;
  int _dietaryValue = 0;
  double _distanceValue = 10.0;

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
                                      "You can turn your macro calculator on/off depending on your foodi intention.",
                                      Color(LIGHTERHINTCOLOR),
                                      12,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    WidgetText.widgetPoppinsRegularText(
                                      "Edit Goal",
                                      Color(ORANGE),
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
                                      _dietaryValue = 0;
                                    });
                                  },
                                  child: _dietaryValue == 0
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
                                      _dietaryValue = 1;
                                    });
                                  },
                                  child: _dietaryValue == 1
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
                                      _dietaryValue = 2;
                                    });
                                  },
                                  child: _dietaryValue == 2
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
                                      _dietaryValue = 3;
                                    });
                                  },
                                  child: _dietaryValue == 3
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
                                      _dietaryValue = 4;
                                    });
                                  },
                                  child: _dietaryValue == 4
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
                          WidgetText.widgetPoppinsMediumText(
                            "Distance",
                            Color(BLACK),
                            16,
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          SfSlider(
                            min: 5.0,
                            max: 50.0,
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
                                      "5mi",
                                      Color(BLACK),
                                      16,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: WidgetText.widgetPoppinsRegularText(
                                      "50mi",
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
    Navigator.of(context).pop(true);
  }
}

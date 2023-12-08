import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_round_radio_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FoodItemAddScreen extends StatefulWidget {
  final bool isGroupOrder;

  const FoodItemAddScreen({Key? key, required this.isGroupOrder})
      : super(key: key);

  @override
  _FoodItemAddScreenState createState() =>
      _FoodItemAddScreenState(isGroupOrder);
}

class _FoodItemAddScreenState extends State<FoodItemAddScreen> {
  int _proteinValue = 0;
  int _sauceChoices = 0;

  bool isGroupOrder = false;

  _FoodItemAddScreenState(bool isGroupOrder) {
    this.isGroupOrder = isGroupOrder;
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
                  "Food items",
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
        child: Card(
          margin: EdgeInsets.all(20),
          color: Color(WHITE),
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: WidgetText.widgetPoppinsRegularText(
                  "Food Item Title",
                  Color(BLACK),
                  20,
                ),
              ),
              Center(
                child: WidgetText.widgetPoppinsRegularText(
                  "lorem ipsum dolor sit amet",
                  Color(DARKGREY),
                  15,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(WHITE),
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Color(ORANGE), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      child: WidgetText.widgetPoppinsRegularText(
                        "Protein Option",
                        Color(BLACK),
                        20,
                      ),
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    WidgetText.widgetPoppinsRegularText(
                      "Select 1",
                      Color(SUBTEXT),
                      16,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _proteinValue = 0;
                        });
                      },
                      child: _proteinValue == 0
                          ? WidgetRoundRadioButton.selectedRoundRadioButton(
                              "Veggie")
                          : WidgetRoundRadioButton.unselectedRoundRadioButton(
                              "Veggie"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _proteinValue = 1;
                        });
                      },
                      child: _proteinValue == 1
                          ? WidgetRoundRadioButton.selectedRoundRadioButton(
                              "Soy")
                          : WidgetRoundRadioButton.unselectedRoundRadioButton(
                              "Soy"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _proteinValue = 2;
                        });
                      },
                      child: _proteinValue == 2
                          ? WidgetRoundRadioButton.selectedRoundRadioButton(
                              "Lentill")
                          : WidgetRoundRadioButton.unselectedRoundRadioButton(
                              "Lentill"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(WHITE),
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Color(ORANGE), width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      child: WidgetText.widgetPoppinsRegularText(
                        "Sauce Choices",
                        Color(BLACK),
                        20,
                      ),
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    WidgetText.widgetPoppinsRegularText(
                      "Select 1",
                      Color(SUBTEXT),
                      16,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _proteinValue = 0;
                        });
                      },
                      child: _proteinValue == 0
                          ? WidgetRoundRadioButton.selectedRoundRadioButton(
                              "Sauce 1")
                          : WidgetRoundRadioButton.unselectedRoundRadioButton(
                              "Sauce 1"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _proteinValue = 1;
                        });
                      },
                      child: _proteinValue == 1
                          ? WidgetRoundRadioButton.selectedRoundRadioButton(
                              "Sauce 2")
                          : WidgetRoundRadioButton.unselectedRoundRadioButton(
                              "Sauce 2"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _proteinValue = 2;
                        });
                      },
                      child: _proteinValue == 2
                          ? WidgetRoundRadioButton.selectedRoundRadioButton(
                              "Sauce 3")
                          : WidgetRoundRadioButton.unselectedRoundRadioButton(
                              "Sauce 3"),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WidgetText.widgetPoppinsRegularText(
                      "All Special Instructions",
                      Color(BLACK),
                      18,
                    ),
                    WidgetText.widgetPoppinsRegularText(
                      "Add any instructions for your order here...",
                      Color(BLACK),
                      14,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: onClickAddToOrder,
                      child: Container(
                        width: 130,
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        decoration: BoxDecoration(
                          color: Color(ORANGE),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                        alignment: Alignment.center,
                        child: WidgetText.widgetPoppinsMediumText(
                          "Add to order",
                          Color(WHITE),
                          14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onClickAddToOrder() {
    Navigator.of(context).pop(true);
  }
}

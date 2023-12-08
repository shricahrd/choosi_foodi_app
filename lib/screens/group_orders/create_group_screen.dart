import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_check_box.dart';
import 'package:choosifoodi/core/widgets/widget_round_radio_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/group_orders/join_group_order_screen.dart';
import 'package:flutter/material.dart';

class CreateGroupScreen extends StatefulWidget {
  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  FocusNode contactName = new FocusNode();
  FocusNode groupName = new FocusNode();

  bool _ispickup = false;
  int _paymentType = 1;

  bool addGroup = false;

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
                  addGroup == false
                      ? "Add group name"
                      : "Brittany's Group Order",
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
          height: addGroup == false ? 450 : double.infinity,
          child: Card(
            margin: EdgeInsets.all(20),
            color: Color(WHITE),
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: addGroup == false
                ? Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          WidgetText.widgetPoppinsMediumText(
                            "Add group name",
                            Color(BLACK),
                            20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          customTextInputField(groupName, "Enter group name",
                              "", TextInputType.text),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _paymentType = 1;
                                  });
                                },
                                child: _paymentType == 1
                                    ? WidgetRoundRadioButton
                                        .selectedRoundRadioButton("Delivery")
                                    : WidgetRoundRadioButton
                                        .unselectedRoundRadioButton("Delivery"),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _paymentType = 2;
                                  });
                                },
                                child: _paymentType == 2
                                    ? WidgetRoundRadioButton
                                        .selectedRoundRadioButton("Pickup")
                                    : WidgetRoundRadioButton
                                        .unselectedRoundRadioButton("Pickup"),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                ic_location_pin,
                                width: 18,
                                height: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: WidgetText.widgetPoppinsRegularText(
                                  "121 Vegan Avue, Columbus, OH 43258",
                                  Color(BLACK),
                                  14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          customTextInputField(groupName,
                              "Enter spending limit", "", TextInputType.number),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(WHITE),
                            ),
                            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                            child: WidgetButton.widgetDefaultButton(
                                "Create", onClickCreateGroup),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          WidgetText.widgetPoppinsMediumText(
                            "Join Brittany's Group Order",
                            Color(BLACK),
                            20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: WidgetText.widgetPoppinsRegularText(
                              "Add group participants",
                              Color(BLACK),
                              16,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          customTextInputField(contactName, "Type contact name",
                              "", TextInputType.text),
                          SizedBox(
                            height: 20,
                          ),
                          Flexible(
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: 15,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(22.0),
                                          child: Image.asset(
                                            temp_img_food1,
                                            height: 44.0,
                                            fit: BoxFit.fill,
                                            width: 44.0,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: WidgetText
                                              .widgetPoppinsRegularText(
                                            "Sandip",
                                            Color(BLACK),
                                            16,
                                          ),
                                          flex: 1,
                                          fit: FlexFit.tight,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: WidgetCheckBox.widgetCheckBox(
                                              index == 1 || index == 3
                                                  ? true
                                                  : false),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: Color(DIVIDERCOLOR),
                                    ),
                                  ],
                                );
                              },
                            ),
                            flex: 1,
                            fit: FlexFit.tight,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(WHITE),
                            ),
                            padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
                            child: WidgetButton.widgetDefaultButton(
                                "Invite", onClickShareInvite),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget customTextInputField(FocusNode? focusNode, String hintText,
      String lableText, TextInputType? keyboardType) {
    return Container(
      decoration: BoxDecoration(
        color: Color(WHITE),
        shape: BoxShape.rectangle,
        border: Border.all(color: Color(BLACK), width: 0.5),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      padding: EdgeInsets.fromLTRB(15, 3, 15, 3),
      child: TextFormField(
        textAlign: TextAlign.start,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintStyle: TextStyle(
            color: Color(LIGHTERHINTCOLOR),
            fontSize: 16,
            fontFamily: FontPoppins,
            fontWeight: PoppinsRegular,
          ),
          hintText: hintText,
        ),
        style: TextStyle(
          color: Color(BLACK),
          fontSize: 16,
          fontFamily: FontPoppins,
          fontWeight: PoppinsRegular,
        ),
      ),
    );
  }

  onClickCreateGroup() {
    setState(() {
      addGroup = true;
    });
  }

  onClickShareInvite() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => JoinGroupOrderScreen()));
  }
}

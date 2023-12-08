import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_check_box.dart';
import 'package:choosifoodi/core/widgets/widget_radio_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class NewAddressScreen extends StatefulWidget {
  @override
  _NewAddressScreenState createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends State<NewAddressScreen> {
  int _dietaryValue = 0;
  TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.transparent, //change your color here
        ),
        toolbarHeight: 60,
        elevation: 3,
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
                  ic_back,
                  width: 25,
                  height: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: WidgetText.widgetPoppinsRegularText(
                  "Select a delivery address",
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  customTextInputField(
                      emailController, "", "Full Name", TextInputType.text),
                  customTextInputField(
                      emailController, "", "Mobile No.", TextInputType.phone),
                  customTextInputField(
                      emailController, "", "Address", TextInputType.multiline),
                  Row(
                    children: [
                      Expanded(
                        child: customDropDownField(emailController, "", "City",
                            TextInputType.multiline),
                      ),
                      Expanded(
                        child: customDropDownField(emailController, "", "State",
                            TextInputType.multiline),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: customTextInputField(emailController, "",
                            "Zip code", TextInputType.multiline),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  )
                ],
              ),
              flex: 1,
              fit: FlexFit.tight,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: WidgetText.widgetPoppinsRegularText(
                "Select address type",
                Color(SUBTEXT),
                14,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
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
                          ? WidgetRadioButton.selectedRadioButton("Home")
                          : WidgetRadioButton.unselectedRadioButton("Home"),
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
                          ? WidgetRadioButton.selectedRadioButton("Office")
                          : WidgetRadioButton.unselectedRadioButton("Office"),
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
                          ? WidgetRadioButton.selectedRadioButton("Other")
                          : WidgetRadioButton.unselectedRadioButton("Other"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Row(
                children: [
                  WidgetCheckBox.widgetCheckBox(true),
                  SizedBox(
                    width: 20,
                  ),
                  WidgetText.widgetPoppinsRegularText(
                    "Set default address",
                    Color(BLACK),
                    14,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
              child: WidgetButton.widgetDefaultButton("Save", () {}),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget customDropDownField(TextEditingController editingController,
      String hintText, String lableText, TextInputType? keyboardType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(15, 15, 15, 5),
          child: WidgetText.widgetPoppinsRegularText(
            lableText,
            Color(LIGHTTEXTCOLOR),
            14,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(15, 0, 15, 2),
          decoration: BoxDecoration(
            color: Color(WHITE),
            border: Border.all(color: Color(0xffd2d2d2), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: editingController,
                  textAlign: TextAlign.start,
                  keyboardType: keyboardType,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: Color(HINTCOLOR),
                      fontSize: 14,
                      fontFamily: FontPoppins,
                      fontWeight: PoppinsRegular,
                    ),
                    hintText: hintText,
                  ),
                  style: TextStyle(
                    color: Color(BLACK),
                    fontSize: 14,
                    fontFamily: FontPoppins,
                    fontWeight: PoppinsRegular,
                  ),
                ),
              ),
              Image.asset(
                ic_down_arrow,
                height: 10,
                width: 20,
                color: Color(BLACK),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget customTextInputField(TextEditingController editingController,
      String hintText, String lableText, TextInputType? keyboardType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(15, 15, 15, 5),
          child: WidgetText.widgetPoppinsRegularText(
            lableText,
            Color(LIGHTTEXTCOLOR),
            14,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(15, 0, 15, 2),
          decoration: BoxDecoration(
            color: Color(WHITE),
            border: Border.all(color: Color(0xffd2d2d2), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: TextFormField(
            controller: editingController,
            textAlign: TextAlign.start,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Color(HINTCOLOR),
                fontSize: 14,
                fontFamily: FontPoppins,
                fontWeight: PoppinsRegular,
              ),
              hintText: hintText,
            ),
            style: TextStyle(
              color: Color(BLACK),
              fontSize: 14,
              fontFamily: FontPoppins,
              fontWeight: PoppinsRegular,
            ),
          ),
        )
      ],
    );
  }
}

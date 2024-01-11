import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_color_utils.dart';

class WidgetText {
  static Widget widgetRobotoRegularText(
    String title,
    Color color,
    double textSize, {
    TextAlign align = TextAlign.start,
    decoration: TextDecoration.none,
  }) {
    return Text(
      title,
      style: TextStyle(
          color: color,
          fontSize: textSize,
          fontFamily: FontRoboto,
          fontWeight: RobotoRegular,
          decoration: decoration),
      textAlign: align,
    );
  }

  static Widget widgetRobotoMediumText(
    String title,
    Color color,
    double textSize, {
    TextAlign align = TextAlign.start,
    decoration: TextDecoration.none,
  }) {
    return Text(
      title,
      style: TextStyle(
          color: color,
          fontSize: textSize,
          fontFamily: FontRoboto,
          fontWeight: RobotoMedium,
          decoration: decoration),
      textAlign: align,
    );
  }

  static Widget widgetRobotoBoldText(
    String title,
    Color color,
    double textSize, {
    TextAlign align = TextAlign.start,
    decoration: TextDecoration.none,
  }) {
    return Text(
      title,
      style: TextStyle(
          color: color,
          fontSize: textSize,
          fontFamily: FontRoboto,
          fontWeight: RobotoBold,
          decoration: decoration),
      textAlign: align,
    );
  }

  static Widget widgetPoppinsRegularText(
    String title,
    Color color,
    double textSize, {
    TextAlign align = TextAlign.start,
    decoration= TextDecoration.none,
  }) {
    return Text(
      title,
      style: TextStyle(
          color: color,
          fontSize: textSize,
          fontFamily: FontPoppins,
          fontWeight: PoppinsRegular,
          decoration: decoration,
      decorationColor: color
      ),
      textAlign: align,
    );
  }

  static Widget widgetPoppinsRegularOverflowText(
      String title,
      Color color,
      double textSize, {
        TextAlign align = TextAlign.start,
        decoration: TextDecoration.none,

      }) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color,
          fontSize: textSize,
          fontFamily: FontPoppins,
          fontWeight: PoppinsRegular,
          decoration: decoration),
      textAlign: align,
    );
  }

  static Widget widgetPoppinsMediumOverflowText(
      String title,
      Color color,
      double textSize, {
        TextAlign align = TextAlign.start,
        decoration = TextDecoration.none,
        int maxline = 1,
      }) {
    return Text(
      title,
      maxLines: maxline,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color,
          fontSize: textSize,
          fontFamily: FontPoppins,
          fontWeight: PoppinsMedium,
          decoration: decoration),
      textAlign: align,
    );
  }

  static Widget widgetPoppinsRegularMaxOverflowText(
      String title,
      Color color,
      double textSize, {
        TextAlign align = TextAlign.start,
        decoration = TextDecoration.none,
      }) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      style: TextStyle(
          color: color,
          fontSize: textSize,
          fontFamily: FontPoppins,
          fontWeight: PoppinsRegular,
          decoration: decoration),
      textAlign: align,
    );
  }

  static Widget widgetPoppinsMaxLineOverflowText(
      String title,
      Color color,
      double textSize, {
        int maxline = 1,
        TextAlign align = TextAlign.start,
        decoration= TextDecoration.none,
      }) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      maxLines: maxline,
      style: TextStyle(
          color: color,
          fontSize: textSize,
          fontFamily: FontPoppins,
          fontWeight: PoppinsRegular,
          decoration: decoration),
      textAlign: align,
    );
  }

  static Widget widgetPoppinsMediumText(
    String title,
    Color color,
    double textSize, {
    TextAlign align = TextAlign.start,
    decoration= TextDecoration.none,
  }) {
    return Text(
      title,
      style: TextStyle(
          color: color,
          fontSize: textSize,
          fontFamily: FontPoppins,
          fontWeight: PoppinsMedium,
          decoration: decoration),
      textAlign: align,
    );
  }

  static Widget widgetPoppinsBoldText(
    String title,
    Color color,
    double textSize, {
    TextAlign align = TextAlign.start,
    decoration = TextDecoration.none,
  }) {
    return Text(
      title,
      style: TextStyle(
          color: color,
          fontSize: textSize,
          fontFamily: FontPoppins,
          fontWeight: PoppinsBold,
          decoration: decoration),
      textAlign: align,
    );
  }

  static Widget widgetPoppinsBoldOverflowText(
      String title,
      Color color,
      double textSize, {
        TextAlign align = TextAlign.start,
        decoration = TextDecoration.none,
        int maxline = 1,
      }) {
    return Text(
      title,
      maxLines: maxline,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          color: color,
          fontSize: textSize,
          fontFamily: FontPoppins,
          fontWeight: PoppinsBold,
          decoration: decoration),
      textAlign: align,
    );
  }

  static Widget widgetRegularText(
      String title, {
        TextAlign align = TextAlign.start,
        decoration= TextDecoration.none,
      }) {
    return Text(
      title,
      style: TextStyle(
          color: Color(LABLECOLOR),
          fontSize: 20,
          fontFamily: FontRoboto,
          fontWeight: RobotoRegular,
          decoration: decoration),
      textAlign: TextAlign.end,
    );
  }

  static Widget widgetPoppinsText(
      String title, {
        decoration= TextDecoration.none,
      }) {
    return Text(
      title,
      style: TextStyle(
          color: Color(GREYLABELPOPINS),
          fontSize: 16,
          fontFamily: FontPoppins,
          fontWeight: PoppinsRegular,
          decoration: decoration),
      textAlign: TextAlign.end,
    );
  }

  Widget customTextInputField(TextEditingController editingController,
      String hintText, String lableText, TextInputType? keyboardType, TextInputAction? textInputAction, bool isReadOnly,{required String? readData}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child:
          WidgetText.widgetPoppinsText(lableText),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(10, 2, 0, 0),
          decoration: BoxDecoration(
            color: Color(WHITE),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          padding: EdgeInsets.fromLTRB(0, 3, 15, 3),
          child: isReadOnly == false ? TextFormField(
            controller: editingController,
            textAlign: TextAlign.start,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            readOnly: isReadOnly,
            textCapitalization: TextCapitalization.sentences,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
             LengthLimitingTextInputFormatter(5), ],
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(
                color:   Color(0xff3E4958),
                fontSize: 18,
                fontFamily: FontPoppins,
                fontWeight: PoppinsMedium,
              ),
              hintText: hintText,
                // suffixText: "gm",
            ),
            style: TextStyle(
              color:  Color(BLACK),
              fontSize: 18,
              fontFamily: FontPoppins,
              fontWeight: PoppinsMedium,
            ),
          ) : Text(readData.toString(), style: TextStyle(
            color:  Color(BLACK),
            fontSize: 18,
            fontFamily: FontPoppins,
            fontWeight: PoppinsMedium,
          ),),
        )
      ],
    );
  }

  Widget customTextInputField2(TextEditingController editingController,
      String lableText, TextInputType? keyboardType, TextInputAction? textInputAction,
      [bool name = false, bool isMobile = false]) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
      decoration: BoxDecoration(
        color: Color(WHITE),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
      child: TextFormField(
        controller: editingController,
        textAlign: TextAlign.start,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        textCapitalization: TextCapitalization.sentences,
        inputFormatters: name ?  [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")), ] :
        isMobile ? [
          FilteringTextInputFormatter.digitsOnly,
          // LengthLimitingTextInputFormatter(11),
        ] : [],
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: lableText,
          labelStyle: TextStyle(
            color: Color(HINTCOLOR),
            fontSize: editingController.text.isEmpty ? 14 : 18,
            fontFamily: FontRoboto,
            fontWeight: RobotoRegular,
          ),
        ),
        style: TextStyle(
          color: Color(BLACKINPUT),
          fontSize: 18,
          fontFamily: FontRoboto,
          fontWeight: RobotoMedium,
        ),
      ),
    );
  }
}

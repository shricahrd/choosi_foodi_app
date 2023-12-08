import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:flutter/material.dart';

class WidgetRadioButton {
  static Widget selectedRadioButton(String title) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Color(ORANGE),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          color: Color(WHITE),
          fontSize: 12,
          fontFamily: FontPoppins,
          fontWeight: PoppinsRegular,
        ),
      ),
    );
  }

  static Widget unselectedRadioButton(String title) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Color(GREY),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          color: Color(BLACK),
          fontSize: 12,
          fontFamily: FontPoppins,
          fontWeight: PoppinsRegular,
        ),
      ),
    );
  }
}

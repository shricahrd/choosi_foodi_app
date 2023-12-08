import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:flutter/cupertino.dart';

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
    decoration: TextDecoration.none,
  }) {
    return Text(
      title,
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
    decoration: TextDecoration.none,
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
    decoration: TextDecoration.none,
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
}

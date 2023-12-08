import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:flutter/material.dart';

class WidgetButton {
  static Widget widgetDefaultButton(String title, VoidCallback callback,
      {int bgColor = ORANGE}) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            Color(bgColor),
          ),
          minimumSize: MaterialStateProperty.all<Size>(
            Size(double.maxFinite, 45.0),
          ),
        ),
        onPressed: callback,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: FontRoboto,
            fontWeight: RobotoRegular,
          ),
          textAlign: TextAlign.end,
        ),
      ),
    );
  }
}

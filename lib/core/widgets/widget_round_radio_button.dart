import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:flutter/material.dart';

class WidgetRoundRadioButton {
  static Widget selectedRoundRadioButton(String title) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ic_select_round_radio,
            height: 20,
            width: 20,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: TextStyle(
              color: Color(BLACK),
              fontSize: 16,
              fontFamily: FontPoppins,
              fontWeight: RobotoRegular,
            ),
          )
        ],
      ),
    );
  }

  static Widget unselectedRoundRadioButton(String title) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ic_unselect_round_radio,
            height: 20,
            width: 20,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: TextStyle(
              color: Color(BLACK),
              fontSize: 16,
              fontFamily: FontPoppins,
              fontWeight: RobotoRegular,
            ),
          )
        ],
      ),
    );
  }
}

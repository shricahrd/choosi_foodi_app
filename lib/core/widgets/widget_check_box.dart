import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:flutter/material.dart';

class WidgetCheckBox {
  static Widget selectedRoundRadioButton(bool isSelected) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isSelected
              ? Image.asset(
                  ic_select_round_radio,
                  height: 25,
                  width: 25,
                )
              : Image.asset(
                  ic_unselect_round_radio,
                  height: 25,
                  width: 25,
                ),
        ],
      ),
    );
  }

  static Widget widgetCheckBox(bool isSelected) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isSelected
              ? Stack(
                  children: [
                    Image.asset(
                      ic_selected_checkbox_bg,
                      height: 25,
                      width: 25,
                    ),
                    Positioned(
                      top: 5,
                      left: 5,
                      right: 5,
                      bottom: 5,
                      child: Image.asset(
                        ic_selected_checkbox_mark,
                        height: 25,
                        width: 25,
                      ),
                    )
                  ],
                )
              : Image.asset(
                  ic_unselected_checkbox,
                  height: 25,
                  width: 25,
                ),
        ],
      ),
    );
  }
}

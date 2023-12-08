import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/*
* Show Toast Message
* */
void showToastMessage(String toastMsg) {
  Fluttertoast.showToast(
      msg: toastMsg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0);
}

/*
* Custom App loader
* */
Widget AppLoader({required Widget widget, required bool isLoading}) {
  return Stack(
    children: [
      widget,
      isLoading
          ? Positioned(
              left: 1,
              right: 1,
              top: 1,
              bottom: 1,
              child: Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: Color(ORANGE),
                ),
              ),
            )
          : Container(),
    ],
  );
}

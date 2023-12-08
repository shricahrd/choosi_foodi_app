import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class CheckoutGroupOrderScreen extends StatefulWidget {
  @override
  _CheckoutGroupOrderScreenState createState() =>
      _CheckoutGroupOrderScreenState();
}

class _CheckoutGroupOrderScreenState extends State<CheckoutGroupOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Color(WHITE),
              ),
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset(
                    ic_right_side_arrow,
                    width: 18,
                    height: 18,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  WidgetText.widgetRobotoRegularText(
                    "Back",
                    Color(BLACK),
                    14,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(WHITE),
                ),
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Container(
                  child: WidgetText.widgetRobotoMediumText(
                    "Create Group Order",
                    Color(ORANGE),
                    25,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(WHITE),
              ),
              padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
              child: WidgetButton.widgetDefaultButton("Checkout", onClickNext),
            ),
          ],
        ),
      ),
    );
  }

  onClickNext() {}
}

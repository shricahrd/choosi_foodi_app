import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/food_detail/food_detail_screen.dart';
import 'package:flutter/material.dart';

class JoinGroupOrderScreen extends StatefulWidget {
  @override
  _JoinGroupOrderScreenState createState() => _JoinGroupOrderScreenState();
}

class _JoinGroupOrderScreenState extends State<JoinGroupOrderScreen> {
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
                  "Join group order",
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
          child: Card(
            margin: EdgeInsets.all(20),
            color: Color(WHITE),
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Color(WHITE),
              ),
              height: double.infinity,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      app_icon,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: WidgetText.widgetPoppinsMediumText(
                      "Join Group Order?",
                      Color(BLACK),
                      22,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: WidgetText.widgetPoppinsRegularText(
                        "When you join the order you can\nadd any item, all items will be\ndelivered together.",
                        Color(SUBTEXT),
                        16,
                        align: TextAlign.center),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    alignment: Alignment.topLeft,
                    child: WidgetText.widgetPoppinsMediumText(
                        "Details", Color(BLACK), 18,
                        align: TextAlign.start),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Divider(
                        height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    alignment: Alignment.topLeft,
                    child: WidgetText.widgetPoppinsRegularText(
                        "Order From : Vegan vinnies", Color(BLACK), 16,
                        align: TextAlign.start),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Divider(
                        height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    alignment: Alignment.topLeft,
                    child: WidgetText.widgetPoppinsRegularText(
                        "Delivery to : 240 Parsons Avenue", Color(BLACK), 16,
                        align: TextAlign.start),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Divider(
                        height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    alignment: Alignment.topLeft,
                    child: WidgetText.widgetPoppinsRegularText(
                        "Spending Limit : \$15", Color(BLACK), 16,
                        align: TextAlign.start),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Divider(
                        height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(WHITE),
                    ),
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: WidgetButton.widgetDefaultButton(
                        "Join group order", onClickNext),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onClickNext() {
    FoodDetailScreen.setIsGroupOrder(true);
    Navigator.of(context).pop(context);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => FoodDetailScreen()));
  }
}

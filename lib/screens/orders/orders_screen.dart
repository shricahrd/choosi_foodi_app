import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/orders/canceled_order_screen.dart';
import 'package:choosifoodi/screens/orders/completed_order_screen.dart';
import 'package:choosifoodi/screens/orders/upcoming_order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.transparent, //change your color here
        ),
        toolbarHeight: 60,
        shadowColor: Color(HINTCOLOR),
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
              WidgetText.widgetPoppinsRegularText(
                "Orders",
                Color(BLACK),
                18,
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: ListView(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("Upcoming Orders", onClickUpcomingOrder),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("Completed  Orders", onClickCompletedOrder),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("Canceled Orders", onClickCanceledOrder),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              flex: 1,
              fit: FlexFit.tight,
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuWidget(String title, VoidCallback function) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: InkWell(
        onTap: function,
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: WidgetText.widgetPoppinsRegularText(
                      title, Color(0xff222222), 16),
                ),
                Image.asset(
                  ic_left_side_arrow,
                  height: 15,
                  color: Color(BLACK),
                  width: 15,
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              color: Color(ORANGE),
              height: 1,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }

  onClickCanceledOrder() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => CanceledOrdersScreen()));
  }

  onClickUpcomingOrder() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => UpcomingOrdersScreen()));
  }

  onClickCompletedOrder() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => CompletedOrdersScreen()));
  }
}

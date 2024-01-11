import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/widgets/widget_card.dart';
import '../../group_order/view/group_order_screen.dart';
import 'normal_order_screen.dart';

class OrderMgmtRestScreen extends StatefulWidget {
  final bool isNormalOrder;

  OrderMgmtRestScreen({required this.isNormalOrder});

  @override
  _OrderMgmtRestScreenState createState() => _OrderMgmtRestScreenState(isNormalOrder);
}

class _OrderMgmtRestScreenState extends State<OrderMgmtRestScreen> {
    bool isNormalOrder = true;

    _OrderMgmtRestScreenState(bool isNormalOrder) {
      this.isNormalOrder = isNormalOrder;
    }

  @override
  void initState() {
    print('Init Order screen');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context,  isNormalOrder ? individualOrders : groupOrders, true),
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
                  _menuWidget(newOrders, ()=>onClickOrderType(orderType: 1)
                      // onClickUpcomingOrder
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget(completedOrders, ()=>onClickOrderType(orderType: 2)
                      // onClickCompletedOrder
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget(canceledOrders, ()=>onClickOrderType(orderType: 3)
                  ),
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

  onClickOrderType({required int orderType}){
      if(isNormalOrder == true) {
        Get.to(() => NormalRestOrderScreen(orderType: orderType,));
      }else{
        Get.to(() => GroupRestOrderScreen(orderType: orderType,));
      }
  }
}

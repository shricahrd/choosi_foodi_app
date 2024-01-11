import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/utils/app_strings_constants.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/widget_card.dart';
import '../group_order/group_order_list_screen.dart';

class GroupOrderTypeScreen extends StatefulWidget {
  @override
  _GroupOrderTypeScreenState createState() => _GroupOrderTypeScreenState();
}

class _GroupOrderTypeScreenState extends State<GroupOrderTypeScreen> {

  @override
  void initState() {
    print('Init Order screen');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context, groupOrders, true ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: ListView(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                physics: BouncingScrollPhysics(),
                children: [
                /*  SizedBox(
                    height: 20,
                  ),
                  _menuWidget("Draft Orders", ()=>onClickOrderType()),*/
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget(upcomingOrders, ()=>onClickGroupOrder(orderStatus: 1)
                      // onClickUpcomingOrder
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget(completedOrders, ()=>onClickGroupOrder(orderStatus: 2)
                      // onClickCompletedOrder
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget(canceledOrders, ()=>onClickGroupOrder(orderStatus: 3)
                      // onClickCanceledOrder
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
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
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


  onClickGroupOrder({required int orderStatus}){
    Get.to(()=> GroupOrderListScreen(orderStatus: orderStatus) );
  }
}

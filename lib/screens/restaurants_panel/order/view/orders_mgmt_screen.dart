import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_strings_constants.dart';
import 'orders_mgmt_type_screen.dart';

class OrderManagementScreen extends StatefulWidget {
  final bool isFromHome;

  OrderManagementScreen({required this.isFromHome});

  @override
  _OrderManagementScreenState createState() => _OrderManagementScreenState(isFromHome);
}

class _OrderManagementScreenState extends State<OrderManagementScreen> {
  bool isFromHome = false;

  _OrderManagementScreenState(bool isFromHome) {
    this.isFromHome = isFromHome;
  }

  @override
  void initState() {
    debugPrint('Init Order screen');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.transparent, //change your color here
        ),
        elevation: 4,
        toolbarHeight: 60,
        shadowColor: Color(HINTCOLOR),
        backgroundColor: Color(WHITE),
        flexibleSpace: Container(
          color: Color(WHITE),
          height: double.infinity,
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isFromHome
                  ? Container(
                height: 20,
              )
                  : InkWell(
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
                16,
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
                  _menuWidget(individualOrders, ()=>onClickNormalOrderType()
                      // onClickUpcomingOrder
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _menuWidget(groupOrders, ()=>onClickGroupOrderType()
                      // onClickCompletedOrder
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

  onClickNormalOrderType(){
    Get.to(()=> OrderMgmtRestScreen(isNormalOrder: true,));
  }

  onClickGroupOrderType(){
    Get.to(()=> OrderMgmtRestScreen(isNormalOrder: false,));
    // Get.to(()=> GroupOrderTypeScreen());
  }
}

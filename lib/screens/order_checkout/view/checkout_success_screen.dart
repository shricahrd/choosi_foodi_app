import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../core/utils/app_color_utils.dart';
import '../../../core/utils/app_images_utils.dart';
import '../../../core/utils/app_preferences.dart';
import '../../../core/widgets/widget_text.dart';
import '../../base_application/base_application.dart';
import '../../orders/view/group_order/track_group_order_screen.dart';
import '../../orders/view/normal_order/track_order_screen.dart';

class CheckoutSuccessScreen extends StatefulWidget {
  String restaurantName;
  String? orderId;
  bool isNormalOrder = false;

  CheckoutSuccessScreen({Key? key, required this.restaurantName, this.orderId,required this.isNormalOrder})
      : super(key: key);

  @override
  State<CheckoutSuccessScreen> createState() => _CheckoutSuccessScreenState();
}

class _CheckoutSuccessScreenState extends State<CheckoutSuccessScreen> {
  var orderID;
  bool isNormalOrder = false;
  @override
  void initState() {
    isNormalOrder = widget.isNormalOrder;
    orderID = widget.orderId.toString();
    debugPrint('MenuOrderid: ${orderID.toString()}, isNormalOrder: $isNormalOrder');
    if(isNormalOrder == true) {
      navigateOrderDetails();
    }else{
      navigateGroupTrackDetails();
    }
    removeGroupId();
    super.initState();
  }

  removeGroupId() {
    setState(() {
      AppPreferences.setGroupId("");
    });
  }

  navigateOrderDetails() {
    if (orderID.isNotEmpty) {
      if (orderID != null) {
        debugPrint('MenuOrderid not null: ${orderID}');
        Future.delayed(const Duration(seconds: 2), () {
           Get.to(() =>
              TrackOrderScreen(
                orderId: orderID.toString(),
                isNormalOrder: false,
              ));
        });
      }
    }
  }

  navigateGroupTrackDetails() {
    if (orderID.isNotEmpty) {
      if (orderID != null) {
        debugPrint('MenuOrderid not null: ${orderID}');
        Future.delayed(const Duration(seconds: 2), () {
          Get.to(()=> TrackGroupOrderScreen(orderId:  orderID.toString(), isGroupOrder: false,));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BaseApplication()),
            (r) => false);
        return false;
      },
      child: Scaffold(
          backgroundColor: Color(WHITE),
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.transparent,
            ),
            automaticallyImplyLeading: false,
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
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BaseApplication()),
                          (r) => false);
                    },
                    child:  Image.asset(
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
                      "Thank You",
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
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ic_thanks,
                  ),
                  WidgetText.widgetRobotoBoldText(
                    "Thank You",
                    Color(BLACK),
                    30,
                  ),
                  WidgetText.widgetPoppinsRegularText(
                      "Thank you for ordering from ${widget.restaurantName}",
                      // "You have successfully checkout the food",
                      Color(SUBTEXT),
                      16,
                      align: TextAlign.center),
                ],
              ),
            ),
          )),
    );
  }
}

import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_card.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../core/utils/app_color_utils.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import '../controller/dashboard_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardController _dashboardController =
      Get.put(DashboardController());
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());

  @override
  void initState() {
    if (_networkManager.connectionType != 0) {
      print('Connection Type: ${_networkManager.connectionType}');
      _dashboardController.callGetDashboard();
    }
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
        toolbarHeight: 60,
        shadowColor: Color(HINTCOLOR),
        backgroundColor: Color(WHITE),
        flexibleSpace: Container(
          height: double.infinity,
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          alignment: Alignment.bottomCenter,
          child: WidgetText.widgetPoppinsRegularText(
            dashboard,
            Color(BLACK),
            16,
          ),
        ),
      ),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
       return networkManager.connectionType == 0
           ? Center(child: Text(check_internet))
           : GetBuilder<DashboardController>(builder: (logic) {
              return
                logic.isLoaderVisible == false ?
                Container(
                 margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                 child: ListView(
                   physics: BouncingScrollPhysics(),
                   children: [
                     WidgetCard.rectCard(total_dishes, logic.vendorDashboardModel.data?.totalMenus.toString() ?? "0", ic_dish),
                     customTextInputField(total_active_dishes, logic.vendorDashboardModel.data?.totalActiveMenus ?? 0),
                     customTextInputField(total_inactive_dishes, logic.vendorDashboardModel.data?.totalDeactiveMenus ?? 0),
                     // WidgetCard.rectCard(total_new_orders, logic.vendorDashboardModel.data?.totalNewOrder.toString() ?? "3", ic_order_bag),
                     WidgetCard.rectCard(total_new_orders, "${int.parse(logic.vendorDashboardModel.data?.totalNewOrder.toString() ?? "")
                         + int.parse(logic.vendorDashboardModel.data?.totalNewGroupOrder.toString() ?? "")}",
                         ic_order_bag),
                     customTextInputField(total_orders_oud, (logic.vendorDashboardModel.data?.totalOutOfDeliveryOrder ?? 0)
                         + (logic.vendorDashboardModel.data?.totalOutOfDeliveryGroupOrder ?? 0)),
                     customTextInputField(total_orders_delivered, (logic.vendorDashboardModel.data?.totalDeliveredOrder ?? 0)
                         + (logic.vendorDashboardModel.data?.totalDeliveredGroupOrder ?? 0)),
                     customTextInputField(total_orders_canceled, (logic.vendorDashboardModel.data?.totalCancelledOrder ?? 0)
                         + (logic.vendorDashboardModel.data?.totalCancelledGroupOrder ?? 0)),
                     SizedBox(
                       height: 20,
                     ),
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Flexible(
                           child: Card(
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(100.0),
                             ),
                             elevation: 5,
                             child: Container(
                               decoration: BoxDecoration(
                                 color: Color(WHITE),
                                 borderRadius: BorderRadius.all(Radius.circular(100.0)),
                               ),
                               padding: EdgeInsets.all(10),
                               child: Card(
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(80.0),
                                 ),
                                 elevation: 5,
                                 child: Container(
                                   decoration: BoxDecoration(
                                     color: Color(WHITE),
                                     borderRadius: BorderRadius.all(Radius.circular(80.0)),
                                   ),
                                   child: CircularPercentIndicator(
                                     radius: 65.0,
                                     lineWidth: 7.0,
                                     percent: 0.25,
                                     center: Container(
                                       margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.center,
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                           WidgetText.widgetPoppinsBoldText(
                                             logic.vendorDashboardModel.data?.totalSale.round().toString() ?? '1000',
                                             Color(BLACK),
                                             18,
                                           ),
                                           WidgetText.widgetPoppinsMediumText(
                                             total_sale,
                                             Color(SUBTEXT),
                                             10,
                                             align: TextAlign.center,
                                           ),
                                         ],
                                       ),
                                     ),
                                     progressColor: Color(ORANGE),
                                     backgroundColor: Colors.transparent,
                                   ),
                                 ),
                               ),
                             ),
                           ),
                           flex: 1,
                           fit: FlexFit.loose,
                         ),
                         SizedBox(
                           width: 20,
                         ),
                         Flexible(
                           child: Card(
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(100.0),
                             ),
                             elevation: 5,
                             child: Container(
                               decoration: BoxDecoration(
                                 color: Color(WHITE),
                                 borderRadius: BorderRadius.all(Radius.circular(100.0)),
                               ),
                               padding: EdgeInsets.all(10),
                               child: Card(
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(80.0),
                                 ),
                                 elevation: 7,
                                 child: Container(
                                   decoration: BoxDecoration(
                                     color: Color(WHITE),
                                     borderRadius: BorderRadius.all(Radius.circular(80.0)),
                                   ),
                                   child: CircularPercentIndicator(
                                     radius: 65.0,
                                     lineWidth: 7.0,
                                     percent: 0.25,
                                     center: Container(
                                       margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.center,
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                           WidgetText.widgetPoppinsBoldText(
                                             logic.vendorDashboardModel.data?.totalComission.round().toString() ?? '500',
                                             Color(BLACK),
                                             18,
                                           ),
                                           WidgetText.widgetPoppinsMediumText(
                                             total_commission_amt,
                                             Color(SUBTEXT),
                                             10,
                                             align: TextAlign.center,
                                           ),
                                         ],
                                       ),
                                     ),
                                     progressColor: Color(YELLOW),
                                     backgroundColor: Colors.transparent,
                                   ),
                                 ),
                               ),
                             ),
                           ),
                           flex: 1,
                           fit: FlexFit.loose,
                         ),
                       ],
                     ),
                     SizedBox(
                       height: 10,
                     ),
                   ],
                 ),
               )
                    : Center(
                  child: CircularProgressIndicator(
                    color: Color(ORANGE),
                  ),
                );
             });
      })),
    );
  }

  Widget customTextInputField(
    String detail1,
    int detail2,
  ) {
    return Container(
        margin: EdgeInsets.fromLTRB(15, 2, 15, 10),
        decoration: BoxDecoration(
          color: Color(WHITE),
          shape: BoxShape.rectangle,
          border: Border.all(color: Color(ORANGE), width: 1),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WidgetText.widgetPoppinsRegularText(
              detail1,
              Color(LABLECOLOR),
              14,
              align: TextAlign.start,
            ),
            WidgetText.widgetPoppinsMediumText(
              detail2.toString(),
              Color(BLACK),
              25,
              align: TextAlign.end,
            ),
          ],
        ));
  }
}

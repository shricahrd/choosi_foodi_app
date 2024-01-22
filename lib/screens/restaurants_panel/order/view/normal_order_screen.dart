import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_font_utils.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import '../../../../core/widgets/widget_card.dart';
import '../../../../core/widgets/widget_webview.dart';
import '../../../../routes/general_path.dart';
import '../controller/normal_order_controller.dart';
import 'filter_order_screen.dart';
import 'order_details_screen.dart';

class NormalRestOrderScreen extends StatefulWidget {
  int orderType;

  NormalRestOrderScreen(
      {required this.orderType,});

  @override
  _NormalRestOrderScreenState createState() =>
      _NormalRestOrderScreenState(orderType);
}

class _NormalRestOrderScreenState extends State<NormalRestOrderScreen> {
  final NormalRestOrderController _normalRestOrderController =
      Get.put(NormalRestOrderController());
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());
  bool isChecked = true;
  String searchString = "";
  dynamic startDate = "", endDate = "", orderTypeData = "";
  int orderType = 1;
  List statusList = [];
  Map<String, dynamic> receivedData = {};
  double fontSize = 13.0;
  _NormalRestOrderScreenState(int orderType,) {
    this.orderType = orderType;
  }

  checkOrderStatus() async {
    setState(() {
      _normalRestOrderController.isLoaderVisible = true;
    });
    if(widget.orderType == 2){
      _normalRestOrderController.orderStatusFilter = 6;
    }else if(widget.orderType == 3){
      _normalRestOrderController.orderStatusFilter = 7;
    }
    await _normalRestOrderController.callRestGetOrderAPI(
      // filterType: orderStatusType,
      searchString: searchString,
      startDateSearch: startDate,
      endDateSearch: endDate,
      orderType: orderTypeData,
    );
  }

  checkOrderType(bool orderType){
    if(orderType == true){
      statusList = [
        selectOrderStatus,
        orderReceive,
        beingPrepare,
        outforDelivery,
        delivered,
      ];
    }else {
      statusList = [
        selectOrderStatus,
        orderReceive,
        beingPrepare,
        readyPickup,
        picked,
      ];
    }
  }

  @override
  void initState() {
    debugPrint('Init Order Type : $orderType');
    if (_networkManager.connectionType != 0) {
      debugPrint('Connection Type: ${_networkManager.connectionType}');
      checkOrderStatus();
    }
    super.initState();
  }



  callChangeOrderStatus({required String menuId, required int statusId}) async {
    await _normalRestOrderController.changeOrderStatusAPI(
        menuId: menuId, status: statusId);
    if (_normalRestOrderController.metaModel.meta?.status == true) {
      checkOrderStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context,  orderType == 1
          ? newOrders
          : orderType == 2
          ? completedOrders
          : canceledOrders, true),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          child: Card(
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(WHITE),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: TextFormField(
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.search),
                                  hintStyle: TextStyle(
                                    color: Color(0xff8C8989),
                                    fontSize: fontSize,
                                    fontFamily: FontPoppins,
                                    fontWeight: PoppinsRegular,
                                  ),
                                  hintText: search,
                                ),
                                style: TextStyle(
                                  color: Color(0xff3E4958),
                                  fontSize: fontSize,
                                  fontFamily: FontPoppins,
                                  fontWeight: PoppinsRegular,
                                ),
                                onChanged: (value) {
                                  if(value.isEmpty){
                                    searchString = value;
                                    checkOrderStatus();
                                  }
                                },
                                onFieldSubmitted: (value){
                                  searchString = value;
                                  checkOrderStatus();
                                  debugPrint("$value");
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: onClickFilter,
                          child: Image.asset(
                            ic_filter,
                            width: 30,
                            color: Color(BLACK2),
                            height: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: WidgetButton.widgetDefaultButton(
                        export_excel, onClickExport),
                  ),
                  GetBuilder<NormalRestOrderController>(builder: (logic) {

                    return Expanded(
                      child: logic.isLoaderVisible
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Color(ORANGE),
                            ))
                          : logic.getFilterOrderModel.length == 0
                              ? Center(
                                  child:
                                  WidgetText.widgetPoppinsMediumText(
                                      'No Order Found',
                                      Color(BLACK2),
                                      fontSize))
                              : Container(
                                  height: 210,
                                  width: double.infinity,
                                  child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: logic.getFilterOrderModel.length,
                                      itemBuilder: (context, index) {

                                        // debugPrint('OrderStatus screen len: ${logic.orderStatus}');
                                        debugPrint('OrderStatus logic.getFilterOrderModel[index].orderType: ${logic.getFilterOrderModel[index].orderType}');

                                        if(logic.getFilterOrderModel[index].orderType == 'DELIVERY') {
                                          checkOrderType(true);
                                        }else{
                                          checkOrderType(false);
                                        }

                                        return Card(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          color: Color(WHITE),
                                          elevation: 5.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          shadowColor: Color(BLACK2),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(WHITE),
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                            padding: EdgeInsets.all(15),
                                            width: 280,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                          serialNo,
                                                            Color(SUBTEXT),
                                                            fontSize),
                                                    WidgetText
                                                        .widgetPoppinsMediumOverflowText(
                                                            "${index + 1}",
                                                            Color(BLACK2),
                                                            fontSize),
                                                    // Spacer(),
                                                    Flexible(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .end,
                                                        children: [
                                                          WidgetText
                                                              .widgetPoppinsRegularText(
                                                              name,
                                                              Color(GREY3),
                                                              fontSize,
                                                              align:
                                                              TextAlign
                                                                  .end),
                                                          SizedBox(width: 5,),
                                                          Flexible(
                                                              child: WidgetText.widgetPoppinsMediumOverflowText(
                                                                  logic
                                                                      .getFilterOrderModel[
                                                                  index]
                                                                      .userData
                                                                      .firstName +
                                                                      " " +
                                                                      logic
                                                                          .getFilterOrderModel[
                                                                      index]
                                                                          .userData
                                                                          .lastName,
                                                                  Color(BLACK2),
                                                                  fontSize,
                                                                  align:
                                                                  TextAlign
                                                                      .end,
                                                                  maxline: 1)),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 15, 0, 0),
                                                  padding: EdgeInsets.all(15),
                                                  decoration: BoxDecoration(
                                                    color: Color(WHITE),
                                                    shape: BoxShape.rectangle,
                                                    border: Border.all(
                                                        color: Color(ORANGE),
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                WidgetText.widgetPoppinsRegularText(
                                                                    custId,
                                                                    Color(
                                                                        SUBTEXT),
                                                                    fontSize),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                WidgetText
                                                                    .widgetPoppinsMediumOverflowText(
                                                                  logic
                                                                      .getFilterOrderModel[
                                                                          index]
                                                                      .userData
                                                                      .userId,
                                                                  Color(
                                                                      BLACK2),
                                                                  fontSize,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              WidgetText.widgetRobotoMediumText(
                                                                  '\$' +
                                                                      logic
                                                                          .getFilterOrderModel[
                                                                              index]
                                                                          .total
                                                                          .toString(),
                                                                  Color(
                                                                      ORANGE),
                                                                  16),
                                                              WidgetText.widgetPoppinsMediumOverflowText(
                                                                  total,
                                                                  Color(
                                                                      SUBTEXT),
                                                                  fontSize),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      WidgetText
                                                          .widgetPoppinsRegularText(
                                                          orderId,
                                                              Color(SUBTEXT),
                                                              fontSize),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      WidgetText
                                                          .widgetPoppinsMediumOverflowText(
                                                              logic
                                                                  .getFilterOrderModel[
                                                                      index]
                                                                  .menuOrderID,
                                                              Color(BLACK2),
                                                              fontSize),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      WidgetText
                                                          .widgetPoppinsRegularText(
                                                              orderPlaced,
                                                              Color(SUBTEXT),
                                                              fontSize),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      WidgetText
                                                          .widgetPoppinsMediumOverflowText(
                                                          logic.getFilterOrderModel[index].parseCreatedDate,
                                                              Color(BLACK2),
                                                              fontSize),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      orderType == 1
                                                          ?
                                                      logic.getFilterOrderModel[index].orderType == 'DELIVERY' ?
                                                      WidgetText
                                                              .widgetPoppinsRegularText(
                                                              expectedDelivery,
                                                              Color(SUBTEXT),
                                                              fontSize,
                                                            ):    WidgetText
                                                              .widgetPoppinsRegularText(
                                                               expectedCompletion,
                                                              Color(SUBTEXT),
                                                              fontSize,
                                                            )
                                                          : orderType == 2
                                                              ? WidgetText
                                                                  .widgetPoppinsRegularText(
                                                                  orderDelivered,
                                                                  Color(
                                                                      SUBTEXT),
                                                                  fontSize,
                                                                )
                                                              : WidgetText
                                                                  .widgetPoppinsRegularText(
                                                                  orderCanceled,
                                                                  Color(
                                                                      SUBTEXT),
                                                                  fontSize,
                                                                ),
                                                      SizedBox(
                                                        height: 8,
                                                      ),

                                                      WidgetText
                                                          .widgetPoppinsMediumOverflowText(
                                                          logic.getFilterOrderModel[index].timeSlot.isEmpty ? (logic.getFilterOrderModel[index].parseDeliveryDate):
                                                          (logic.getFilterOrderModel[index].parseDeliveryDate + ",\n" + logic.getFilterOrderModel[index].timeSlot),
                                                              // "17-04-22, 4:30PM",
                                                              Color(BLACK2),
                                                              fontSize, maxline: 2),
                                                      SizedBox(
                                                        height: 15,
                                                      ),

                                                      // orderType
                                                      WidgetText
                                                          .widgetPoppinsRegularText(
                                                          orderTypeTitle,
                                                          Color(SUBTEXT),
                                                          fontSize),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      WidgetText
                                                          .widgetPoppinsMediumOverflowText(
                                                          logic.getFilterOrderModel[index].orderType,
                                                          // "17-04-22, 4:30PM",
                                                          Color(BLACK2),
                                                          fontSize),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      orderType == 1
                                                          ? Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2,
                                                              child: Card(
                                                                margin: EdgeInsets
                                                                    .fromLTRB(
                                                                        0,
                                                                        10,
                                                                        0,
                                                                        10),
                                                                color: Color(
                                                                    WHITE),
                                                                elevation:
                                                                    5.0,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          5.0),
                                                                ),
                                                                shadowColor:
                                                                    Color(
                                                                        BLACK2),
                                                                child:
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                        color: Color(WHITE),
                                                                        borderRadius: BorderRadius.circular(5.0),
                                                                      ),
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          15,
                                                                          0,
                                                                          15,
                                                                          0),
                                                                  child:
                                                                      DropdownButton(
                                                                    underline:
                                                                        Container(),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    icon:
                                                                        Visibility(
                                                                      visible: true,
                                                                      child: Image
                                                                          .asset(
                                                                        ic_down_arrow,
                                                                        height:
                                                                            10,
                                                                        width:
                                                                            20,
                                                                        color:
                                                                            Color(DARKGREY),
                                                                      ),
                                                                    ),
                                                                    isExpanded: true,
                                                                        value: logic.getFilterOrderModel[index].selectedOrderStatus.toString().isEmpty ? selectOrderStatus
                                                                            :logic.getFilterOrderModel[index].selectedOrderStatus.toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color(
                                                                          BLACK2),
                                                                      fontSize:
                                                                          fontSize,
                                                                      fontFamily:
                                                                          FontPoppins,
                                                                      fontWeight:
                                                                          PoppinsRegular,
                                                                    ),
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(() {
                                                                        debugPrint("selectedOrderStatus click==> ${logic.getFilterOrderModel[index].selectedOrderStatus}");
                                                                        debugPrint("onChanged value   $value");
                                                                        if(value.toString().isNotEmpty){
                                                                          logic.getFilterOrderModel[index].setSelectedStatus = value.toString();
                                                                        }else{
                                                                          logic.getFilterOrderModel[index].setSelectedStatus = "";
                                                                        }

                                                                        if (logic.getFilterOrderModel[index].selectedOrderStatus != selectOrderStatus) {
                                                                          var statusData = getOrderId(logic.getFilterOrderModel[index].selectedOrderStatus);
                                                                          callChangeOrderStatus(menuId: logic.getFilterOrderModel[index].menuOrderId.toString(), statusId: statusData);
                                                                        }
                                                                        debugPrint('selectStatus : ${logic.getFilterOrderModel[index].selectedOrderStatus}');
                                                                      });
                                                                    },
                                                                    items: statusList.map(
                                                                        (dynamic
                                                                            selectedValue) {
                                                                      return DropdownMenuItem<
                                                                          String>(
                                                                        child:
                                                                            Text(
                                                                              selectedValue.toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            color: Color(BLACK2),
                                                                            fontSize: fontSize,
                                                                            fontFamily: FontRoboto,
                                                                            fontWeight: RobotoRegular,
                                                                          ),
                                                                        ),
                                                                        value:
                                                                        selectedValue,
                                                                      );
                                                                    }).toList(),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : Container(),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                orderType == 1
                                                    ? Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Expanded(
                                                            child: InkWell(
                                                              onTap: () {
                                                                Get.to(() =>
                                                                    OrderDetails(
                                                                      orderStatus:
                                                                          orderType,
                                                                      orderId: logic
                                                                          .getFilterOrderModel[
                                                                              index]
                                                                          .menuOrderId,
                                                                      serialNo: index + 1,
                                                                    ));
                                                              },
                                                              child: Container(
                                                              padding: EdgeInsets.all(10),
                                                                decoration: BoxDecoration(
                                                                  color: Color(ORANGE),
                                                                  shape: BoxShape.rectangle,
                                                                  borderRadius:
                                                                      BorderRadius.all(Radius.circular(7)),
                                                                ),
                                                                alignment: Alignment.center,
                                                                child: WidgetText
                                                                    .widgetPoppinsMediumText(
                                                                  viewDetails,
                                                                  Color(WHITE),
                                                                  12,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Expanded(
                                                            child: InkWell(
                                                              onTap: () {
                                                                debugPrint(
                                                                    '$generateReceipt${GeneralPath.BASE_URI + GeneralPath.API_INVOICE + logic.getFilterOrderModel[index].menuOrderId.toString()}');
                                                                    Get.to(() =>
                                                                    WidgetWebview(
                                                                      url: GeneralPath.BASE_URI +
                                                                          GeneralPath.API_INVOICE +
                                                                          logic.getFilterOrderModel[index].menuOrderId.toString(), appbarName: viewReceipt,));
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets.all(10),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      WHITE),
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  border: Border.all(
                                                                      color: Color(
                                                                          ORANGE),
                                                                      width: 1),
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              7)),
                                                                ),
                                                                alignment:
                                                                Alignment
                                                                        .center,
                                                                child: WidgetText
                                                                    .widgetPoppinsMediumText(
                                                                  genetateReceipt,
                                                                  Color(ORANGE),
                                                                  12,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                        ],
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          Get.to(() =>
                                                              OrderDetails(
                                                                orderStatus:
                                                                    orderType,
                                                                orderId: logic
                                                                    .getFilterOrderModel[
                                                                        index]
                                                                    .menuOrderId,
                                                                serialNo: index + 1,
                                                              ));
                                                        },
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              3.5,
                                                          padding: EdgeInsets
                                                              .fromLTRB(0, 10,
                                                                  0, 10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Color(ORANGE),
                                                            shape: BoxShape
                                                                .rectangle,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            7)),
                                                          ),
                                                          alignment: Alignment
                                                              .center,
                                                          child: WidgetText
                                                              .widgetPoppinsMediumText(
                                                            viewDetails,
                                                            Color(WHITE),
                                                            12,
                                                          ),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                    );
                  })
                ],
              );
      })),
    );
  }

  // onClickViewDetails(String orderId) {
  //   Get.to(()=> OrderDetails(orderStatus: orderStatus, orderId: orderId,));
  // }

  onClickExport() {
    String filaname = newOrders;
    if( orderType == 1){
      filaname = newOrders;
    }else  if( orderType == 2){
      filaname = completedOrders;
    }else {
      filaname = canceledOrders;
    }

    _normalRestOrderController.createExcel(filaname);
  }

  onClickFilter() async {
    final result =  await Get.to(() => FilterOrdersScreen(
          orderType: widget.orderType,
        ));

    // Handle the result from the second screen
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        receivedData = result;
        debugPrint("receivedData=======> $receivedData");
        debugPrint("receivedData selectOrderType=======> ${receivedData['selectOrderType']}");
        _normalRestOrderController.orderStatusFilter = receivedData['orderStatus'];
        startDate = receivedData["startDateSearch"];
        endDate = receivedData["endDateSearch"];
        orderTypeData = receivedData["selectOrderType"];
        searchString = receivedData["searchKey"];
      });
      checkOrderStatus();
    }
  }
}

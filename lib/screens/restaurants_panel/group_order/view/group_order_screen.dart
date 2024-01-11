import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_font_utils.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import '../../../../core/widgets/widget_card.dart';
import '../../../../core/widgets/widget_webview.dart';
import '../../../../routes/general_path.dart';
import '../../order/view/filter_order_screen.dart';
import '../controller/group_order_controller.dart';
import 'group_order_details_screen.dart';

class GroupRestOrderScreen extends StatefulWidget {
  int orderType;

  GroupRestOrderScreen({
    required this.orderType,
  });

  @override
  _GroupRestOrderScreenState createState() =>
      _GroupRestOrderScreenState(orderType);
}

class _GroupRestOrderScreenState extends State<GroupRestOrderScreen> {
  final GroupRestOrderController _groupRestOrderController =
      Get.put(GroupRestOrderController());
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());
  bool isChecked = true;
  String searchString = "";
  dynamic startDate = "", endDate = "", orderTypeData = "";
  int orderType = 1;
  double fontSize = 13.0;
  List orderStatusType = [];

  // String createdDate = "", orderPlacedDate = "";
  List statusList = [];
  Map<String, dynamic> receivedData = {};

  _GroupRestOrderScreenState(
    int orderType,
  ) {
    this.orderType = orderType;
  }

  checkOrderStatus() async {
    setState(() {
      _groupRestOrderController.isLoaderVisible = true;
    });
    if (orderType == 1) {
      List filterList = [1, 2, 3, 4, 5];
      orderStatusType = filterList;
    } else if (orderType == 2) {
      orderStatusType.add(6);
    } else {
      orderStatusType.add(7);
    }

    await _groupRestOrderController.callRestGetOrderAPI(
      filterType: orderStatusType,
      searchString: searchString,
      startDateSearch: startDate,
      endDateSearch: endDate,
      orderType: orderTypeData,
    );
  }

  checkOrderType(bool orderType) {
    if (orderType == true) {
      statusList = [
        selectOrderStatus,
        orderReceive,
        beingPrepare,
        ready,
        delivered,
        canceled,
      ];
    } else {
      statusList = [
        selectOrderStatus,
        orderReceive,
        beingPrepare,
        readyPickup,
        picked,
        canceled,
      ];
    }

    // debugPrint('statusList : ${statusList.toString()}');
  }

  @override
  void initState() {
    // debugPrint('StatusList: ${statusList[0]}');
    debugPrint('Group Init Order Type : $orderType');
    if (_networkManager.connectionType != 0) {
      debugPrint('Connection Type: ${_networkManager.connectionType}');
      checkOrderStatus();
    }
    super.initState();
  }

  callChangeOrderStatus({required String menuId, required int statusId}) async {
    await _groupRestOrderController.changeOrderStatusAPI(
        menuId: menuId, status: statusId);
    if (_groupRestOrderController.metaModel.meta?.status == true) {
      checkOrderStatus();
    }
  }

  /* String parseTimeStampReport(int created) {
    var date = DateTime.fromMicrosecondsSinceEpoch(created * 1000);
    var d12 = formatterDateTime.format(date);
    createdDate = d12;
    debugPrint('CreatedDAte: $createdDate,');
    return d12;
  }

  String parseTimeStampOrderPlaced(int orderPlaced) {
    var date2 = DateTime.fromMicrosecondsSinceEpoch(orderPlaced * 1000);
    var d2 = formatterDateTime.format(date2);
    orderPlacedDate = d2;
    debugPrint('OrderPlacedDate: $orderPlacedDate');
    return d2;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context,
          orderType == 1
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
                                  if (value.isEmpty) {
                                    searchString = value;
                                    checkOrderStatus();
                                  }
                                },
                               /* onEditingComplete: (){
                                  debugPrint("onEditingComplete");
                                  searchString = searchEditingCtrl.text;
                                  checkOrderStatus();
                                },*/
                                onFieldSubmitted: (value) {
                                  debugPrint("onFieldSubmitted");
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
                  GetBuilder<GroupRestOrderController>(builder: (logic) {
                    return Expanded(
                      child: logic.isLoaderVisible
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Color(ORANGE),
                            ))
                          : logic.orderStatus == 0
                              ? Center(
                                  child: WidgetText.widgetPoppinsMediumText(
                                      'No Order Found',
                                      Color(BLACK2),
                                      fontSize))
                              : Container(
                                  height: 210,
                                  width: double.infinity,
                                  child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: logic.orderStatus,
                                      itemBuilder: (context, index) {
                                        debugPrint(
                                            'OrderStatus screen len: ${logic.orderStatus}');
                                        debugPrint(
                                            'OrderStatus logic.getFilterOrderModel[index].orderType: ${logic.getFilterOrderModel[index].orderType}');

                                        if (logic.getFilterOrderModel[index]
                                                .orderType ==
                                            'DELIVERY') {
                                          checkOrderType(true);
                                        } else {
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
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            padding: EdgeInsets.all(15),
                                            width: 280,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                            serialNo,
                                                            Color(GREY3),
                                                            fontSize),
                                                    WidgetText
                                                        .widgetPoppinsMediumOverflowText(
                                                            "${index + 1}",
                                                            Color(BLACK2),
                                                            fontSize),
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
                                                                WidgetText
                                                                    .widgetPoppinsRegularText(
                                                                        custId,
                                                                        Color(
                                                                            GREY3),
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
                                                                  Color(BLACK2),
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
                                                                  Color(ORANGE),
                                                                  18),
                                                              WidgetText
                                                                  .widgetPoppinsMediumOverflowText(
                                                                      total,
                                                                      Color(
                                                                          GREY3),
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
                                                              Color(GREY3),
                                                              fontSize),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      WidgetText
                                                          .widgetPoppinsMediumOverflowText(
                                                              logic
                                                                  .getFilterOrderModel[
                                                                      index]
                                                                  .groupOrderID,
                                                              Color(BLACK2),
                                                              fontSize),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      WidgetText
                                                          .widgetPoppinsRegularText(
                                                              orderPlaced,
                                                              Color(GREY3),
                                                              fontSize),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      WidgetText.widgetPoppinsMediumOverflowText(
                                                          logic
                                                              .getFilterOrderModel[
                                                                  index]
                                                              .parseCreatedDate,
                                                          Color(BLACK2),
                                                          fontSize),

                                                      // logic.getFilterOrderModel[index].parseDeliveryDate != 0 ? Container():
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      // logic.getFilterOrderModel[index].parseDeliveryDate != 0 ? Container():
                                                      orderType == 1
                                                          ? logic
                                                                      .getFilterOrderModel[
                                                                          index]
                                                                      .orderType ==
                                                                  'DELIVERY'
                                                              ? WidgetText
                                                                  .widgetPoppinsRegularText(
                                                                  expectedDelivery,
                                                                  Color(GREY3),
                                                                  fontSize,
                                                                )
                                                              : WidgetText
                                                                  .widgetPoppinsRegularText(
                                                                  expectedCompletion,
                                                                  Color(GREY3),
                                                                  fontSize,
                                                                )
                                                          : orderType == 2
                                                              ? WidgetText
                                                                  .widgetPoppinsRegularText(
                                                                  orderDelivered,
                                                                  Color(GREY3),
                                                                  fontSize,
                                                                )
                                                              : WidgetText
                                                                  .widgetPoppinsRegularText(
                                                                  orderCanceled,
                                                                  Color(GREY3),
                                                                  fontSize,
                                                                ),

                                                      // logic.getFilterOrderModel[index].parseDeliveryDate != 0 ? Container():
                                                      SizedBox(
                                                        height: 8,
                                                      ),

                                                      // logic.getFilterOrderModel[index].parseDeliveryDate != 0 ? Container():
                                                      logic
                                                                  .getFilterOrderModel[
                                                                      index]
                                                                  .timeSlot
                                                                  .isEmpty &&
                                                              logic
                                                                      .getFilterOrderModel[
                                                                          index]
                                                                      .parseDeliveryDate ==
                                                                  0
                                                          ? Container()
                                                          : WidgetText
                                                              .widgetPoppinsMediumOverflowText(
                                                                  logic
                                                                          .getFilterOrderModel[
                                                                              index]
                                                                          .timeSlot
                                                                          .isEmpty
                                                                      ? (logic.getFilterOrderModel[index].parseDeliveryDate ??
                                                                          "-")
                                                                      : logic.getFilterOrderModel[index].parseDeliveryDate
                                                                              .toString()
                                                                              .isEmpty
                                                                          ? logic
                                                                              .getFilterOrderModel[
                                                                                  index]
                                                                              .timeSlot
                                                                          : (logic.getFilterOrderModel[index].parseDeliveryDate.toString() +
                                                                              ",\n" +
                                                                              logic.getFilterOrderModel[index].timeSlot),
                                                                  Color(BLACK2),
                                                                  fontSize,
                                                                  maxline: 2),
                                                      SizedBox(
                                                        height: 15,
                                                      ),

                                                      // orderType
                                                      WidgetText
                                                          .widgetPoppinsRegularText(
                                                              orderTypeTitle,
                                                              Color(GREY3),
                                                              fontSize),
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      WidgetText
                                                          .widgetPoppinsMediumOverflowText(
                                                              logic
                                                                  .getFilterOrderModel[
                                                                      index]
                                                                  .orderType,
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
                                                                elevation: 5.0,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.0),
                                                                ),
                                                                shadowColor:
                                                                    Color(
                                                                        BLACK2),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        WHITE),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.0),
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
                                                                      visible:
                                                                          true,
                                                                      child: Image
                                                                          .asset(
                                                                        ic_down_arrow,
                                                                        height:
                                                                            10,
                                                                        width:
                                                                            20,
                                                                        color: Color(
                                                                            DARKGREY),
                                                                      ),
                                                                    ),
                                                                    isExpanded:
                                                                        true,
                                                                    value: logic
                                                                            .getFilterOrderModel[
                                                                                index]
                                                                            .selectedOrderStatus
                                                                            .toString()
                                                                            .isEmpty
                                                                        ? selectOrderStatus
                                                                        : logic
                                                                            .getFilterOrderModel[index]
                                                                            .selectedOrderStatus
                                                                            .toString(),
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
                                                                      setState(
                                                                          () {
                                                                        debugPrint(
                                                                            "Check   ${logic.getFilterOrderModel[index].selectedOrderStatus}");
                                                                        value.toString().isNotEmpty
                                                                            ? logic.getFilterOrderModel[index].setSelectedStatus =
                                                                                value.toString()
                                                                            : logic.getFilterOrderModel[index].selectedOrderStatus = "";
                                                                        if (logic.getFilterOrderModel[index].selectedOrderStatus !=
                                                                            selectOrderStatus) {
                                                                          var statusData = getOrderId(logic
                                                                              .getFilterOrderModel[index]
                                                                              .selectedOrderStatus);
                                                                          callChangeOrderStatus(
                                                                              menuId: logic.getFilterOrderModel[index].groupOrderId.toString(),
                                                                              statusId: statusData);
                                                                        }
                                                                        debugPrint(
                                                                            'selectStatus : ${logic.getFilterOrderModel[index].selectedOrderStatus}');
                                                                      });
                                                                    },
                                                                    items: statusList.map(
                                                                        (dynamic
                                                                            selectedValue) {
                                                                      return DropdownMenuItem<
                                                                          String>(
                                                                        child:
                                                                            Text(
                                                                          selectedValue
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(BLACK2),
                                                                            fontSize:
                                                                                fontSize,
                                                                            fontFamily:
                                                                                FontRoboto,
                                                                            fontWeight:
                                                                                RobotoRegular,
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
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: InkWell(
                                                              onTap: () {
                                                                onClickViewDetails(
                                                                    orderId: logic
                                                                        .getFilterOrderModel[
                                                                            index]
                                                                        .groupOrderId,
                                                                    sNo: index +
                                                                        1);
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Color(
                                                                      ORANGE),
                                                                  shape: BoxShape
                                                                      .rectangle,
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
                                                                    '$generateReceipt${GeneralPath.BASE_URI + GeneralPath.API_GROUP_INVOICE + logic.getFilterOrderModel[index].groupOrderId.toString()}');
                                                                Get.to(() =>
                                                                    WidgetWebview(
                                                                      url: GeneralPath.BASE_URI +
                                                                          GeneralPath
                                                                              .API_GROUP_INVOICE +
                                                                          logic
                                                                              .getFilterOrderModel[index]
                                                                              .groupOrderId
                                                                              .toString(), appbarName: viewReceipt,
                                                                    ));
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
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
                                                          onClickViewDetails(
                                                              orderId: logic
                                                                  .getFilterOrderModel[
                                                                      index]
                                                                  .groupOrderId,
                                                              sNo: index + 1);
                                                        },
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              3.5,
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 10, 0, 10),
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
                                                          alignment:
                                                              Alignment.center,
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

  onClickViewDetails({required String orderId, required int sNo}) {
    Get.to(() => GORestDetailsScreen(
          orderStatus: orderType,
          orderId: orderId,
          serialNo: sNo,
        ));
  }

  onClickExport() {
    String filaname = newOrders;
    if( orderType == 1){
      filaname = newOrders;
    }else  if( orderType == 2){
      filaname = completedOrders;
    }else {
      filaname = canceledOrders;
    }

    _groupRestOrderController.createExcel(filaname);
  }

  onClickFilter() async {
    final result = await Get.to(() => FilterOrdersScreen(
          orderType: widget.orderType,
        ));

    // Handle the result from the second screen
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        receivedData = result;
        debugPrint("receivedData=======> $receivedData");
        debugPrint(
            "receivedData selectOrderType=======> ${receivedData['selectOrderType']}");
        startDate = receivedData["startDateSearch"];
        endDate = receivedData["endDateSearch"];
        orderTypeData = receivedData["selectOrderType"];
        searchString = receivedData["searchKey"];
      });
      checkOrderStatus();
    }
  }
}

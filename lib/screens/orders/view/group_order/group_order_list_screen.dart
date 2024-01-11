import 'package:choosifoodi/screens/orders/view/group_order/track_group_order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../core/utils/app_color_utils.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_font_utils.dart';
import '../../../../core/utils/app_images_utils.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import '../../../../core/widgets/widget_button.dart';
import '../../../../core/widgets/widget_card.dart';
import '../../../../core/widgets/widget_text.dart';
import '../../../restaurants_panel/order/view/filter_order_screen.dart';
import '../../controller/group_order/group_list_controller.dart';
import 'group_order_detail_screen.dart';

class GroupOrderListScreen extends StatefulWidget {
  int orderStatus = 1; //1->Upcoming, 2->Completed, 3->Canceled
  GroupOrderListScreen({
    Key? key,
    required this.orderStatus,
  }) : super(key: key);

  @override
  State<GroupOrderListScreen> createState() =>
      _GroupOrderListScreenState(orderStatus);
}

class _GroupOrderListScreenState extends State<GroupOrderListScreen> {
  final GroupOrderListController groupListController =
      Get.put(GroupOrderListController());
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());
  Map<String, dynamic> receivedData = {};
  String searchString = "";
  dynamic startDate = "", endDate = "", orderTypeData = "";

  // String createdDate = "";
  int orderStatus = 1;
  List orderStatusType = [];
  String? _selectReason = "--- Select Reason ---";
  dynamic orderDate = "";
  DateTime selectedDate = DateTime.now();
  double fontSize = 13.0;

  List reasonList = [
    '--- Select Reason ---',
    'Wait time too long',
    'Error in order',
    'Does not align with my Foodi Goal',
    'Too expensive',
    'Other'
  ];

  _GroupOrderListScreenState(int orderStatus) {
    this.orderStatus = orderStatus;
  }

  checkOrderStatus() async {
    if (orderStatus == 1) {
      List filterList = [1, 2, 3, 4, 5];
      orderStatusType = filterList;
      print('orderStatusType: $orderStatusType');
      orderDate = "$expectedDelivery: ";
    } else if (orderStatus == 2) {
      orderStatusType.add(6);
      print('orderStatusType: $orderStatusType');
      orderDate = "$dateDelivered: ";
    } else {
      orderStatusType.add(7);
      print('orderStatusType: $orderStatusType');
      orderDate = "$canceled: ";
    }


    await groupListController.callGroupOrderListAPI(
      filterType: orderStatusType,
      searchString: searchString,
      startDateSearch: startDate,
      endDateSearch: endDate,
      orderType: orderTypeData,
    );
  }

  @override
  void initState() {
    if (_networkManager.connectionType != 0) {
      print('Connection Type: ${_networkManager.connectionType}');
      print('OrderStatus: $orderStatus');
      checkOrderStatus();
      // groupListController.callGroupOrderListAPI();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(WHITE),
        appBar: WidgetAppbar.simpleAppBar(
            context,
            orderStatus == 1
                ? "Upcoming Group Orders"
                : orderStatus == 2
                    ? "Completed Group Orders"
                    : "Canceled Group Orders",
            true),
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
                                  onFieldSubmitted: (value) {
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
                    GetBuilder<GroupOrderListController>(builder: (logic) {
                      return Expanded(child: logic.isGroupListVisible
                          ? Center(
                          child: CircularProgressIndicator(
                            color: Color(ORANGE),
                          ))
                          : Container(
                        decoration: BoxDecoration(
                          color: Color(WHITE),
                        ),
                        padding: EdgeInsets.all(15),
                        width: double.infinity,
                        child: logic.orderStatus == 0
                            ? Center(
                            child: WidgetText.widgetPoppinsMediumText(
                                noOrdersFound, Color(BLACK), 16))
                            : ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: logic.orderStatus,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0, 15, 0, 0),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Color(WHITE),
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                        color: Color(ORANGE),
                                        width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      orderStatus == 1
                                          ? Row(
                                        children: [
                                          WidgetText
                                              .widgetPoppinsRegularText(
                                            'Total No. of participants: ',
                                            Color(SUBTEXT2),
                                            14,
                                          ),
                                          WidgetText
                                              .widgetPoppinsRegularText(
                                            logic
                                                .getFilterGOModel[
                                            index]
                                                .participants
                                                .toString(),
                                            Color(BLACK),
                                            14,
                                          ),
                                        ],
                                      )
                                          : Row(
                                        children: [
                                          WidgetText
                                              .widgetPoppinsRegularText(
                                            'Order ID: ',
                                            Color(SUBTEXT2),
                                            14,
                                          ),
                                          WidgetText
                                              .widgetPoppinsRegularText(
                                            logic
                                                .getFilterGOModel[
                                            index]
                                                .groupOrderID
                                                .toString(),
                                            Color(BLACK2),
                                            14,
                                          ),
                                        ],
                                      ),
                                      WidgetText
                                          .widgetPoppinsMediumText(
                                        logic.getFilterGOModel[index]
                                            .groupData.groupName
                                            .toString(),
                                        Color(ORANGE),
                                        14,
                                      ),
                                      // SizedBox(height: 10,),
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 80,
                                            height: 70,
                                            child: ClipRRect(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    10.0),
                                                child: imageFromNetworkCache(
                                                    logic
                                                        .getFilterGOModel[
                                                    index]
                                                        .restaurantData
                                                        .restaurantImg
                                                        .first
                                                        .toString(),
                                                    height: 70)),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                logic
                                                    .getFilterGOModel[
                                                index]
                                                    .productDetails[
                                                0]
                                                    .cartMenu[0]
                                                    .dishName
                                                    .isEmpty
                                                    ? Text('')
                                                    : WidgetText
                                                    .widgetPoppinsMediumText(
                                                  logic
                                                      .getFilterGOModel[
                                                  index]
                                                      .productDetails[
                                                  0]
                                                      .cartMenu[
                                                  0]
                                                      .dishName
                                                      .toString(),
                                                  Color(BLACK),
                                                  16,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                      "Total: ",
                                                      Color(SUBTEXT),
                                                      10,
                                                    ),
                                                    logic
                                                        .getFilterGOModel[
                                                    index]
                                                        .total ==
                                                        null
                                                        ? Text('')
                                                        : WidgetText
                                                        .widgetPoppinsMediumText(
                                                      "\$" +
                                                          (logic
                                                              .getFilterGOModel[index]
                                                              .total
                                                              .toString()),
                                                      // (logic.getFilterGOModel[index].total.toStringAsFixed(2) ?? 0.0),
                                                      Color(
                                                          BLACK),
                                                      10,
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    orderStatus == 1
                                                        ? WidgetText
                                                        .widgetPoppinsRegularText(
                                                      logic.getFilterGOModel[index].orderType ==
                                                          "DELIVERY"
                                                          ? "$expectedDelivery: "
                                                          : "$expectedCompletion: ",
                                                      Color(
                                                          SUBTEXT),
                                                      10,
                                                    )
                                                        : WidgetText
                                                        .widgetPoppinsRegularText(
                                                      orderDate,
                                                      Color(
                                                          SUBTEXT),
                                                      10,
                                                    ),
                                                    Expanded(
                                                      child: WidgetText
                                                          .widgetPoppinsMediumText(
                                                        logic.getFilterGOModel[index]
                                                            .parsedDate ??
                                                            "",
                                                        Color(BLACK),
                                                        10,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding:
                                              EdgeInsets.fromLTRB(
                                                  0, 15, 0, 15),
                                              decoration:
                                              BoxDecoration(
                                                color:
                                                Color(0xffF9F7F8),
                                                shape: BoxShape
                                                    .rectangle,
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius
                                                        .circular(
                                                        10)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  WidgetText
                                                      .widgetPoppinsRegularText(
                                                    "Calories",
                                                    Color(BLACK),
                                                    13,
                                                  ),
                                                  WidgetText
                                                      .widgetPoppinsMediumText(
                                                    logic
                                                        .getFilterGOModel[
                                                    index]
                                                        .caloriesTotal
                                                        .toString(),
                                                    Color(SUBTEXT),
                                                    14,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding:
                                              EdgeInsets.fromLTRB(
                                                  0, 15, 0, 15),
                                              decoration:
                                              BoxDecoration(
                                                color:
                                                Color(0xffF9F7F8),
                                                shape: BoxShape
                                                    .rectangle,
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius
                                                        .circular(
                                                        10)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  WidgetText
                                                      .widgetPoppinsRegularText(
                                                    "Fat",
                                                    Color(BLACK),
                                                    13,
                                                  ),
                                                  WidgetText
                                                      .widgetPoppinsMediumText(
                                                    logic
                                                        .getFilterGOModel[
                                                    index]
                                                        .fatTotal
                                                        .toString() +
                                                        "g",
                                                    Color(SUBTEXT),
                                                    14,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding:
                                              EdgeInsets.fromLTRB(
                                                  0, 15, 0, 15),
                                              decoration:
                                              BoxDecoration(
                                                color:
                                                Color(0xffF9F7F8),
                                                shape: BoxShape
                                                    .rectangle,
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius
                                                        .circular(
                                                        10)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  WidgetText
                                                      .widgetPoppinsRegularText(
                                                    "Carbs",
                                                    Color(BLACK),
                                                    13,
                                                  ),
                                                  WidgetText
                                                      .widgetPoppinsMediumText(
                                                    logic
                                                        .getFilterGOModel[
                                                    index]
                                                        .carbsTotal
                                                        .toString() +
                                                        "g",
                                                    Color(SUBTEXT),
                                                    14,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding:
                                              EdgeInsets.fromLTRB(
                                                  0, 15, 0, 15),
                                              decoration:
                                              BoxDecoration(
                                                color:
                                                Color(0xffF9F7F8),
                                                shape: BoxShape
                                                    .rectangle,
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius
                                                        .circular(
                                                        10)),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  WidgetText
                                                      .widgetPoppinsRegularText(
                                                    "Protein",
                                                    Color(BLACK),
                                                    13,
                                                  ),
                                                  WidgetText
                                                      .widgetPoppinsMediumText(
                                                    logic
                                                        .getFilterGOModel[
                                                    index]
                                                        .proteinTotal
                                                        .toString() +
                                                        "g",
                                                    Color(SUBTEXT),
                                                    14,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),

                                      orderStatus == 1
                                          ? Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                // print('GroupOrderId: ${logic.getFilterGOModel[index].groupOrderId}');
                                                Get.to(() =>
                                                    GroupOrderDetailsScreen(
                                                      orderId: logic
                                                          .getFilterGOModel[
                                                      index]
                                                          .groupOrderId
                                                          .toString()
                                                          .toString(),
                                                      orderStatus:
                                                      0,
                                                    ));
                                              },
                                              child: Container(
                                                padding:
                                                EdgeInsets
                                                    .fromLTRB(
                                                    0,
                                                    15,
                                                    0,
                                                    15),
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
                                                  "View details",
                                                  Color(WHITE),
                                                  13,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () async {
                                                await Get.to(() =>
                                                    TrackGroupOrderScreen(
                                                      orderId: logic
                                                          .getFilterGOModel[
                                                      index]
                                                          .groupOrderId
                                                          .toString()
                                                          .toString(),
                                                      isGroupOrder:
                                                      true,
                                                    ));
                                                setState(() {
                                                  logic
                                                      .getFilterGOModel
                                                      .clear();
                                                  logic.isGroupListVisible =
                                                  true;
                                                  checkOrderStatus();
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                EdgeInsets
                                                    .fromLTRB(
                                                    0,
                                                    15,
                                                    0,
                                                    15),
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
                                                  "Track",
                                                  Color(ORANGE),
                                                  13,
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
                                                if (logic
                                                    .getFilterGOModel[
                                                index]
                                                    .groupOrderId !=
                                                    null) {
                                                  cancelOrderDialog(
                                                      context,
                                                      logic
                                                          .getFilterGOModel[
                                                      index]
                                                          .groupOrderId
                                                          .toString());
                                                } else {
                                                  showToastMessage(
                                                      "Order Id Not Found");
                                                }
                                              },
                                              child: Container(
                                                padding:
                                                EdgeInsets
                                                    .fromLTRB(
                                                    0,
                                                    15,
                                                    0,
                                                    15),
                                                decoration:
                                                BoxDecoration(
                                                  color: Color(
                                                      RED),
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
                                                  "Cancel",
                                                  Color(WHITE),
                                                  13,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                          : orderStatus == 2
                                          ? Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    GroupOrderDetailsScreen(
                                                      orderId: logic
                                                          .getFilterGOModel[index]
                                                          .groupOrderId
                                                          .toString()
                                                          .toString(),
                                                      orderStatus:
                                                      1,
                                                    ));
                                              },
                                              child:
                                              Container(
                                                padding: EdgeInsets
                                                    .fromLTRB(
                                                    0,
                                                    15,
                                                    0,
                                                    15),
                                                decoration:
                                                BoxDecoration(
                                                  color: Color(
                                                      ORANGE),
                                                  shape: BoxShape
                                                      .rectangle,
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(7)),
                                                ),
                                                alignment:
                                                Alignment
                                                    .center,
                                                child: WidgetText
                                                    .widgetPoppinsMediumText(
                                                  "View details",
                                                  Color(
                                                      WHITE),
                                                  13,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child:
                                            Container(),
                                          ),
                                          Expanded(
                                            child:
                                            Container(),
                                          ),
                                        ],
                                      )
                                          : Container(),
                                      orderStatus == 3
                                          ? Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(() =>
                                                    GroupOrderDetailsScreen(
                                                      orderId: logic
                                                          .getFilterGOModel[
                                                      index]
                                                          .groupOrderId
                                                          .toString()
                                                          .toString(),
                                                      orderStatus:
                                                      2,
                                                    ));
                                              },
                                              child: Container(
                                                padding:
                                                EdgeInsets
                                                    .fromLTRB(
                                                    0,
                                                    15,
                                                    0,
                                                    15),
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
                                                  "View details",
                                                  Color(WHITE),
                                                  13,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Container(),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Container(),
                                          ),
                                        ],
                                      )
                                          : Container(),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ));
                            }),
                      ));
                    }),
                  ],
                );
        })));
  }

  void viewReOrderDialog(BuildContext mContext,
      {String? cartRestaurant, String? menuRestaurant}) {
    showDialog(
        context: mContext,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: WidgetText.widgetPoppinsBoldText(
                replaceCart,
                Color(BLACK),
                16,
              ),
              content: WidgetText.widgetPoppinsMediumText(
                "Your cart contains dishes from $cartRestaurant. Do You want to discard the selection and add dishes from $menuRestaurant?",
                Color(BLACK),
                14,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    print('Yes');
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ],
            );
          });
        });
  }

  void cancelOrderDialog(BuildContext mContext, String groupOrderId) {
    showDialog(
        context: mContext,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              //this right here
              child: Container(
                height: 270,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Card(
                          elevation: 5,
                          color: Color(WHITE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Image.asset(
                              ic_cross,
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: WidgetText.widgetPoppinsMediumText(
                        "Cancel your order",
                        Color(BLACK),
                        18,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    WidgetText.widgetPoppinsRegularText(
                      "Reason for Cancelation",
                      Color(BLACK),
                      14,
                    ),
                    Card(
                      color: Color(WHITE),
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      shadowColor: Color(BLACK),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: DropdownButton(
                          underline: Container(),
                          borderRadius: BorderRadius.circular(10),
                          icon: Visibility(
                            visible: true,
                            child: Image.asset(
                              ic_down_arrow,
                              height: 10,
                              width: 10,
                              color: Color(BLACK),
                            ),
                          ),
                          isExpanded: true,
                          value: _selectReason,
                          // _selectReason == "--- Select Reason ---"
                          //     ? reasonList[0].toString()
                          //     : _selectReason,
                          hint: Text("--- Select Reason ---"),
                          style: TextStyle(
                            color: Color(BLACK),
                            fontSize: 16,
                            fontFamily: FontPoppins,
                            fontWeight: PoppinsRegular,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _selectReason = value.toString();
                            });
                            print('selectStatus : ${_selectReason}');
                          },
                          items: reasonList.map((dynamic value) {
                            return DropdownMenuItem<String>(
                              child: Text(
                                value,
                                style: TextStyle(
                                  color:
                                      _selectReason == "--- Select Reason ---"
                                          ? Color(HINTCOLOR)
                                          : Color(BLACK),
                                  fontSize: 14,
                                  fontFamily: FontRoboto,
                                  fontWeight: RobotoRegular,
                                ),
                              ),
                              value: value,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    groupListController.isOrderCanceledLoader == false
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Color(ORANGE),
                            ),
                          )
                        : WidgetButton.widgetDefaultButton("Submit", () async {
                            if (_selectReason != "--- Select Reason ---") {
                              setState(() {
                                groupListController.isOrderCanceledLoader =
                                    false;
                              });

                              await groupListController.cancelGroupOrderApi(
                                groupOrderId: groupOrderId,
                                reason: _selectReason.toString(),
                              );
                              if (groupListController.isOrderCanceledLoader ==
                                  false) {
                                checkOrderStatus();
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }
                            } else {
                              showToastMessage("Please Select Reason");
                            }
                          })
                  ],
                ),
              ),
            );
          });
        });
  }

  onClickFilter() async {
    final result = await Get.to(() => FilterOrdersScreen(
      orderType: widget.orderStatus,
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

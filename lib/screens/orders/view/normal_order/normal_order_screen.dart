import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/cart/view/cart_screen.dart';
import 'package:choosifoodi/screens/orders/view/normal_order/normal_order_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_font_utils.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import '../../../../core/widgets/widget_button.dart';
import '../../../../core/widgets/widget_card.dart';
import '../../../restaurants_panel/order/view/filter_order_screen.dart';
import '../../controller/normal_order/menu_order_controller.dart';
import 'track_order_screen.dart';

class NormalOrderScreen extends StatefulWidget {
  int orderStatus = 1; //1->Upcoming, 2->Completed, 3->Canceled

  NormalOrderScreen({
    Key? key,
    required this.orderStatus,
  }) : super(key: key);

  @override
  _NormalOrderScreenState createState() => _NormalOrderScreenState(orderStatus);
}

class _NormalOrderScreenState extends State<NormalOrderScreen> {
  final MenuOrderController menuOrderController =
      Get.put(MenuOrderController());
  int orderStatus = 1;
  dynamic orderDate = "";
  String createdDate = "";
  String? _selectReason = "--- Select Reason ---";
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());
  List orderStatusType = [];
  double fontSize = 13.0;
  Map<String, dynamic> receivedData = {};
  String searchString = "";
  dynamic startDate = "", endDate = "", orderTypeData = "";

  _NormalOrderScreenState(
    int orderStatus,
  ) {
    this.orderStatus = orderStatus;
  }

  List reasonList = [
    '--- Select Reason ---',
    'Wait time too long',
    'Error in order',
    'Does not align with my Foodi Goal',
    'Too expensive',
    'Other'
  ];

  checkOrderStatus() async {
    if (orderStatus == 1) {
      List filterList = [1, 2, 3, 4, 5];
      orderStatusType = filterList;
      print('orderStatusType: $orderStatusType');
      // menuOrderController.isLoaderVisible = true;
      // await menuOrderController.callGetOrderAPI(
      //     filterType: orderStatusType, orderStatusScreen: 1);
      orderDate = "$expectedDelivery: ";
    } else if (orderStatus == 2) {
      orderStatusType.add(6);
      print('orderStatusType: $orderStatusType');
      // menuOrderController.isLoaderVisible = true;
      // await menuOrderController.callGetOrderAPI(
      //     filterType: orderStatusType, orderStatusScreen: 2);
      orderDate = "$dateDelivered: ";
    } else {
      orderStatusType.add(7);
      print('orderStatusType: $orderStatusType');
      // menuOrderController.isLoaderVisible = true;
      // await menuOrderController.callGetOrderAPI(
      //     filterType: orderStatusType, orderStatusScreen: 3);
      orderDate = "$canceled: ";
    }


    await menuOrderController.callGetOrderAPI(
      filterType: orderStatusType,
      searchString: searchString,
      startDateSearch: startDate,
      endDateSearch: endDate,
      orderType: orderTypeData,
    );
  }

  @override
  void initState() {
    print('Init Order Type : $orderStatus');
    if (_networkManager.connectionType != 0) {
      print('Connection Type: ${_networkManager.connectionType}');
      menuOrderController.callGetCartAPI();
      checkOrderStatus();
    }
    super.initState();
  }

  void viewReOrderDialog(BuildContext mContext,
      {String? cartRestaurant, String? menuRestaurant, String? menuOrderId}) {
    final MenuOrderController menuOrderController =
        Get.put(MenuOrderController());
    showDialog(
        context: mContext,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            setState(() {
              menuOrderController.isReOrderLoaded = false;
            });
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
                menuOrderController.isReOrderLoaded == false
                    ? TextButton(
                        onPressed: () async {
                          print('Yes');
                          setState(() {
                            menuOrderController.isReOrderLoaded =
                                !menuOrderController.isReOrderLoaded;
                            print(
                                'start loader: ${menuOrderController.isReOrderLoaded}');
                          });
                          await menuOrderController.postReOrderApi(
                              menuOrderId: menuOrderId.toString());
                          if (menuOrderController
                                  .getQtyUpdateModel.meta?.status ==
                              true) {
                            Navigator.of(context).pop(false);
                            Get.to(() => CartScreen());
                          }
                        },
                        child: Text(
                          'Yes',
                          style: TextStyle(color: Colors.orange),
                        ),
                      )
                    : CircularProgressIndicator(
                        color: Color(ORANGE),
                      ),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(
          context,
          orderStatus == 1
              ? upcomingOrders
              : orderStatus == 2
                  ? completedOrders
                  : canceledOrders,
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
                  GetBuilder<MenuOrderController>(builder: (logic) {
                    return Expanded(child: logic.isLoaderVisible
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
                      child: logic.orderCount == 0
                          ? Center(
                          child: Container(
                              color: Color(WHITE),
                              child:
                              WidgetText.widgetPoppinsMediumText(
                                  noOrdersFound,
                                  Color(BLACK),
                                  16)))
                          : ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: logic.orderCount,
                          itemBuilder: (context, index) {
                            return
                              logic.getFilterOrderModel.isEmpty ?Center(
                                  child: Container(
                                      color: Color(WHITE),
                                      child:
                                      WidgetText.widgetPoppinsMediumText(
                                          noOrdersFound,
                                          Color(BLACK),
                                          16)))
                                  :
                              Container(
                              margin:
                              EdgeInsets.fromLTRB(0, 15, 0, 0),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Color(WHITE),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                    color: Color(ORANGE), width: 1),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      WidgetText
                                          .widgetPoppinsRegularText(
                                        "Order ID: ",
                                        Color(SUBTEXT),
                                        12,
                                      ),
                                      WidgetText
                                          .widgetPoppinsMediumText(
                                        logic.getFilterOrderModel[index].menuOrderID.toString(),
                                        // "CF1645",
                                        Color(BLACK),
                                        12,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 70,
                                        child: logic
                                            .getFilterOrderModel[
                                        index]
                                            .restaurantData
                                            ?.restaurantImg
                                            ?.first ==
                                            null
                                            ? Image.asset(
                                          ic_no_image,
                                          fit: BoxFit.fill,
                                        )
                                            : ClipRRect(
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              10.0),
                                          child: Image.network(
                                            logic
                                                .getFilterOrderModel[
                                            index]
                                                .restaurantData
                                                ?.restaurantImg
                                                ?.first
                                                .toString() ??
                                                "",
                                            fit: BoxFit.fill,
                                            loadingBuilder:
                                                (BuildContext
                                            context,
                                                Widget
                                                child,
                                                ImageChunkEvent?
                                                loadingProgress) {
                                              if (loadingProgress ==
                                                  null)
                                                return child;
                                              return Center(
                                                child:
                                                CircularProgressIndicator(
                                                  color: Color(
                                                      ORANGE),
                                                  value: loadingProgress
                                                      .expectedTotalBytes !=
                                                      null
                                                      ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                      : null,
                                                ),
                                              );
                                            },
                                            errorBuilder:
                                                (context, error,
                                                stackTrace) {
                                              return Image
                                                  .asset(
                                                ic_no_image,
                                                fit:
                                                BoxFit.fill,
                                              );
                                            },
                                          ),
                                        ),
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
                                                .getFilterOrderModel[
                                            index]
                                                .productDetails?[
                                            0]
                                                .dishName ==
                                                null
                                                ? Text('')
                                                : WidgetText
                                                .widgetPoppinsMediumText(
                                              logic
                                                  .getFilterOrderModel[
                                              index]
                                                  .productDetails?[
                                              0]
                                                  .dishName
                                                  .toString() ??
                                                  "",
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
                                                    .getFilterOrderModel[
                                                index]
                                                    .total ==
                                                    0.0
                                                    ? Text('')
                                                    : WidgetText
                                                    .widgetPoppinsMediumText(
                                                  "\$" +
                                                      logic
                                                          .getFilterOrderModel[
                                                      index]
                                                          .total
                                                          .toString(),
                                                  Color(BLACK),
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
                                                  logic.getFilterOrderModel[index]
                                                      .orderType ==
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
                                                      .widgetPoppinsMediumOverflowText(
                                                      logic.getFilterOrderModel[index]
                                                          .parsedDate ??
                                                          "",
                                                      Color(BLACK),
                                                      10,
                                                      maxline: 2),
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
                                          decoration: BoxDecoration(
                                            color: Color(0xffF9F7F8),
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(
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
                                              // logic.getFilterOrderModel[index].productDetails?[0].calories == null
                                              logic
                                                  .getFilterOrderModel[
                                              index]
                                                  .caloriesTotal ==
                                                  null
                                                  ? Text("")
                                                  : WidgetText
                                                  .widgetPoppinsMediumText(
                                                // logic.getFilterOrderModel[index].productDetails![0].calories
                                                logic
                                                    .getFilterOrderModel[
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
                                          decoration: BoxDecoration(
                                            color: Color(0xffF9F7F8),
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(
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
                                              // logic.getFilterOrderModel[index].productDetails?[0].fat == null
                                              logic
                                                  .getFilterOrderModel[
                                              index]
                                                  .fatTotal ==
                                                  null
                                                  ? Text("")
                                                  : WidgetText
                                                  .widgetPoppinsMediumText(
                                                (logic.getFilterOrderModel[index]
                                                    .fatTotal)
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
                                          decoration: BoxDecoration(
                                            color: Color(0xffF9F7F8),
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(
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
                                              logic
                                                  .getFilterOrderModel[
                                              index]
                                                  .carbsTotal ==
                                                  null
                                                  ? Text("")
                                                  : WidgetText
                                                  .widgetPoppinsMediumText(
                                                (logic
                                                    .getFilterOrderModel[
                                                index]
                                                    .carbsTotal
                                                    .toString()) +
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
                                          decoration: BoxDecoration(
                                            color: Color(0xffF9F7F8),
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                            BorderRadius.all(
                                                Radius.circular(
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
                                              logic
                                                  .getFilterOrderModel[
                                              index]
                                                  .proteinTotal ==
                                                  null
                                                  ? Text("")
                                                  : WidgetText
                                                  .widgetPoppinsMediumText(
                                                (logic
                                                    .getFilterOrderModel[
                                                index]
                                                    .proteinTotal
                                                    .toString()) +
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
                                            debugPrint(
                                                'MenuOrderid: ${logic.getFilterOrderModel[index].menuOrderId}');
                                            Get.to(() =>
                                                NormalOrderDetailsScreen(
                                                  orderStatus:
                                                  orderStatus,
                                                  orderId: logic
                                                      .getFilterOrderModel[
                                                  index]
                                                      .menuOrderId
                                                      .toString(),
                                                ));
                                          },
                                          child: Container(
                                            padding: EdgeInsets
                                                .fromLTRB(0, 15,
                                                0, 15),
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
                                            debugPrint(
                                                'OrderStatus: ${logic.getFilterOrderModel[index].orderStatus}');
                                            await Get.to(() =>
                                                TrackOrderScreen(
                                                  orderId: logic
                                                      .getFilterOrderModel[
                                                  index]
                                                      .menuOrderId
                                                      .toString(),
                                                  isNormalOrder:
                                                  true,
                                                ));
                                            Future.delayed(
                                                const Duration(
                                                    seconds: 1),
                                                    () {
                                                  setState(() {
                                                    menuOrderController
                                                        .getFilterOrderModel
                                                        .clear();
                                                    menuOrderController
                                                        .isLoaderVisible =
                                                    true;
                                                    checkOrderStatus();
                                                  });
                                                });
                                          },
                                          child: Container(
                                            padding: EdgeInsets
                                                .fromLTRB(0, 15,
                                                0, 15),
                                            decoration:
                                            BoxDecoration(
                                              color:
                                              Color(WHITE),
                                              shape: BoxShape
                                                  .rectangle,
                                              border: Border.all(
                                                  color: Color(
                                                      ORANGE),
                                                  width: 1),
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
                                                .getFilterOrderModel[
                                            index]
                                                .menuOrderId !=
                                                null) {
                                              cancelOrderDialog(
                                                  context,
                                                  logic
                                                      .getFilterOrderModel[
                                                  index]
                                                      .menuOrderId
                                                      .toString());
                                            } else {
                                              showToastMessage(
                                                  "Order Id Not Found");
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets
                                                .fromLTRB(0, 15,
                                                0, 15),
                                            decoration:
                                            BoxDecoration(
                                              color: Color(RED),
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
                                              "Cancel",
                                              Color(WHITE),
                                              13,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                      : Container(),
                                  orderStatus == 2
                                      ? Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Get.to(() =>
                                                NormalOrderDetailsScreen(
                                                  orderStatus:
                                                  orderStatus,
                                                  orderId: logic
                                                      .getFilterOrderModel[
                                                  index]
                                                      .menuOrderId
                                                      .toString(),
                                                ));
                                          },
                                          child: Container(
                                            padding: EdgeInsets
                                                .fromLTRB(0, 15,
                                                0, 15),
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
                                      logic
                                          .getFilterOrderModel[
                                      index]
                                          .restaurantData
                                          ?.isAddToReOrder ==
                                          false
                                          ? Expanded(
                                        child: InkWell(
                                          onTap:
                                              () async {
                                            if (logic
                                                .cartFound ==
                                                true) {
                                              print(
                                                  'Tap on yes to Call ReOrder api');
                                              viewReOrderDialog(
                                                  context,
                                                  cartRestaurant:
                                                  logic
                                                      .cartRestaurantName,
                                                  menuRestaurant: logic
                                                      .getFilterOrderModel[
                                                  index]
                                                      .restaurantData
                                                      ?.restaurantName,
                                                  menuOrderId: logic
                                                      .getFilterOrderModel[index]
                                                      .menuOrderId
                                                      .toString());
                                            } else {
                                              await logic.postReOrderApi(
                                                  menuOrderId: logic
                                                      .getFilterOrderModel[index]
                                                      .menuOrderId
                                                      .toString());
                                              print(
                                                  'Call ReOrder api');
                                              Get.to(() =>
                                                  CartScreen());
                                            }
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
                                                  WHITE),
                                              shape: BoxShape
                                                  .rectangle,
                                              border: Border.all(
                                                  color: Color(
                                                      ORANGE),
                                                  width:
                                                  1),
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(7)),
                                            ),
                                            alignment:
                                            Alignment
                                                .center,
                                            child: WidgetText
                                                .widgetPoppinsMediumText(
                                              "Reorder",
                                              Color(
                                                  ORANGE),
                                              13,
                                            ),
                                          ),
                                        ),
                                      )
                                          : Center(
                                        child:
                                        CircularProgressIndicator(
                                          color: Color(
                                              ORANGE),
                                        ),
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
                                                NormalOrderDetailsScreen(
                                                  orderStatus:
                                                  orderStatus,
                                                  orderId: logic
                                                      .getFilterOrderModel[
                                                  index]
                                                      .menuOrderId
                                                      .toString(),
                                                ));
                                          },
                                          child: Container(
                                            padding: EdgeInsets
                                                .fromLTRB(0, 15,
                                                0, 15),
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
                                ],
                              ),
                            );
                          }),
                    ));
                  })
                ],
              );
      })),
    );
  }

  void cancelOrderDialog(BuildContext mContext, String menuOrderId) {
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
                    menuOrderController.isOrderCanceledLoader == false
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Color(ORANGE),
                            ),
                          )
                        : WidgetButton.widgetDefaultButton("Submit", () async {
                            if (_selectReason != "--- Select Reason ---") {
                              setState(() {
                                menuOrderController.isOrderCanceledLoader =
                                    false;
                              });

                              await menuOrderController.cancelOrderApi(
                                menuOrderId: menuOrderId,
                                reason: _selectReason.toString(),
                              );
                              if (menuOrderController.isOrderCanceledLoader ==
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

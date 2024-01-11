import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import '../../../../core/widgets/widget_card.dart';
import '../controller/go_rest_details_controller.dart';

class GORestDetailsScreen extends StatefulWidget {
  int serialNo;
  int orderStatus;
  String orderId = "";

  GORestDetailsScreen(
      {required this.serialNo,
      required this.orderStatus,
      required this.orderId});

  @override
  _OrderDetailsScreenState createState() =>
      _OrderDetailsScreenState(serialNo, orderStatus, orderId);
}

class _OrderDetailsScreenState extends State<GORestDetailsScreen> {
  int orderStatus = 1;
  int serialNo = 1;
  final GORestDetailsController _orderRestDetailsController = Get.put(GORestDetailsController());
  String orderId = "";
  int itemCountIndex = 0;
  double fontSize = 13.0;

  _OrderDetailsScreenState(int serialNo, int orderStatus, String orderId) {
    this.serialNo = serialNo;
    this.orderStatus = orderStatus;
    this.orderId = orderId;
  }

  @override
  void initState() {
    debugPrint('orderStatus: $orderStatus');
    _orderRestDetailsController.callViewOrderDetailsAPI(orderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context,
          "Order Details", true),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : GetBuilder<GORestDetailsController>(builder: (logic) {
                return logic.isViewOrderVisible
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Color(ORANGE),
                      ))
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Card(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              elevation: 5.0,
                              shadowColor: Color(BLACK2),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(WHITE),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: EdgeInsets.all(15),
                                // width: 280,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        WidgetText
                                            .widgetPoppinsRegularOverflowText(
                                          "Customer Name : ",
                                          Color(GREY3),
                                          fontSize,
                                        ),
                                        Expanded(
                                          child: WidgetText
                                              .widgetPoppinsMediumOverflowText(
                                                  logic.viewDetailsModel.data!
                                                          .userData.firstName +
                                                      " " +
                                                      logic
                                                          .viewDetailsModel
                                                          .data!
                                                          .userData
                                                          .lastName,
                                                  Color(BLACK2),
                                              fontSize),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          color: Color(WHITE),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                              color: Color(ORANGE), width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ListView.builder(
                                              physics: BouncingScrollPhysics(),
                                              itemCount: logic.viewDetailsModel
                                                  .data?.productDetails.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {


                                                return Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [

                                                    ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            BouncingScrollPhysics(),
                                                        itemCount: logic
                                                            .viewDetailsModel
                                                            .data
                                                            ?.productDetails[
                                                                index]
                                                            .cartMenu
                                                            .length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int cartIndex) {

                                                              itemCountIndex = logic.viewDetailsModel.data?.productDetails[index].cartMenu.length ?? 0;
                                                              // debugPrint('itemCount: $itemCountIndex');

                                                          return Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 4,
                                                                    child: ClipRRect(
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          10.0),
                                                                      child: Container(
                                                                        width: MediaQuery.of(context).size.width / 2.8,
                                                                        height: 120,
                                                                        child:
                                                                        imageFromNetworkCache(logic
                                                                            .viewDetailsModel
                                                                            .data
                                                                            ?.productDetails[index]
                                                                            .cartMenu[cartIndex]
                                                                            .menuImg
                                                                            .first
                                                                            .toString() ??
                                                                            "", height: 120),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 15,
                                                                  ),
                                                                  Expanded(
                                                                      flex: 6,
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              WidgetText
                                                                                  .widgetPoppinsRegularText(
                                                                                  "S.No.: ",
                                                                                  Color(
                                                                                      GREY3),
                                                                                  fontSize),
                                                                              WidgetText
                                                                                  .widgetPoppinsMediumText(
                                                                                  "$serialNo",
                                                                                  Color(
                                                                                      BLACK2),
                                                                                  fontSize),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height: 5,
                                                                          ),
                                                                          WidgetText.widgetPoppinsRegularText(
                                                                              "Dish Name",
                                                                              Color(GREY3),
                                                                              fontSize),
                                                                          WidgetText.widgetPoppinsMediumOverflowText(
                                                                            logic.viewDetailsModel.data?.productDetails[index].cartMenu[cartIndex].dishName ?? "",
                                                                            Color(BLACK2),
                                                                            fontSize,),
                                                                          SizedBox(
                                                                            height: 5,
                                                                          ),
                                                                          Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Flexible(
                                                                                child: Column(
                                                                                  crossAxisAlignment:
                                                                                  CrossAxisAlignment
                                                                                      .start,
                                                                                  children: [
                                                                                    WidgetText.widgetPoppinsRegularText(
                                                                                        "Quantity",
                                                                                        Color(
                                                                                            GREY3),
                                                                                        fontSize),
                                                                                    SizedBox(
                                                                                      height: 5,
                                                                                    ),
                                                                                    WidgetText.widgetPoppinsMediumText(
                                                                                        logic
                                                                                            .viewDetailsModel
                                                                                            .data
                                                                                            ?.productDetails[index]
                                                                                            .cartMenu[cartIndex]
                                                                                            .selectQuantity
                                                                                            .toString() ??
                                                                                            "",
                                                                                        Color(BLACK2),
                                                                                        fontSize),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Flexible(
                                                                                child: Column(
                                                                                  crossAxisAlignment:
                                                                                  CrossAxisAlignment
                                                                                      .start,
                                                                                  children: [
                                                                                    WidgetText.widgetPoppinsRegularText(
                                                                                        "Amount",
                                                                                        Color(
                                                                                            GREY3),
                                                                                        fontSize),
                                                                                    SizedBox(
                                                                                      height: 5,
                                                                                    ),
                                                                                    WidgetText.widgetPoppinsMediumText(
                                                                                        "\$" +
                                                                                            (logic.viewDetailsModel.data?.productDetails[index].cartMenu[cartIndex].price.toString() ??
                                                                                                ""),
                                                                                        Color(
                                                                                            BLACK2),
                                                                                        fontSize),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ))
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                            ],
                                                          );
                                                        }),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    /*index == itemCountIndex - 1
                                                        ? Container()
                                                        :*/ Container(
                                                          margin: EdgeInsets.only(bottom: 20),
                                                            child: Divider(
                                                              color: Color(
                                                                  DARKGREY),
                                                              height: 1,
                                                              thickness: 0,
                                                            ),
                                                          ),
                                                  ],
                                                );
                                              }),

                                          WidgetText.widgetPoppinsRegularText(
                                              "Customer ID",
                                              Color(GREY3),
                                              fontSize),
                                          WidgetText.widgetPoppinsMaxLineOverflowText(
                                              logic.viewDetailsModel.data?.userData.userId.toString() ?? "",
                                              // "#4434343434245",
                                              Color(BLACK2),
                                              fontSize),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          logic.viewDetailsModel.data
                                                          ?.paymentMethod ==
                                                      'online' &&
                                              logic.viewDetailsModel.data?.shippingAddress.isNotEmpty == true
                                                  // logic.deliveryAddress.isNotEmpty
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                            "Delivery Address",
                                                            Color(GREY3),
                                                        fontSize),
                                                    WidgetText
                                                        .widgetPoppinsMaxLineOverflowText(
                                                            // logic.deliveryAddress,
                                                        logic.viewDetailsModel.data?.shippingAddress.toString() ?? "",
                                                            Color(BLACK2),
                                                        fontSize, maxline: 3),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                  /*  WidgetText
                                                        .widgetPoppinsRegularText(
                                                            zipCode,
                                                            Color(GREY3),
                                                            14),
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                            logic.pincode,
                                                            Color(BLACK2),
                                                            14),
                                                    SizedBox(
                                                      height: 15,
                                                    ),*/
                                                  ],
                                                )
                                              : Container(),
                                          WidgetText.widgetPoppinsRegularText(
                                              "Order ID", Color(GREY3), fontSize),
                                          WidgetText.widgetPoppinsMaxLineOverflowText(
                                              logic.viewDetailsModel.data
                                                      ?.groupOrderID ??
                                                  "#42283",
                                              Color(BLACK2),
                                              16),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          WidgetText.widgetPoppinsRegularText(
                                              "Total Amount",
                                              Color(GREY3),
                                              fontSize),
                                          WidgetText.widgetPoppinsMaxLineOverflowText(
                                              '\$' +
                                                  (logic.viewDetailsModel.data
                                                          ?.total
                                                          .ceil()
                                                          .toString() ??
                                                      ""),
                                              Color(BLACK2),
                                              16),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          WidgetText.widgetPoppinsRegularText(
                                              payment_method,
                                              Color(GREY3),
                                              fontSize),
                                          WidgetText.widgetPoppinsMaxLineOverflowText(
                                              logic.viewDetailsModel.data
                                                      ?.paymentMethod ??
                                                  "Cash On Delivery",
                                              Color(BLACK2),
                                              fontSize),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          logic.viewDetailsModel.data
                                                      ?.paymentMethod ==
                                                  'online'
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                            "Transaction ID",
                                                            Color(GREY3),
                                                        fontSize),
                                                    WidgetText.widgetPoppinsMaxLineOverflowText(
                                                        logic
                                                                .viewDetailsModel
                                                                .data
                                                                ?.paymentDetails
                                                                .id ??
                                                            "",
                                                        Color(BLACK2),
                                                        fontSize),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                          WidgetText.widgetPoppinsRegularText(
                                              order_placed, Color(GREY3), fontSize),
                                          WidgetText.widgetPoppinsMaxLineOverflowText(
                                              logic.orderPlacedDate,
                                              Color(BLACK2),
                                              fontSize),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          WidgetText.widgetPoppinsRegularText(
                                              orderTypeTitle,
                                              Color(GREY3),
                                              fontSize),
                                          WidgetText.widgetPoppinsMaxLineOverflowText(
                                              logic.viewDetailsModel.data
                                                      ?.orderType ??
                                                  "",
                                              Color(BLACK2),
                                              fontSize),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          WidgetText.widgetPoppinsRegularText(
                                              orderStatus == 1
                                                  ? logic.viewDetailsModel.data
                                                              ?.orderType ==
                                                          "PICKUP"
                                                      ? expectedCompletion
                                                      : expectedDelivery
                                                  : orderStatus == 2
                                                      ? completed
                                                      : canceled,
                                              Color(GREY3),
                                              fontSize),
                                          WidgetText.widgetPoppinsMaxLineOverflowText(
                                              logic.viewDetailsModel.data
                                                          ?.timeSlot.isEmpty ==
                                                      true
                                                  ? (logic.deliveryDate ?? "-") : (logic.deliveryDate +
                                                      "," +
                                                      (logic.viewDetailsModel
                                                              .data?.timeSlot ??
                                                          "-")),
                                              Color(BLACK2),
                                              fontSize),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          /* WidgetText.widgetPoppinsRegularText(
                                      "Created Date",
                                      Color(GREY3),
                                      14),
                                  WidgetText.widgetPoppinsRegularText(
                                      logic.createdDate, Color(BLACK2), 14),
                                  SizedBox(
                                    height: 15,
                                  ),*/
                                          orderStatus == 3
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                            canceledReason,
                                                            Color(GREY3),
                                                        fontSize),
                                                    WidgetText.widgetPoppinsRegularText(
                                                        logic
                                                                .viewDetailsModel
                                                                .data
                                                                ?.cancelReason ??
                                                            "",
                                                        Color(BLACK2),
                                                        fontSize),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                  ],
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      );
              });
      })),
    );
  }

  onClickExport() {}
}

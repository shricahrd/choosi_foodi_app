import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import '../../../../core/widgets/widget_card.dart';
import '../controller/order_rest_details_controller.dart';

class OrderDetails extends StatefulWidget {
  int serialNo;
  int orderStatus;
  String orderId = "";

  OrderDetails({required this.serialNo, required this.orderStatus, required this.orderId});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState(serialNo, orderStatus, orderId);
}

class _OrderDetailsScreenState extends State<OrderDetails> {
  int orderStatus = 1;
  int serialNo = 1;
  final OrderRestDetailsController _orderRestDetailsController = Get.put(OrderRestDetailsController());
  String orderId = "";
  double fontSize = 13.0;
  
  _OrderDetailsScreenState(int serialNo, int orderStatus, String orderId){
    this.serialNo = serialNo;
    this.orderStatus = orderStatus;
    this.orderId = orderId;
  }

  @override
  void initState() {
    print('orderStatus: $orderStatus');
    _orderRestDetailsController.callViewOrderDetailsAPI(orderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context,  "Order Details", true),
      body: SafeArea(
        child:
        GetBuilder<GetXNetworkManager>(builder: (networkManager) {
          return networkManager.connectionType == 0
              ? Center(child: Text(check_internet))
              : GetBuilder<OrderRestDetailsController>(builder: (logic) {
            return
              logic.isViewOrderVisible
                  ? Center(
                  child: CircularProgressIndicator(
                    color: Color(ORANGE),
                  ))
                  : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: fontSize,
                    ),
                    Card(
                      margin: EdgeInsets.symmetric(
                          horizontal: fontSize, vertical: 10),
                      // color: Color(WHITE),
                      elevation: 5.0,
                      shadowColor: Color(BLACK2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(WHITE),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.all(fontSize),
                        // width: 280,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                WidgetText.widgetPoppinsRegularOverflowText(
                                    "Customer Name : ", Color(SUBTEXT), fontSize, ),
                                Expanded(
                                  child: WidgetText.widgetPoppinsMediumOverflowText(
                                      logic.viewDetailsModel.data!.userData.firstName + " " + logic.viewDetailsModel.data!.userData.lastName,
                                      Color(BLACK2), fontSize),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              padding: EdgeInsets.all(fontSize),
                              decoration: BoxDecoration(
                                  color: Color(WHITE),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                      color: Color(ORANGE), width: 1),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                              child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  WidgetText
                                      .widgetPoppinsRegularText(
                                      "Order Details", Color(BLACK2), fontSize),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: logic.viewDetailsModel.data?.productDetails.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {

                                        return    Column(
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
                                                      imageFromNetworkCache(logic.viewDetailsModel.data?.productDetails[index].menuImg.first.toString() ?? "",
                                                          height: 120),
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
                                                          logic.viewDetailsModel.data?.productDetails[index].dishName ?? "",
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
                                                                      logic.viewDetailsModel.data?.productDetails[index].selectQuantity
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
                                                                          (logic.viewDetailsModel.data?.productDetails[index].price.toString() ??
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
                                            Container(
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

                                  WidgetText
                                      .widgetPoppinsRegularText(
                                      "Customer ID",
                                      Color(SUBTEXT),
                                      fontSize),
                                  WidgetText
                                      .widgetPoppinsRegularText(
                                      logic.viewDetailsModel.data!.userData.userId,
                                      // "#4434343434245",
                                      Color(BLACK2), fontSize),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  logic.viewDetailsModel.data?.paymentMethod == 'online' && logic.deliveryAddress.isNotEmpty?
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      WidgetText.widgetPoppinsRegularText(
                                          "Delivery Address", Color(SUBTEXT), fontSize),
                                      WidgetText.widgetPoppinsMediumOverflowText(
                                          logic.deliveryAddress,
                                          Color(BLACK2), fontSize),
                                      SizedBox(
                                        height: fontSize,
                                      ),
                                      WidgetText.widgetPoppinsRegularText(
                                          zipCode, Color(SUBTEXT), fontSize),
                                      WidgetText.widgetPoppinsMediumOverflowText(
                                          logic.pincode,
                                          Color(BLACK2), fontSize),
                                      SizedBox(
                                        height: fontSize,
                                      ),
                                    ],
                                  ) : Container(),
                                  WidgetText
                                      .widgetPoppinsRegularText(
                                      "Order ID",
                                      Color(SUBTEXT),
                                      fontSize),
                                  WidgetText
                                      .widgetPoppinsMediumOverflowText(
                                      logic.viewDetailsModel.data?.menuOrderID ?? "#42283",
                                      Color(BLACK2), fontSize),
                                  SizedBox(
                                    height: fontSize,
                                  ),
                                  WidgetText.widgetPoppinsRegularText(
                                      "Total Amount",
                                      Color(SUBTEXT),
                                      fontSize),
                                  WidgetText
                                      .widgetPoppinsMediumOverflowText(
                                      '\$' + (logic.viewDetailsModel.data?.total.ceil().toString() ?? ""), Color(BLACK2), fontSize),
                                  SizedBox(
                                    height: fontSize,
                                  ),
                                  WidgetText.widgetPoppinsRegularText(
                                      payment_method,
                                      Color(SUBTEXT),
                                      fontSize),
                                  WidgetText.widgetPoppinsMediumOverflowText(
                                      logic.viewDetailsModel.data?.paymentMethod ?? "Cash On Delivery", Color(BLACK2), fontSize),
                                  SizedBox(
                                    height: fontSize,
                                  ),

                                  logic.viewDetailsModel.data?.paymentMethod == 'online' ?
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      WidgetText.widgetPoppinsRegularText(
                                          "Transaction ID",
                                          Color(SUBTEXT),
                                          fontSize),
                                      WidgetText.widgetPoppinsMediumOverflowText(
                                          logic.viewDetailsModel.data?.paymentDetails.id ?? "",
                                          Color(BLACK2), fontSize),
                                      SizedBox(
                                        height: fontSize,
                                      ),
                                    ],
                                  ): Container(),
                                  WidgetText.widgetPoppinsRegularText(
                                      order_placed,
                                      Color(SUBTEXT),
                                      fontSize),
                                  WidgetText.widgetPoppinsMediumOverflowText(
                                      logic.orderPlacedDate, Color(BLACK2), fontSize),
                                  SizedBox(
                                    height: fontSize,
                                  ),
                                  WidgetText.widgetPoppinsRegularText(
                                      orderTypeTitle,
                                      Color(SUBTEXT),
                                      fontSize),
                                  WidgetText.widgetPoppinsMediumOverflowText(
                                      logic.viewDetailsModel.data?.orderType ?? "", Color(BLACK2), fontSize),
                                  SizedBox(
                                    height: fontSize,
                                  ),
                                  WidgetText.widgetPoppinsRegularText(
                                      orderStatus == 1?
                                      logic.viewDetailsModel.data?.orderType == "PICKUP" ?
                                      expectedCompletion : expectedDelivery: orderStatus == 2?
                                      completed : canceled,
                                      Color(SUBTEXT),
                                      fontSize),
                                  WidgetText.widgetPoppinsMediumOverflowText(
                                      logic.viewDetailsModel.data?.timeSlot.isEmpty == true ? (logic.deliveryDate) :
                                      (logic.deliveryDate + "," + (logic.viewDetailsModel.data?.timeSlot ?? "")),
                                      Color(BLACK2), fontSize),
                                  SizedBox(
                                    height: fontSize,
                                  ),
                                 /* WidgetText.widgetPoppinsRegularText(
                                      "Created Date",
                                      Color(SUBTEXT),
                                      fontSize),
                                  WidgetText.widgetPoppinsRegularText(
                                      logic.createdDate, Color(BLACK2), fontSize),
                                  SizedBox(
                                    height: fontSize,
                                  ),*/
                                  orderStatus == 3?
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      WidgetText.widgetPoppinsRegularText(
                                          canceledReason,
                                          Color(SUBTEXT),
                                          fontSize) ,
                                      WidgetText.widgetPoppinsMediumOverflowText(
                                          logic.viewDetailsModel.data?.cancelReason ?? "", Color(BLACK2), fontSize),
                                      SizedBox(
                                        height: fontSize,
                                      ),
                                    ],
                                  ): Container()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40,),
                  ],
                ),
              );
          });
            })
      ),
    );
  }

  onClickExport() {}
}

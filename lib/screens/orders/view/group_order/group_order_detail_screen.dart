import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import '../../../../core/widgets/widget_card.dart';
import '../../../../core/widgets/widget_webview.dart';
import '../../../../routes/general_path.dart';
import '../../controller/group_order/group_list_controller.dart';
import '../../controller/group_order/group_orderdetails_controller.dart';
import '../../controller/rating_controller.dart';
import '../../model/group_order/get_go_details_model.dart.dart';

class GroupOrderDetailsScreen extends StatefulWidget {
  int orderStatus = 0; //0->Upcoming, 1->Completed, 2->Canceled
  String orderId = "";

  GroupOrderDetailsScreen(
      {Key? key, required this.orderStatus, required this.orderId})
      : super(key: key);

  @override
  _OrderDetailsScreenState createState() =>
      _OrderDetailsScreenState(orderStatus, orderId);
}

class _OrderDetailsScreenState extends State<GroupOrderDetailsScreen> {
  final GroupOrderDetailsController groupOrderDetailsController = Get.put(GroupOrderDetailsController());
  final GroupOrderListController groupListController = Get.put(GroupOrderListController());

  int orderStatus = 0;
  String orderId = "";

  _OrderDetailsScreenState(int orderStatus, String orderId) {
    this.orderStatus = orderStatus;
    this.orderId = orderId;
  }

  @override
  void initState() {
    print('OrderStatus: $orderStatus');
    groupOrderDetailsController.callViewOrderDetailsAPI(orderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(
          context, "Details",
          true),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : GetBuilder<GroupOrderDetailsController>(builder: (logic) {
                return logic.isViewOrderVisible
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Color(ORANGE),
                      ))
                    : logic.groupOrderDetailsModel.meta?.status == false
                    ? Center(
                    child: Container(
                      child: Text('No Data Found'),
                    )): ListView(
                        padding: EdgeInsets.all(15),
                        physics: BouncingScrollPhysics(),
                        children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // height: 200,
                                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color(WHITE),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          color: Color(ORANGE), width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        WidgetText.widgetPoppinsMediumText(
                                          logic.groupOrderDetailsModel.data?.groupData.groupName.toString() ?? "",
                                          Color(ORANGE),
                                          14,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 80,
                                              height: 70,
                                              child:  ClipRRect(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      10.0),
                                                  child: imageFromNetworkCache(
                                                      logic.groupOrderDetailsModel
                                                          .data?.restaurantData?.restaurantImg.first.toString() ?? "",
                                                      height: 70)),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  WidgetText
                                                      .widgetPoppinsMediumText(
                                                    logic
                                                        .groupOrderDetailsModel.data?.restaurantData?.restaurantName.toString() ?? "",
                                                    Color(BLACK),
                                                    16,
                                                  ),
                                                  WidgetText
                                                      .widgetPoppinsMediumText(
                                                    logic.orderStatusVal ?? "",
                                                    Color(ORANGE),
                                                    14,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  orderStatus == 2 ?
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    width: double.infinity,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color(WHITE),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          color: Color(ORANGE), width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child:
                                    logic.groupOrderDetailsModel.data?.cancelReason == null ?  Text(''):
                                        WidgetText
                                            .widgetPoppinsRegularMaxOverflowText(
                                      "Canceled Reason : " +
                                          logic
                                              .groupOrderDetailsModel
                                              .data!.cancelReason.toString(),
                                          // "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis.",
                                      Color(SUBTEXT),
                                      14,
                                    ),
                                  ) : Container(),

                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Color(WHITE),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          color: Color(ORANGE), width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Flexible(
                                              child: Container(
                                                alignment: Alignment.topLeft,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    WidgetText
                                                        .widgetPoppinsRegularText(
                                                      "Order ID",
                                                      Color(SUBTEXT),
                                                      14,
                                                    ),
                                                   WidgetText.widgetPoppinsMediumText(
                                                            logic.
                                                   groupOrderDetailsModel.data?.groupOrderID.toString() ?? "",
                                                            Color(BLACK),
                                                            14,
                                                          ),
                                                  ],
                                                ),
                                              ),
                                              flex: 1,
                                              fit: FlexFit.tight,
                                            ),
                                            // orderStatus == 5
                                            orderStatus == 2 ? Container() :
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      WidgetText
                                                          .widgetPoppinsRegularText(
                                                        "Receipt",
                                                        Color(SUBTEXT),
                                                        14,
                                                      ),
                                                      InkWell(
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  10, 5, 10, 5),
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
                                                                            5)),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: WidgetText
                                                              .widgetPoppinsMediumText(
                                                            "View",
                                                            Color(WHITE),
                                                            13,
                                                          ),
                                                        ),
                                                        onTap: () {
                                                          // receipt_url
                                                            if (logic.groupOrderDetailsModel.data!.groupOrderId.isNotEmpty) {
                                                              Get.to(()=>
                                                              WidgetWebview(url: GeneralPath.BASE_URI + GeneralPath.API_GROUP_INVOICE + logic.groupOrderDetailsModel.data!.groupOrderId.toString(), appbarName: viewReceipt,));
                                                            }else {
                                                              showToastMessage(
                                                                  "Not Found");
                                                            }
                                                          },
                                                      )
                                                    ],
                                                  ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            orderStatus == 0
                                                ? WidgetText
                                                    .widgetPoppinsRegularText(
                                                    datePurchased,
                                                    Color(SUBTEXT),
                                                    14,
                                                  )
                                                : WidgetText
                                                    .widgetPoppinsRegularText(
                                                    "Order Placed on date",
                                                    Color(SUBTEXT),
                                                    14,
                                                  ),
                                            logic.orderPlacedDate == ""
                                                ? Text("")
                                                : WidgetText
                                                    .widgetPoppinsMediumText(
                                                    logic.orderPlacedDate,
                                                    Color(BLACK),
                                                    14,
                                                  ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            orderStatus == 0?
                                            WidgetText.widgetPoppinsRegularText(
                                              logic.groupOrderDetailsModel.data?.orderType == "DELIVERY" ?
                                                  expectedDelivery : expectedCompletion,
                                              Color(SUBTEXT),
                                              14,
                                            ):
                                            WidgetText.widgetPoppinsRegularText(
                                              orderStatus == 0
                                                  ? expectedDelivery
                                                  : orderStatus == 1
                                                      ? dateDelivered
                                                      : dateCanceled,
                                              Color(SUBTEXT),
                                              14,
                                            ),
                                            logic.deliveryDate == ""
                                                ? Text("")
                                                : WidgetText
                                                    .widgetPoppinsMediumText(
                                                    logic.deliveryDate,
                                                    Color(BLACK),
                                                    14,
                                                  ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            itemCount: logic
                                                .groupOrderDetailsModel.data
                                                ?.productDetails.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {

                                              int mainIndex = index;

                                              return  Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  WidgetText.widgetPoppinsRegularText(
                                                    "Items (${logic.groupOrderDetailsModel.data?.productDetails[index].name})",
                                                    Color(SUBTEXT),
                                                    14,
                                                  ),
                                                  ListView.builder(
                                                      physics: BouncingScrollPhysics(),
                                                      itemCount: logic
                                                          .groupOrderDetailsModel.data
                                                          ?.productDetails[mainIndex].cartMenu.length,
                                                      shrinkWrap: true,
                                                      itemBuilder: (context, index) {

                                                        dynamic selectQty;
                                                        if(logic.groupOrderDetailsModel.data?.productDetails != null){
                                                          selectQty = logic.groupOrderDetailsModel.data?.productDetails[mainIndex].cartMenu[index].selectQuantity;
                                                        }else{
                                                          selectQty = "";
                                                        }

                                                        return
                                                          selectQty == "" ? Text(''):
                                                          Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              WidgetText
                                                                  .widgetPoppinsMediumText(
                                                                "$selectQty x ${logic.groupOrderDetailsModel.data?.productDetails[mainIndex].cartMenu[index].dishName}",
                                                                Color(BLACK),
                                                                14,
                                                              ),
                                                              Container(
                                                                padding:
                                                              EdgeInsets.symmetric(vertical: 5),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                          Container(
                                                                            padding: EdgeInsets.symmetric(vertical: 10),
                                                                            decoration:
                                                                            BoxDecoration(
                                                                              color:
                                                                              Color(0xffF9F7F8),
                                                                              shape:
                                                                              BoxShape.rectangle,
                                                                              borderRadius:
                                                                              BorderRadius.all(Radius.circular(10)),
                                                                            ),
                                                                            child:
                                                                            Column(
                                                                              crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                              children: [
                                                                                WidgetText.widgetPoppinsRegularText(
                                                                                  "Calories",
                                                                                  Color(BLACK),
                                                                                  13,
                                                                                ),
                                                                                WidgetText.widgetPoppinsMediumText(
                                                                                  logic.groupOrderDetailsModel.data?.productDetails[mainIndex].cartMenu[index].caloriesTotal.toString() ?? "",
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
                                                                          child:
                                                                          Container(
                                                                            padding: EdgeInsets.symmetric(vertical: 10),
                                                                            decoration: BoxDecoration(
                                                                              color: Color(0xffF9F7F8),
                                                                              shape: BoxShape.rectangle,
                                                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                            ),
                                                                            child:
                                                                            Column(
                                                                              crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                              children: [
                                                                                WidgetText.widgetPoppinsRegularText(
                                                                                  "Fat",
                                                                                  Color(BLACK),
                                                                                  13,
                                                                                ),
                                                                               WidgetText.widgetPoppinsMediumText(
                                                                                  (logic.groupOrderDetailsModel.data?.productDetails[mainIndex].cartMenu[index].fatTotal.toString() ?? "")+ "g",
                                                                                  Color(SUBTEXT),
                                                                                  14,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                          15,
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                          Container(
                                                                            padding: EdgeInsets.symmetric(vertical: 10),
                                                                            decoration:
                                                                            BoxDecoration(
                                                                              color:
                                                                              Color(0xffF9F7F8),
                                                                              shape:
                                                                              BoxShape.rectangle,
                                                                              borderRadius:
                                                                              BorderRadius.all(Radius.circular(10)),
                                                                            ),
                                                                            child:
                                                                            Column(
                                                                              crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                              children: [
                                                                                WidgetText.widgetPoppinsRegularText(
                                                                                  "Carbs",
                                                                                  Color(BLACK),
                                                                                  13,
                                                                                ),
                                                                                WidgetText.widgetPoppinsMediumText(
                                                                                  (logic.groupOrderDetailsModel.data?.productDetails[mainIndex].cartMenu[index].carbsTotal.toString() ?? "")+ "g",
                                                                                  Color(SUBTEXT),
                                                                                  14,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                          15,
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                          Container(
                                                                            padding: EdgeInsets.symmetric(vertical: 10),
                                                                            decoration:
                                                                            BoxDecoration(
                                                                              color:
                                                                              Color(0xffF9F7F8),
                                                                              shape:
                                                                              BoxShape.rectangle,
                                                                              borderRadius:
                                                                              BorderRadius.all(Radius.circular(10)),
                                                                            ),
                                                                            child:
                                                                            Column(
                                                                              crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                              children: [
                                                                                WidgetText.widgetPoppinsRegularText(
                                                                                  "Protein",
                                                                                  Color(BLACK),
                                                                                  13,
                                                                                ),
                                                                                 WidgetText.widgetPoppinsMediumText(
                                                                                   (logic.groupOrderDetailsModel.data?.productDetails[mainIndex].cartMenu[index].proteinTotal.toString() ?? "")+ "g",
                                                                                  Color(SUBTEXT),
                                                                                  14,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                      }),
                                                ],
                                              );


                                            }),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Color(WHITE),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          color: Color(ORANGE), width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        WidgetText.widgetPoppinsMediumText(
                                          "Price Details",
                                          Color(BLACK),
                                          18,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: WidgetText
                                                          .widgetPoppinsMediumText(
                                                        "Amount",
                                                        Color(BLACK),
                                                        14,
                                                      ),
                                                    ),
                                                  ),
                                           WidgetText
                                                    .widgetPoppinsMediumText(
                                                    "\$" +
                                                        (logic
                                                            .groupOrderDetailsModel.data?.subTotal.toStringAsFixed(2) ?? ""),
                                                    Color(ORANGE),
                                                    14,
                                                  )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: WidgetText
                                                    .widgetPoppinsMediumText(
                                                  "Tax",
                                                  Color(BLACK),
                                                  14,
                                                ),
                                              ),
                                            ),
                                         WidgetText.widgetPoppinsMediumText(
                                                    "\$" +
                                                        (logic
                                                            .groupOrderDetailsModel.data?.taxAmount.toStringAsFixed(2) ?? ""),
                                                    Color(ORANGE),
                                                    14,
                                                  )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: WidgetText
                                                    .widgetPoppinsMediumText(
                                                  "Discount",
                                                  Color(BLACK),
                                                  14,
                                                ),
                                              ),
                                            ),
                                           WidgetText
                                                    .widgetPoppinsMediumText(
                                                    "\$" +
                                                        (logic
                                                            .groupOrderDetailsModel.data?.couponDiscount.toStringAsFixed(2) ?? ""),
                                                    Color(ORANGE),
                                                    14,
                                                  ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: WidgetText
                                                    .widgetPoppinsMediumText(
                                                  "Delivery charges",
                                                  Color(BLACK),
                                                  14,
                                                ),
                                              ),
                                            ),
                                          WidgetText
                                                    .widgetPoppinsMediumText(
                                                    "\$" +
                                                        (logic
                                                            .groupOrderDetailsModel.data?.deliveryCharges.toStringAsFixed(2) ?? "0"),
                                                    Color(ORANGE),
                                                    14,
                                                  )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Divider(
                                          color: Color(LIGHTDIVIDERCOLOR),
                                          height: 1,
                                          thickness: 1,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: WidgetText
                                                    .widgetPoppinsMediumText(
                                                  "Total",
                                                  Color(BLACK),
                                                  14,
                                                ),
                                              ),
                                            ),
                                            logic.groupOrderDetailsModel.data
                                                        ?.total ==
                                                    null
                                                ? Text("")
                                                : WidgetText
                                                    .widgetPoppinsMediumText(
                                                    "\$" +
                                                        (logic
                                                            .groupOrderDetailsModel.data?.total.toStringAsFixed(2) ?? ""),
                                                    Color(ORANGE),
                                                    14,
                                                  )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  orderStatus == 1
                                      ? Container(
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              WidgetText
                                                  .widgetPoppinsMediumText(
                                                "Delivery details",
                                                Color(BLACK),
                                                18,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              logic.name == ""
                                                  ? Text("")
                                                  : WidgetText
                                                      .widgetPoppinsMediumText(
                                                      logic.name,
                                                      Color(BLACK),
                                                      14,
                                                    ),
                                              logic.deliveryAddress == ""
                                                  ? Text("")
                                                  : WidgetText
                                                      .widgetPoppinsRegularText(
                                                      logic.deliveryAddress,
                                                      Color(SUBTEXT),
                                                      14,
                                                    ),
                                              Divider(
                                                // color: Color(LIGHTDIVIDERCOLOR),
                                                color: Color(WHITE),
                                                height: 1,
                                                thickness: 1,
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                  orderStatus == 1
                                      ? SizedBox(
                                          height: 15,
                                        )
                                      : Container(),
                                  orderStatus == 1
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  rateUsDialog(context,  logic
                                                      .groupOrderDetailsModel
                                                      .data?.restaurantData?.ratings ?? "0.0");
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 15, 0, 15),
                                                  decoration: BoxDecoration(
                                                    color: Color(ORANGE),
                                                    shape: BoxShape.rectangle,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(7)),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: WidgetText
                                                      .widgetPoppinsMediumText(
                                                    rateUs,
                                                    Color(WHITE),
                                                    14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: InkWell(
                                                onTap: (){
                                                  print('Len: ${logic.groupOrderDetailsModel.data?.groupData.joinedMember?.length}');
                                                  if(logic.groupOrderDetailsModel.data?.groupData.joinedMember?.length != 0) {
                                                    viewParticipantsDialog(context,
                                                        logic.groupOrderDetailsModel.data
                                                            ?.groupData.joinedMember);
                                                  }else{
                                                    showToastMessage('No Participants Joined');
                                                  }
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 15, 0, 15),
                                                  decoration: BoxDecoration(
                                                    color: Color(WHITE),
                                                    shape: BoxShape.rectangle,
                                                    border: Border.all(
                                                        color: Color(ORANGE),
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(7)),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: WidgetText
                                                      .widgetPoppinsMediumText(
                                                    viewParticipant,
                                                    Color(ORANGE),
                                                    14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  orderStatus == 1 ? Container():
                                  InkWell(
                                    onTap: () {
                                      print('Len: ${logic.groupOrderDetailsModel.data?.groupData.joinedMember?.length}');
                                      if(logic.groupOrderDetailsModel.data?.groupData.joinedMember?.length != 0) {
                                        viewParticipantsDialog(context,
                                            logic.groupOrderDetailsModel.data
                                                ?.groupData.joinedMember);
                                      }else{
                                        showToastMessage('No Participants Joined');
                                      }
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 15, 0, 15),
                                      decoration: BoxDecoration(
                                        color: Color(ORANGE),
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)),
                                      ),
                                      alignment: Alignment.center,
                                      child: WidgetText.widgetPoppinsMediumText(
                                        viewParticipant,
                                        Color(WHITE),
                                        14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]);
              });
      })),
    );
  }

  void rateUsDialog(BuildContext mContext, dynamic _ratingValue) {
    // dynamic _ratingValue = 0.0;
    TextEditingController _ratingController = TextEditingController();
    final RatingController ratingController = Get.put(RatingController());

    var restaurantId;
    if (groupOrderDetailsController
            .groupOrderDetailsModel.data?.restaurantData?.restaurantId !=
        null) {
      restaurantId = groupOrderDetailsController
          .groupOrderDetailsModel.data?.restaurantData?.restaurantId
          .toString();
      print('restaurantId: $restaurantId');
    }

    showDialog(
        context: mContext,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              //this right here
              child: Container(
                height: 400,
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
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
                          "Rating & Review",
                          Color(BLACK),
                          18,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: RatingStars(
                          value: _ratingValue,
                          onValueChanged: (v) {
                            setState(() {
                              print('Value: $v');
                              _ratingValue = v;
                              print('_ratingValue: $_ratingValue');
                            });
                          },
                          starBuilder: (index, color) => Icon(
                            Icons.star_rounded,
                            color: color,
                          ),
                          maxValueVisibility: false,
                          valueLabelVisibility: false,
                          starCount: 5,
                          starSpacing: 2,
                          starSize: 20,
                          starColor: Color(0xffFFD633),
                          starOffColor: Color(0xffC1C1C1),
                          animationDuration: Duration(milliseconds: 1000),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      WidgetText.widgetPoppinsRegularText(
                        "Your feedback",
                        Color(BLACK),
                        14,
                      ),
                      Card(
                        elevation: 5,
                        color: Color(WHITE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: TextFormField(
                            controller: _ratingController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text,
                            minLines: 3,
                            maxLines: 3,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Color(0xff8C8989),
                                fontSize: 16,
                                fontFamily: FontPoppins,
                                fontWeight: PoppinsRegular,
                              ),
                              hintText: "",
                            ),
                            style: TextStyle(
                              color: Color(0xff3E4958),
                              fontSize: 16,
                              fontFamily: FontPoppins,
                              fontWeight: PoppinsRegular,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // GetBuilder<RatingController>(builder: (logic) {

                      ratingController.isLoaderVisible
                          ? WidgetButton.widgetDefaultButton("Submit",
                              () async {
                              await ratingController.postRatingApi(
                                restId: restaurantId,
                                rating: _ratingValue,
                                review: _ratingController.text,
                              );
                              if (ratingController.isLoaderVisible == false) {
                                setState(() {
                                  ratingController.isLoaderVisible = true;
                                });
                              }
                              Navigator.pop(context);
                            })
                          : Center(
                              child: CircularProgressIndicator(
                              color: Color(ORANGE),
                            ))
                      // })
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  void viewParticipantsDialog(BuildContext mContext, List<JoinMemberItem>? participantList) {

    showDialog(
        context: mContext,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              //this right here
              child: Container(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  // physics: NeverScrollableScrollPhysics(),
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
                        child: WidgetText.widgetPoppinsRegularText(
                          "Participants",
                          Color(BLACK),
                          20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: participantList?.length ?? 5,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: Image.asset(
                                        ic_default_user,
                                        height: 55.0,
                                        width: 55.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(
                                      child: WidgetText.widgetPoppinsRegularText(
                                        // 'user ${index +1 }',
                                        participantList?[index].name ?? "",
                                        Color(BLACK),
                                        18,
                                      ),
                                      flex: 1,
                                      fit: FlexFit.tight,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            );
                          }),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }
}

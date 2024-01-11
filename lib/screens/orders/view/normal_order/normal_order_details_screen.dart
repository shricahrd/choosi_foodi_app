import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import '../../../../core/widgets/widget_webview.dart';
import '../../../cart/view/cart_screen.dart';
import '../../controller/normal_order/menu_order_controller.dart';
import '../../controller/normal_order/menu_orderdetails_controller.dart';
import '../../controller/rating_controller.dart';

class NormalOrderDetailsScreen extends StatefulWidget {
  int orderStatus = 1; //1->Upcoming, 2->Completed, 3->Canceled
  String orderId = "";

  NormalOrderDetailsScreen(
      {Key? key, required this.orderStatus, required this.orderId})
      : super(key: key);

  @override
  _NormalOrderDetailsScreenState createState() =>
      _NormalOrderDetailsScreenState(orderStatus, orderId);
}

class _NormalOrderDetailsScreenState extends State<NormalOrderDetailsScreen> {
  final MenuOrderController menuOrderController =
      Get.put(MenuOrderController());
  final MenuOrderDetailsController menuOrderDetailsController =
      Get.put(MenuOrderDetailsController());
  int orderStatus = 0;
  String orderId = "";

  _NormalOrderDetailsScreenState(int orderStatus, String orderId) {
    this.orderStatus = orderStatus;
    this.orderId = orderId;
  }

  @override
  void initState() {
    debugPrint('OrderStatus: $orderStatus');
    menuOrderDetailsController.callViewOrderDetailsAPI(orderId);
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
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
                details,
                Color(BLACK),
                16,
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : GetBuilder<MenuOrderDetailsController>(builder: (logic) {

              // print('RestData: ${logic.viewDetailsModel.data?.restaurantData?.toJson().toString()}');
              print('RestData Img: ${logic.viewDetailsModel.data?.restaurantData?.restaurantImg?.first.toString()}');
              // print('Image: ${logic.viewDetailsModel.data?.productDetails?[0].menuImg?[0].toString()}');

                return logic.isViewOrderVisible
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Color(ORANGE),
                      ))
                    : ListView(
                        padding: EdgeInsets.all(15),
                        physics: BouncingScrollPhysics(),
                        children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
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
                                    child:
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 70,
                                          child:
                                          logic.viewDetailsModel.data?.restaurantData?.restaurantImg?.isEmpty == true
                                              ? Image.asset(
                                            ic_no_image,
                                            fit: BoxFit.fill,
                                          )
                                              : ClipRRect(
                                            borderRadius: BorderRadius
                                                .circular(10.0),
                                            child: Image.network(
                                              logic.viewDetailsModel.data?.restaurantData?.restaurantImg?.first.toString() ?? "",
                                              fit: BoxFit.fill,
                                              loadingBuilder: (BuildContext context, Widget child,
                                                  ImageChunkEvent? loadingProgress) {
                                                if (loadingProgress == null) return child;
                                                return Center(
                                                  child: CircularProgressIndicator(
                                                    color: Color(ORANGE),
                                                    value: loadingProgress.expectedTotalBytes != null
                                                        ? loadingProgress.cumulativeBytesLoaded /
                                                        loadingProgress.expectedTotalBytes!
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
                                                    .viewDetailsModel.data?.restaurantData?.restaurantName.toString() ?? "",
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
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 15),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
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
                                                    logic.viewDetailsModel.data
                                                                ?.menuOrderID ==
                                                            null
                                                        ? Text('')
                                                        : WidgetText
                                                            .widgetPoppinsMediumText(
                                                            logic
                                                                .viewDetailsModel
                                                                .data!
                                                                .menuOrderID
                                                                .toString(),
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
                                            /* logic.viewDetailsModel.data!.paymentMethod != "online"
                                                ? Container()
                                                : */
                                            orderStatus == 3
                                                ? Container()
                                                : Column(
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
                                                            if (logic.viewDetailsModel.data?.menuOrderId?.isNotEmpty == true) {
                                                              if (logic.viewDetailsModel.data?.menuOrderId != null) {
                                                              Get.to(() =>
                                                                  WidgetWebview(
                                                                    url:
                                                                    GeneralPath.BASE_URI +
                                                                        GeneralPath
                                                                            .API_INVOICE +
                                                                        (logic
                                                                            .viewDetailsModel.data?.menuOrderId.toString() ?? ""), appbarName: viewReceipt,
                                                                  ));
                                                            } else {
                                                              showToastMessage(
                                                                  "Not Found");
                                                            }
                                                          } else {
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
                                            // orderStatus == 1 ||  orderStatus == 2 ?
                                            WidgetText
                                                    .widgetPoppinsRegularText(
                                                 datePurchased,
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
                                            orderStatus == 1 ?
                                            WidgetText.widgetPoppinsRegularText(
                                              logic.viewDetailsModel.data?.orderType == "DELIVERY" ?
                                                 "$expectedDelivery" :  "$expectedCompletion",
                                              Color(SUBTEXT),
                                              14,
                                            ) :
                                            WidgetText.widgetPoppinsRegularText(
                                              orderStatus == 2
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
                                        orderStatus == 3 ?
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            WidgetText.widgetPoppinsRegularText(
                                              "Cancelation Reason",
                                              Color(SUBTEXT),
                                              14,
                                            ),
                                            WidgetText
                                                .widgetPoppinsMediumText(
                                              logic.viewDetailsModel.data?.cancelReason ?? "",
                                              Color(BLACK),
                                              14,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ) : Container(),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            WidgetText.widgetPoppinsRegularText(
                                              "Items",
                                              Color(SUBTEXT),
                                              14,
                                            ),
                                            ListView.builder(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                itemCount: logic
                                                    .viewDetailsModel
                                                    .data
                                                    ?.productDetails
                                                    ?.length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      logic
                                                          .viewDetailsModel
                                                          .data
                                                          ?.productDetails?[index]
                                                              .selectQuantity ==
                                                          null
                                                          ? Text('')
                                                          : WidgetText
                                                          .widgetPoppinsMediumText(
                                                      "${logic.viewDetailsModel.data?.productDetails?[index].selectQuantity} x ${logic.viewDetailsModel.data?.productDetails?[index].dishName}",
                                                      Color(BLACK),
                                                      14,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              padding: EdgeInsets.fromLTRB(
                                                                  0, 15, 0, 15),
                                                              decoration: BoxDecoration(
                                                                color: Color(0xffF9F7F8),
                                                                shape: BoxShape.rectangle,
                                                                borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(10)),
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment.center,
                                                                children: [
                                                                  WidgetText
                                                                      .widgetPoppinsRegularText(
                                                                    "Calories",
                                                                    Color(BLACK),
                                                                    13,
                                                                  ),
                                                                WidgetText
                                                                      .widgetPoppinsMediumText(
                                                                  logic.viewDetailsModel.data?.productDetails?[index].caloriesTotal.toString() ?? "",
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
                                                              padding: EdgeInsets.fromLTRB(
                                                                  0, 15, 0, 15),
                                                              decoration: BoxDecoration(
                                                                color: Color(0xffF9F7F8),
                                                                shape: BoxShape.rectangle,
                                                                borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(10)),
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment.center,
                                                                children: [
                                                                  WidgetText
                                                                      .widgetPoppinsRegularText(
                                                                    "Fat",
                                                                    Color(BLACK),
                                                                    13,
                                                                  ),
                                                                 WidgetText
                                                                      .widgetPoppinsMediumText(
                                                                   (logic.viewDetailsModel.data?.productDetails?[index].fatTotal.toString() ?? "") + "g",
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
                                                              padding: EdgeInsets.fromLTRB(
                                                                  0, 15, 0, 15),
                                                              decoration: BoxDecoration(
                                                                color: Color(0xffF9F7F8),
                                                                shape: BoxShape.rectangle,
                                                                borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(10)),
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment.center,
                                                                children: [
                                                                  WidgetText
                                                                      .widgetPoppinsRegularText(
                                                                    "Carbs",
                                                                    Color(BLACK),
                                                                    13,
                                                                  ),
                                                                 WidgetText
                                                                      .widgetPoppinsMediumText(
                                                                   (logic.viewDetailsModel.data?.productDetails?[index].carbsTotal.toString() ?? "") + "g",
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
                                                              padding: EdgeInsets.fromLTRB(
                                                                  0, 15, 0, 15),
                                                              decoration: BoxDecoration(
                                                                color: Color(0xffF9F7F8),
                                                                shape: BoxShape.rectangle,
                                                                borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(10)),
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment.center,
                                                                children: [
                                                                  WidgetText
                                                                      .widgetPoppinsRegularText(
                                                                    "Protein",
                                                                    Color(BLACK),
                                                                    13,
                                                                  ),
                                                                 WidgetText
                                                                      .widgetPoppinsMediumText(
                                                                   (logic.viewDetailsModel.data?.productDetails?[index].proteinTotal.toString() ?? "") + "g",
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
                                                  );
                                                }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 15),
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
                                            WidgetText.widgetPoppinsMediumText(
                                              logic.viewDetailsModel.data
                                                          ?.subTotal ==
                                                      null
                                                  ? "\$"
                                                  : "\$" +
                                                      (logic.viewDetailsModel.data?.subTotal?.toStringAsFixed(2) ?? ""),
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
                                                      (logic.viewDetailsModel.data?.taxAmount.toStringAsFixed(2) ?? ""),
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
                                                        (logic.viewDetailsModel.data?.couponDiscount.toStringAsFixed(2) ?? ""),
                                                    Color(ORANGE),
                                                    14,
                                                  ),
                                          ],
                                        ),
                                        logic.viewDetailsModel.data?.orderType == "PICKUP" ? Container():
                                        SizedBox(
                                          height: 10,
                                        ),
                                        logic.viewDetailsModel.data?.orderType == "PICKUP" ? Container():
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
                                                        (logic.viewDetailsModel.data?.deliveryCharge?.toStringAsFixed(2) ?? ""),
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
                                            logic.viewDetailsModel.data
                                                        ?.total ==
                                                    null
                                                ? Text("")
                                                : WidgetText
                                                    .widgetPoppinsMediumText(
                                                    "\$" +
                                                        logic.viewDetailsModel.data?.total.toStringAsFixed(2),
                                                    Color(ORANGE),
                                                    14,
                                                  )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  orderStatus == 2 &&
                                          logic.deliveryAddress != ""
                                      ? Container(
                                          width: MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.only(top: 15),
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
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                  orderStatus == 2
                                      ? SizedBox(
                                          height: 15,
                                        )
                                      : Container(),
                                  orderStatus == 2
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  dynamic value;
                                                  if(logic.viewDetailsModel.data?.restaurantData?.ratings.toString().isNotEmpty == true || logic.viewDetailsModel.data?.restaurantData?.ratings == null) {
                                                    if (logic.viewDetailsModel.data?.restaurantData?.ratings == 0) {
                                                      value = 0.0;
                                                    }else{
                                                      value = logic.viewDetailsModel.data?.restaurantData?.ratings;
                                                    }
                                                  }else{
                                                    value = 0.0;
                                                  }

                                                  rateUsDialog(
                                                      context,
                                                      value
                                                  );
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
                                                    "Rate Us",
                                                    Color(WHITE),
                                                    14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            menuOrderController
                                                        .isReOrderLoaded ==
                                                    false
                                                ? Expanded(
                                                    child: InkWell(
                                                      onTap: () async {
                                                        if (menuOrderController
                                                                .cartFound ==
                                                            true) {
                                                          print(
                                                              'Call ReOrder api');
                                                          viewReOrderDialog(
                                                              context,
                                                              cartRestaurant:
                                                                  menuOrderController
                                                                      .cartRestaurantName,
                                                              menuRestaurant: logic
                                                                  .viewDetailsModel
                                                                  .data
                                                                  ?.restaurantData
                                                                  ?.restaurantName,
                                                              menuOrderId: logic
                                                                  .viewDetailsModel
                                                                  .data
                                                                  ?.menuOrderId
                                                                  .toString());
                                                        } else {
                                                          await menuOrderController
                                                              .postReOrderApi(
                                                                  menuOrderId: logic
                                                                      .viewDetailsModel
                                                                      .data!
                                                                      .menuOrderId
                                                                      .toString());
                                                          print('Call ReOrder api');
                                                          Get.to(()=> CartScreen());
                                                        }
                                                      },
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 15, 0, 15),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color(WHITE),
                                                          shape: BoxShape
                                                              .rectangle,
                                                          border: Border.all(
                                                              color:
                                                                  Color(ORANGE),
                                                              width: 1),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          7)),
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: WidgetText
                                                            .widgetPoppinsMediumText(
                                                          "Reorder",
                                                          Color(ORANGE),
                                                          14,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Color(ORANGE),
                                                    ),
                                                  ),
                                          ],
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 15,
                                  )
                                ],
                              ),
                            )
                          ]);
              });
      })),
    );
  }

  void viewReOrderDialog(BuildContext mContext,
      {String? cartRestaurant, String? menuRestaurant, String? menuOrderId}) {
    final MenuOrderController menuOrderController =
        Get.put(MenuOrderController());
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
                menuOrderController.isReOrderLoaded == false
                    ? TextButton(
                        onPressed: () async {
                          print('Yes');
                          await menuOrderController.postReOrderApi(
                              menuOrderId: menuOrderId.toString());
                          if (menuOrderController.getQtyUpdateModel.meta?.status ==
                              true) {
                            Navigator.of(context).pop(false);
                            Get.to(()=> CartScreen());
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

  void rateUsDialog(BuildContext mContext, dynamic _ratingValue) {
    // dynamic _ratingValue = 0.0;
    TextEditingController _ratingController = TextEditingController();
    final RatingController ratingController = Get.put(RatingController());

    var restaurantId;
    if (menuOrderDetailsController
            .viewDetailsModel.data?.restaurantData?.restaurantId !=
        null) {
      restaurantId = menuOrderDetailsController
          .viewDetailsModel.data?.restaurantData?.restaurantId
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
}

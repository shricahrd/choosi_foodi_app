import 'dart:io';
import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/utils/app_preferences.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_radio_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/address/view/address_screen.dart';
import 'package:choosifoodi/screens/coupons/view/coupons_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_font_utils.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../../../core/widgets/widget_card.dart';
import '../../cart/controller/menu_cart_controller.dart';
import '../controller/order_checkout_controller.dart';
import '../controller/payment_controller.dart';
import 'online_card_screen.dart';

class OrderCheckoutScreen extends StatefulWidget {
  double caloriesTotal, fatTotal, carbsTotal, proteinTotal;

  OrderCheckoutScreen({
    required this.caloriesTotal,
    required this.fatTotal,
    required this.carbsTotal,
    required this.proteinTotal,
  });

  @override
  _OrderCheckoutScreenState createState() => _OrderCheckoutScreenState();
}
bool _isDecrimentEnable = true;
class _OrderCheckoutScreenState extends State<OrderCheckoutScreen> {
  final MenuCartController menuCartController = Get.put(MenuCartController());
  final OrderCheckoutController orderCheckoutController =
      Get.put(OrderCheckoutController());

// create an instance
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());
  final PaymentController paymentController = Get.put(PaymentController());
  int _orderTypeValue = 0;
  String _orderType = "DELIVERY";
  String selectTime = "";
  String select24HoursTime = "";
  bool addressFound = false;
  DateTime selectedDate = DateTime.now();
  dynamic dateSec = DateTime.now().millisecondsSinceEpoch;
  // dynamic timeSlotId;
  double caloriesTotal = 0.0;
  double fatTotal = 0.0;
  double carbsTotal = 0.0;
  double proteinTotal = 0.0;
  var addressId,
      cartId,
      totalAmount,
      restaurantName,
      couponName,
      // subTotal,
      // apiDiscount,
      deviceType;
  int? selectedTimeIndex;

  @override
  void initState() {
    menuCartController.couponApply = false;
    caloriesTotal = widget.caloriesTotal;
    fatTotal = widget.fatTotal;
    carbsTotal = widget.carbsTotal;
    proteinTotal = widget.proteinTotal;
    getSharedPrefs();
    super.initState();
  }

  /*convertTime(String start, String end){
    final dateTimeNow = DateTime.now();
    final startTime12hours = DateFormat('h:mm a').format(dateTimeNow);
    debugPrint(startTime12hours); // 5:14 PM
  }*/

  getSharedPrefs() async {
    if (_networkManager.connectionType != 0) {
      // debugPrint('Connection Type: ${_networkManager.connectionType}');
      setState(() {
        if (Platform.isIOS) {
          deviceType = 'ios';
          debugPrint('DeviceType: $deviceType');
        } else if (Platform.isAndroid) {
          deviceType = 'android';
          debugPrint('DeviceType: $deviceType');
        }
      });
      totalAmount = menuCartController.getMenuCartModel.total;
      debugPrint('totalAmount: $totalAmount');
      addressId = await AppPreferences.getAddressId();
      debugPrint('ADDRESSID: $addressId');
        if (addressId != "" || addressId != "null" || addressId != null) {
          // debugPrint('AddressId not null');
          await orderCheckoutController.callAddressDetailsAPI(
              addressId: addressId.toString());
          if(orderCheckoutController.addressFound == false){
            if(mounted) {
              setState(() {
                addressFound = false;
                debugPrint('addressNotFound: $addressFound');
              });
            }
          }else{
            if(mounted) {
              setState(() {
                addressFound = true;
                debugPrint('addressFound: $addressFound');
              });
            }
          }
      } else {
        debugPrint('AddressId null');
        await orderCheckoutController.callGetAddressAPI();
        addressId = await AppPreferences.getAddressId();
        debugPrint('ADDRESSID: $addressId');
        if(orderCheckoutController.getAddressModel.meta?.status == false){
          setState(() {
            addressFound = false;
            debugPrint('addressNotFound: $addressFound');
          });
        }else{
          if (addressId != "" || addressId != "null" || addressId != null){
            setState(() {
              addressFound = true;
              debugPrint('addressFound: $addressFound');
            });
          }
        }
      }
      var date = new DateTime.now().millisecondsSinceEpoch;
      debugPrint('Date: $date');
      await orderCheckoutController.callGetSlotAPI(
          restaurantId:
              menuCartController.getMenuCartModel.data!.restaurantId.toString(),
          date: date.toString());
      /*if (orderCheckoutController.getSlotTypeModel.meta?.status == true) {
        if (orderCheckoutController.getSlotTypeModel.data?.length != 0) {
          setState(() {
            // debugPrint('TimeSlot: ${selectTimeSlot}');

            for (int i = 0; i < (orderCheckoutController.getSlotTypeModel.data?.length ?? 0); i++) {
              dynamic start = orderCheckoutController
                  .getSlotTypeModel.data?[i].startTime
                  .replaceAll('.', ':');
              dynamic end = orderCheckoutController
                  .getSlotTypeModel.data?[i].endTime
                  .replaceAll('.', ':');
              if (start.isNotEmpty) {
                debugPrint("compareTimecompareTime");
                // compareTime(start.toString(), end.toString());
                debugPrint("Inside TimeSlot ===>>> $start - $end");
                statusOpen = isValidTimeRange(start ?? "", end ?? "");
                debugPrint('statusOpen: $statusOpen');
                if (statusOpen == true) {
                  selectedTimeIndex = i;
                  debugPrint('selectedTimeIndex: ${selectedTimeIndex}');
                  String startTime =
                      DateFormat.jm().format(DateFormat("hh:mm").parse(start));
                  String endTime =
                      DateFormat.jm().format(DateFormat("hh:mm").parse(end));
                  debugPrint('start: $startTime, end: $endTime');
                  selectTime = startTime + " - " + endTime;
                  debugPrint('TimeSlot: ${selectTime}');
                  select24HoursTime = start + "-" + end;
                  debugPrint('TimeSlot: ${select24HoursTime}');
                }
              }
            }
          });
        }
      }*/
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: WidgetAppbar.simpleAppBar(context, "Checkout", false ),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : Container(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedDate = DateTime.now();
                                      selectTime = "";
                                      _orderTypeValue = 0;
                                      _orderType = "DELIVERY";
                                      debugPrint('orderType: $_orderType');
                                    });
                                  },
                                  child: _orderTypeValue == 0
                                      ? WidgetRadioButton.selectedRadioButton(
                                          "Delivery")
                                      : WidgetRadioButton.unselectedRadioButton(
                                          "Delivery"),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedDate = DateTime.now();
                                      selectTime = "";
                                      _orderTypeValue = 1;
                                      _orderType = "PICKUP";
                                      debugPrint('orderType: $_orderType');
                                    });
                                  },
                                  child: _orderTypeValue == 1
                                      ? WidgetRadioButton.selectedRadioButton(
                                          "Pickup")
                                      : WidgetRadioButton.unselectedRadioButton(
                                          "Pickup"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                      ],
                    ),
                    _orderTypeValue == 0
                        ? Row(
                      children: [
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GetBuilder<OrderCheckoutController>(builder: (logic) {
                              return _orderTypeValue == 0
                                  ? orderCheckoutController.addressFound == true
                                  ? Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                WidgetText.widgetPoppinsMediumText(
                                logic.getAddressDetailsModel.data?.name == null ? "" :
                                    logic.getAddressDetailsModel.data?.name.toString() ?? "",
                                    Color(BLACK),
                                    14,
                                  ),
                                  WidgetText.widgetPoppinsMediumText(
                                    logic.getAddressDetailsModel.data?.mobile.toString() ?? "",
                                    Color(BLACK),
                                    14,
                                  ),
                                  WidgetText.widgetPoppinsMediumText(
                                    logic.defaultAddress.toString(),
                                    Color(LIGHTTEXTCOLOR),
                                    14,
                                  )
                                ],
                              )
                                  : Container()
                                  : Container();
                            }),
                            SizedBox(
                              height: 5,
                            ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: WidgetButton.widgetDefaultButton(
                                    addressFound == true ?
                                    "Change Address" : "Add Address", () {
                                    if (cartId != null) {
                                      onClickChangeAddress(cartId);
                                    }}),
                              ),
                            SizedBox(
                              height: 5,
                            ),
                            timeSlotCard1(),
                          ],
                        )),
                        // timeSlotCard()
                      ],
                    ) : Container(),
                    _orderTypeValue == 1 ?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            timeSlotAddress(),
                            timeSlotCard1(),
                          ],
                        )
                       /* Row(
                          children: [
                            Expanded(child: timeSlotAddress()),
                            timeSlotCard()
                          ],
                        )*/
                        : Container(),
                    SizedBox(
                      height: 15,
                    ),
                    Divider(
                        height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                    Expanded(
                      child: GetBuilder<MenuCartController>(builder: (logic) {
                        restaurantName = logic.getMenuCartModel.data?.restaurant
                                ?.restaurantName ??
                            "";
                        caloriesTotal = logic.caloriesTotal;
                        fatTotal = logic.fatTotal;
                        carbsTotal = logic.carbsTotal;
                        proteinTotal = logic.proteinTotal;

                        cartId = logic.getMenuCartModel.data?.sId.toString();
                        debugPrint('CartID: $cartId');

                        // logic.couponApply = false;

                        return logic.isLoaderVisible
                            ? Center(
                                child: CircularProgressIndicator(
                                color: Color(ORANGE),
                              ))
                            : logic.getMenuCartModel.meta?.status == false
                                ? Center(
                                    child: Container(
                                        color: Color(WHITE),
                                        child: WidgetText.widgetPoppinsMediumText(
                                            'Your Cart is Empty!',
                                            Color(BLACK),
                                            16)))
                                : ListView(
                                    physics: BouncingScrollPhysics(),
                                    children: [
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: logic.getMenuCartModel.data
                                              ?.cartMenu?.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Stack(
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        logic.getMenuCartModel.data
                                                                        ?.cartMenu?[
                                                                    index] ==
                                                                null
                                                            ? Image.asset(
                                                                ic_no_image,
                                                                width: 110,
                                                                height: 95,
                                                                fit:
                                                                    BoxFit.fill,
                                                              )
                                                            : ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                                child: Image
                                                                    .network(
                                                                  logic
                                                                      .getMenuCartModel
                                                                      .data!
                                                                      .cartMenu![
                                                                          index]
                                                                      .menuImg!
                                                                      .first
                                                                      .toString(),
                                                                  width: 110,
                                                                  height: 95,
                                                                  fit: BoxFit
                                                                      .fill,
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
                                                                      (context,
                                                                          error,
                                                                          stackTrace) {
                                                                    return Image
                                                                        .asset(
                                                                      ic_no_image,
                                                                      width:
                                                                          110,
                                                                      height:
                                                                          95,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    );
                                                                  },
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
                                                              logic
                                                                          .getMenuCartModel
                                                                          .data
                                                                          ?.cartMenu?[
                                                                              index]
                                                                          .dishName ==
                                                                      null
                                                                  ? Text('')
                                                                  : WidgetText
                                                                      .widgetPoppinsMediumText(
                                                                      logic
                                                                          .getMenuCartModel
                                                                          .data!
                                                                          .cartMenu![
                                                                              index]
                                                                          .dishName
                                                                          .toString(),
                                                                      Color(
                                                                          BLACK),
                                                                      16,
                                                                    ),
                                                              SizedBox(
                                                                height: 3,
                                                              ),
                                                              logic
                                                                          .getMenuCartModel
                                                                          .data
                                                                          ?.cartMenu?[
                                                                              index]
                                                                          .calclulatePrice ==
                                                                      null
                                                                  ? Text('')
                                                                  : WidgetText
                                                                      .widgetPoppinsMediumText(
                                                                      "\$" +
                                                                          "${logic.getMenuCartModel.data?.cartMenu![index].calclulatePrice}",
                                                                      Color(
                                                                          ORANGE),
                                                                      14,
                                                                    )
                                                            ],
                                                          ),
                                                        ),
                                                        // logic.isCartDeleted == false
                                                        logic
                                                                    .getMenuCartModel
                                                                    .data
                                                                    ?.cartMenu?[
                                                                        index]
                                                                    .itemDelete ==
                                                                false
                                                            ? InkWell(
                                                                child:
                                                                    Image.asset(
                                                                  ic_delete,
                                                                  width: 20,
                                                                  height: 20,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                                onTap:
                                                                    () async {
                                                                  setState(() {
                                                                    logic
                                                                        .getMenuCartModel
                                                                        .data
                                                                        ?.cartMenu?[
                                                                            index]
                                                                        .itemDelete = true;
                                                                  });
                                                                  if (logic
                                                                          .getMenuCartModel
                                                                          .data
                                                                          ?.cartMenu![
                                                                              index]
                                                                          .cartId !=
                                                                      null) {
                                                                    logic.deleteCartAPI(
                                                                        cartId: logic
                                                                            .getMenuCartModel
                                                                            .data!
                                                                            .cartMenu![
                                                                                index]
                                                                            .cartId
                                                                            .toString(),
                                                                        menuId: logic
                                                                            .getMenuCartModel
                                                                            .data!
                                                                            .cartMenu![index]
                                                                            .menuId
                                                                            .toString());
                                                                    /* if(logic.deleteCartModel.meta?.status == true){
                                                                      logic.getSPList(logic.getMenuCartModel.data!.cartMenu![index].menuId.toString());
                                                                    }*/
                                                                  }
                                                                },
                                                              )
                                                            : Center(
                                                                child: Container(
                                                                    height: 20,
                                                                    width: 20,
                                                                    child: CircularProgressIndicator(
                                                                      color: Color(
                                                                          ORANGE),
                                                                    )),
                                                              ),
                                                      ],
                                                    ),
                                                    Positioned(
                                                      right: 0,
                                                      bottom: 5,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                10, 3, 10, 3),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color(WHITE),
                                                          shape: BoxShape
                                                              .rectangle,
                                                          border: Border.all(
                                                              color: Color(
                                                                  BORDERCOLOR),
                                                              width: 1),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                        ),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            InkWell(
                                                              child:
                                                                  Image.asset(
                                                                ic_descrease,
                                                                width: 15,
                                                                height: 15,
                                                              ),
                                                              onTap: () async {
                                                                int selectedQty = logic.getMenuCartModel.data?.cartMenu?[index].selectQuantity ?? 0;
                                                                debugPrint("selectedQty  $selectedQty");
                                                                String restaurantId = logic.getMenuCartModel.data?.restaurantId??"";
                                                                String menuId = logic.getMenuCartModel.data?.cartMenu?[index].menuId??"";
                                                                if(selectedQty > 1){
                                                                  callDecAPI(restaurantId,menuId,logic);
                                                                }
                                                              },
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            logic.getMenuCartModel
                                                                        .data ==
                                                                    null
                                                                ? Text('1')
                                                                : WidgetText
                                                                    .widgetPoppinsMediumText(
                                                                    logic.getMenuCartModel.data?.cartMenu?[index]
                                                                        .selectQuantity
                                                                        .toString() ?? "",
                                                                    Color(
                                                                        BLACK),
                                                                    14,
                                                                  ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            InkWell(
                                                                child:
                                                                    Image.asset(
                                                                  ic_increase,
                                                                  width: 15,
                                                                  height: 15,
                                                                ),
                                                                onTap: () async {
                                                                  int selectedQty = logic.getMenuCartModel.data?.cartMenu?[index].selectQuantity ?? 0;
                                                                  debugPrint("selectedQty  $selectedQty");
                                                                  String restaurantId = logic.getMenuCartModel.data?.restaurantId??"";
                                                                  String menuId = logic.getMenuCartModel.data?.cartMenu?[index].menuId??"";

                                                                  await logic.incrementQtyApi(
                                                                      restaurantId: restaurantId,
                                                                      menuId: menuId,
                                                                      selectQty: 1);

                                                                  if(logic.getQtyUpdateModel.meta?.status ==true) {
                                                                    await logic
                                                                        .callGetCartAPI();
                                                                  }
                                                                }),
                                                          ],
                                                        ),
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
                                                              (logic.getMenuCartModel.data?.cartMenu?[index]
                                                                  .calclulateCalary
                                                                  .toString() ?? ""),
                                                              Color(BLACK),
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
                                                              (logic.getMenuCartModel.data?.cartMenu?[index]
                                                                      .calclulateFat
                                                                      .toString() ?? "") +
                                                                  "g",
                                                              Color(BLACK),
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
                                                              (logic.getMenuCartModel.data?.cartMenu?[index]
                                                                  .calclulateCarbs
                                                                  .toString() ?? "") +
                                                                  "g",
                                                              Color(BLACK),
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
                                                              (logic.getMenuCartModel.data?.cartMenu?[index]
                                                                      .calclulateProtein
                                                                      .toString() ?? "") +
                                                                  "g",
                                                              Color(BLACK),
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
                                                Divider(
                                                    height: 1,
                                                    thickness: 1,
                                                    color: Color(DIVIDERCOLOR)),
                                              ],
                                            );
                                          }),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      WidgetText.widgetPoppinsMediumText(
                                        "Total",
                                        Color(BLACK),
                                        16,
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
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 15, 0, 15),
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
                                                    caloriesTotal.toString(),
                                                    Color(BLACK),
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
                                                    fatTotal.toString() + "g",
                                                    Color(BLACK),
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
                                                    carbsTotal.toString() + "g",
                                                    Color(BLACK),
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
                                                    proteinTotal.toString() +
                                                        "g",
                                                    Color(BLACK),
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
                                      logic.couponApply == false
                                          ? InkWell(
                                              onTap: onClickApplyCoupon,
                                              child: Card(
                                                elevation: 5,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(WHITE),
                                                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                                  ),
                                                  padding: EdgeInsets.fromLTRB(
                                                      15, 15, 15, 15),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        ic_offer,
                                                        height: 22,
                                                        width: 22,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        child: WidgetText
                                                            .widgetPoppinsRegularText(
                                                          applyDeals,
                                                          Color(BLACK),
                                                          14,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Image.asset(
                                                        ic_left_side_arrow,
                                                        color: Color(BLACK),
                                                        height: 20,
                                                        width: 20,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      logic.removeCouponAvail == true
                                          ? InkWell(
                                              onTap: () {
                                                logic.deleteCouponAPI();
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 2000),
                                                    () {
                                                  if (logic.couponRemove ==
                                                      true) {
                                                    setState(() {
                                                      logic.removeCouponAvail =
                                                          false;
                                                    });
                                                  }
                                                });
                                              },
                                              child: Card(
                                                elevation: 5,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(WHITE),
                                                    borderRadius: BorderRadius.circular(12.0),
                                                  ),
                                                  padding: EdgeInsets.fromLTRB(
                                                      15, 15, 15, 15),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        ic_offer,
                                                        height: 22,
                                                        width: 22,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        child: WidgetText
                                                            .widgetPoppinsRegularText(
                                                          "Applied Deals ${logic.couponName}",
                                                          // "Remove Coupon",
                                                          Color(BLACK),
                                                          14,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Image.asset(
                                                        ic_close,
                                                        color: Color(ORANGE),
                                                        height: 20,
                                                        width: 20,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          : logic.removeCouponAvail == false
                                              ? Container()
                                              : Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Color(ORANGE),
                                                  ),
                                                ),
                                      SizedBox(
                                        height: 15,
                                      ),
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
                                                    alignment: Alignment.topLeft,
                                                    child: logic
                                                                .getMenuCartModel
                                                                .data
                                                                ?.cartMenu ==
                                                            null
                                                        ? Text('')
                                                        : WidgetText
                                                            .widgetPoppinsMediumText(
                                                           "Amount", Color(BLACK), 14,
                                                          ),
                                                  ),
                                                ),
                                                WidgetText
                                                    .widgetPoppinsMediumText(
                                                  logic.getMenuCartModel.subTotal == 0
                                                      ? "\$0"
                                                      : "\$" +
                                                      (logic.getMenuCartModel.subTotal?.toStringAsFixed(2) ?? "") ,
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
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: WidgetText
                                                        .widgetPoppinsMediumText(
                                                      "Tax",
                                                      Color(BLACK),
                                                      14,
                                                    ),
                                                  ),
                                                ),
                                                logic.getMenuCartModel
                                                            .taxAmount ==
                                                        null
                                                    ? Text("\$")
                                                    : WidgetText
                                                        .widgetPoppinsMediumText(
                                                        "\$" +
                                                            "${logic.getMenuCartModel.taxAmount.toStringAsFixed(2)}",
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
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: WidgetText
                                                        .widgetPoppinsMediumText(
                                                      "Discount",
                                                      Color(BLACK),
                                                      14,
                                                    ),
                                                  ),
                                                ),
                                                      logic.getMenuCartModel.discount == null
                                                    ? Text("\$")
                                                    : WidgetText
                                                        .widgetPoppinsMediumText(
                                                        "\$" +
                                                            (logic.getMenuCartModel.discount?.toStringAsFixed(2) ?? "") ,
                                                        Color(ORANGE),
                                                        14,
                                                      )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                        _orderTypeValue == 1 ? Container():
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
                                                      "Delivery Charges",
                                                      Color(BLACK),
                                                      14,
                                                    ),
                                                  ),
                                                ),
                                                logic.getMenuCartModel
                                                            .deliveryCharges ==
                                                        null
                                                    ? Text("\$")
                                                    : WidgetText
                                                        .widgetPoppinsMediumText(
                                                        "\$" +
                                                            "${(logic.getMenuCartModel.deliveryCharges?.toStringAsFixed(2) ?? "")}",
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
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: WidgetText
                                                        .widgetPoppinsMediumText(
                                                      "Total",
                                                      Color(BLACK),
                                                      16,
                                                    ),
                                                  ),
                                                ),
                                                logic.getMenuCartModel.total ==
                                                        null
                                                    ? Text("\$")
                                                    : WidgetText
                                                        .widgetPoppinsMediumText(
                                                        "\$" +
                                                            "${(logic.getMenuCartModel.total?.toStringAsFixed(2) ?? "")}",
                                                        // "${int.parse(subTotal.toString()) + int.parse(logic.getMenuCartModel.tax.toString()) + int.parse(logic.getMenuCartModel.deliveryCharges.toString())}",
                                                        Color(ORANGE),
                                                        16,
                                                      )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      WidgetButton.widgetDefaultButton(
                                          "Proceed to checkout", () {
                                        debugPrint('cartId: $cartId');
                                        debugPrint('addressId: $addressId');
                                        setState(() {
                                          var total = (logic.getMenuCartModel.total * 100).toInt();
                                          totalAmount = total;
                                          debugPrint('TotalAmount: $totalAmount');
                                        });
                                          // if (select24HoursTime != "") {
                                            debugPrint('dateSec: $dateSec');
                                            if (_orderType == 'DELIVERY') {
                                              // if (addressId != "" || addressId != null) {
                                              if (addressFound == true) {
                                                debugPrint('addressId: $addressId');
                                                  showEditServeDialog(
                                                      mContext: context,
                                                      addressId: addressId,
                                                      date: dateSec);
                                              } else {
                                                showToastMessage(
                                                    'Please add Address');
                                              }
                                            }else{
                                              debugPrint('orderType: $_orderType');
                                              showEditServeDialog(
                                                  mContext: context,
                                                  date: dateSec);
                                            }
                                          }/*else {
                                            showToastMessage(
                                                'Please add TimeSlot');
                                          }}*/
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  );
                      }),
                    ),
                  ],
                ),
              );
      })),
    );
  }

  Widget timeSlotAddress(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          WidgetText.widgetPoppinsMediumText(
            menuCartController.getMenuCartModel.data?.restaurant?.managerName ?? "",
            Color(BLACK),
            14,
          ),
          WidgetText.widgetPoppinsMediumText(
            menuCartController.getMenuCartModel.data?.restaurant?.managerMobile ??
                "",
            Color(DARKGREY),
            14,
          ),
          WidgetText.widgetPoppinsMediumText(
            menuCartController.getMenuCartModel.data?.restaurant?.restaurantAddress ?? "",
            Color(DARKGREY),
            14,
          ),
        ],
      ),
    );
  }

 /* Widget timeSlotCard(){
    return Expanded(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        WidgetText.widgetPoppinsMediumText(
          _orderTypeValue == 0 ? "Delivery Time" : "Pickup Time",
          // "Time slot",
          Color(BLACK),
          16,
        ),
        InkWell(
          onTap: () async {
            dynamic result =
            await pickupTimeOrderDialog(context, _orderTypeValue);
            setState(() {
              selectTime = result;
              debugPrint(
                  'Timing Result: $result , selectTime : $selectTime');
            });
          },
          child: Card(
            elevation: 1.5,
            color: Color(WHITE),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              alignment: Alignment.center,
              padding:
              EdgeInsets.all(10),
              child:
              WidgetText.widgetPoppinsRegularText(
                selectTime.toString(),
                Color(BLACK),
                14,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    ));
  }*/

  Widget timeSlotCard1(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        WidgetText.widgetPoppinsMediumText(
          _orderTypeValue == 0 ? "Delivery Time" : "Pickup Time",
          Color(BLACK),
          16,
        ),
        InkWell(
          onTap: () async {
            dynamic result =
            await pickupTimeOrderDialog(context,_orderTypeValue);
            setState(() {
              selectTime = result;
              debugPrint(
                  'Timing Result: $result , selectTime : $selectTime');
            });
          },
          child: Card(
            elevation: 4,
            child: Container(
              decoration: BoxDecoration(
                color: Color(WHITE),
                borderRadius: BorderRadius.all(Radius.circular(7.0)),
              ),
              width: MediaQuery.of(context).size.width / 2.5,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: WidgetText.widgetPoppinsRegularText(
                selectTime.toString(),
                Color(BLACK),
                14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  onClickChangeAddress(var cartId) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => AddressScreen(
            cartId, totalAmount, restaurantName, select24HoursTime)));
    setState(() {
      getSharedPrefs();
    });
  }

  onClickApplyCoupon() async {
    setState(() {
      totalAmount = menuCartController.getMenuCartModel.total;
      // subTotal = menuCartController.getMenuCartModel.calculateSubTotal;
    });
    debugPrint('Going to coupon screen');
    var result = await Get.to(() => CouponsCodeScreen(
        menuCartController.getMenuCartModel.data?.restaurantId ?? ""));
    if (!mounted) return;
    debugPrint('Result : $result');
    if (result == true) {
      menuCartController.callGetCartAPI();
    }
  }

  Future<dynamic> pickupTimeOrderDialog(BuildContext mContext, int isDelivery) async {
    DateRangePickerController _dateRangePickerController = DateRangePickerController();
    dynamic compareDate;
    compareDate = revFormatter.format(selectedDate);
    debugPrint('compareDate: $compareDate');

    await showDialog(
        context: mContext,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0)),
              child: GetBuilder<OrderCheckoutController>(builder: (logic) {
                return logic.isLoaderVisible
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Color(ORANGE),
                      ))
                    : Container(
                  decoration: BoxDecoration(
                    color: Color(WHITE),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                        padding: EdgeInsets.all(10),
                        child: ListView(
                          shrinkWrap: true,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                WidgetText.widgetPoppinsMediumText(
                                  "Select Date",
                                  Color(BLACK),
                                  16,
                                ),
                                InkWell(
                                  onTap: () async {
                                    setState((){
                                      selectedDate = DateTime.now();
                                      selectTime = "";
                                      selectedTimeIndex = 100;
                                      orderCheckoutController.resetTime();
                                      logic.isTimeAvail = false;
                                      // orderCheckoutController.checkTimeAvail(compareDate);
                                    });
                                    var date = new DateTime.now().millisecondsSinceEpoch;
                                    debugPrint('Date: $date');
                                    await orderCheckoutController.callGetSlotAPI(
                                        restaurantId:
                                        menuCartController.getMenuCartModel.data?.restaurantId ?? "",
                                        date: date.toString());
                                    Navigator.of(context).pop();
                                  },
                                  child: Image.asset(
                                    ic_close,
                                    color: Color(BLACK),
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                                height: MediaQuery.of(context).size.height / 2,
                                padding: EdgeInsets.all(0),
                                child: SfDateRangePicker(
                                  enablePastDates: false,
                                  view: DateRangePickerView.month,
                                  initialDisplayDate: DateTime.now(),
                                  // initialSelectedDate: DateTime.now(),
                                  initialSelectedDate: selectedDate,
                                  controller: _dateRangePickerController,
                                  selectionColor: Color(ORANGE),
                                  todayHighlightColor: Color(ORANGE),
                                  selectionMode: DateRangePickerSelectionMode.single,
                                  onSelectionChanged: (val){
                                    debugPrint('Val: ${val.value}');
                                    selectedDate = DateTime.parse(val.value.toString());
                                    debugPrint('selectedDate: $selectedDate'); // 2020-01-02 03:04:05.000
                                    dateSec = selectedDate.millisecondsSinceEpoch;
                                    debugPrint('dateSec: $dateSec');
                                    compareDate = revFormatter.format(selectedDate);
                                    debugPrint('compareDate: $compareDate');
                                    setState((){
                                      selectedTimeIndex = 100;
                                      logic.resetTime();
                                      logic.isTimeAvail = false;
                                    });
                                    logic.checkTimeAvail(compareDate);
                                  },
                                )),
                            Align(
                              alignment: Alignment.center,
                              child: WidgetText.widgetPoppinsMediumText(
                                isDelivery == 0 ?
                                "Set Delivery Time": "Set Pickup Time",
                                Color(BLACK),
                                18,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            logic.getSlotTypeModel.data?.length == 0
                                ? Center(
                                    child: Container(
                                    child: Text('Restaurant hasn\'t add any TimeSlot'),
                                  ))
                                : GridView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 5,
                                            mainAxisExtent: 70,
                                            mainAxisSpacing: 10),
                                    itemCount: logic.getSlotTypeModel.data?.length,
                                    // itemCount: timingList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {

                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            debugPrint(
                                                "now selected index ===>>> $index");
                                            selectedTimeIndex = index;

                                            if (logic.getSlotTypeModel.data?[index].isAvail == true) {
                                              select24HoursTime = logic.getSlotTypeModel.data?[index].combineTime ?? "";
                                              selectTime = logic.getSlotTypeModel.data?[index].combineTime ?? "";
                                            } else {
                                              showToastMessage('Selected Time is already passed');
                                            }
                                          });
                                        },
                                        child: Card(
                                          elevation: 5,
                                          color: Color(WHITE),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color:
                                              selectedTimeIndex ==
                                                      index && logic.getSlotTypeModel.data?[index].isAvail == true
                                                  ? Color(ORANGE) : logic.getSlotTypeModel.data?[index].isAvail == true ?
                                              Colors.transparent
                                                  :  Color(DIVIDERCOLOR),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              border: Border.all(
                                                color: selectedTimeIndex ==
                                                        index &&  logic.getSlotTypeModel.data?[index].isAvail == true
                                                    ? Color(ORANGE)
                                                    : Colors.transparent,
                                                width: 1.0,
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(10),
                                            child: WidgetText
                                                .widgetPoppinsRegularText(
                                              logic.getSlotTypeModel.data?[index].combineTime ?? "",
                                              // "9:00 AM - 11:00 AM",
                                              selectedTimeIndex ==
                                                      index && logic.getSlotTypeModel.data?[index].isAvail == true
                                                  ? Color(WHITE)
                                                  : Color(DARKGREY),
                                              12,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                            SizedBox(
                              height: 15,
                            ),
                            WidgetButton.widgetDefaultButton("Submit", () {
                              debugPrint('submit: $selectTime');
                              Navigator.of(context).pop(true);
                            }),
                          ],
                        ),
                      );
              }),
            );
          });
        });
    return selectTime;
  }

  void showEditServeDialog(
      {required BuildContext mContext,
       String? addressId,
      required dynamic date}) {
    TextEditingController spReqController = TextEditingController();

    showDialog(
        context: mContext,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(WHITE),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                // height: 200,
                padding: EdgeInsets.all(10),
                child: ListView(
                  shrinkWrap: true,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(WHITE),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: TextFormField(
                          controller: spReqController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Color(0xff8C8989),
                              fontSize: 14,
                              fontFamily: FontPoppins,
                              fontWeight: PoppinsRegular,
                            ),
                            hintText: "Special Requests",
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
                      height: 30,
                    ),
                    GetBuilder<PaymentController>(builder: (logic) {
                      return Row(
                        children: [
                          Expanded(
                              child: WidgetButton.widgetDefaultButton("Cancel",
                                  () {
                            Navigator.pop(context);
                          })),
                          SizedBox(
                            width: 10,
                          ),
                          logic.isPaymentPosted == false
                              ? Expanded(
                                  child: WidgetButton.widgetDefaultButton(
                                      "Submit", () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  // await Get.to(()=> LegacyTokenCardScreen());
                                    await Get.to(() => CardPaymentScreen(
                                          isGroupPayment: false,
                                          addressId: addressId ?? "",
                                          date: date.toString(),
                                          orderType: _orderType,
                                          spReq: spReqController.text,
                                          amount: totalAmount.toString(),
                                          timeSlot: select24HoursTime,
                                          restaurantName: restaurantName,
                                        ));
                                }))
                              : Center(
                                  child: CircularProgressIndicator(
                                  color: Color(ORANGE),
                                )),
                        ],
                      );
                    })
                  ],
                ),
              ),
            );
          });
        });
  }


  callDecAPI(String restaurantId, String menuId, MenuCartController logic) async {
    // debugPrint("_isDecrimentEnable  $_isDecrimentEnable");
    if(_isDecrimentEnable){
      _isDecrimentEnable=false;
      await logic.decrementQtyApi(restaurantId: restaurantId,
          menuId: menuId,
          selectQty: 1);

      if(logic.getQtyUpdateModel.meta?.status ==true) {
        await logic
            .callGetCartAPI();
        if(logic.getMenuCartModel.meta?.status == true) {

          setState(() {
            _isDecrimentEnable=true;
          });
        }
      }
    }
  }
}

import 'dart:convert';
import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_font_utils.dart';
import '../../../../core/utils/app_preferences.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import '../../../../core/widgets/widget_card.dart';
import '../../../group_orders/view/add_group_user_screen.dart';
import '../../../order_checkout/controller/order_checkout_controller.dart';
import '../../../order_checkout/controller/payment_controller.dart';
import '../../../order_checkout/view/online_card_screen.dart';
import '../../controller/group_order/view_group_order_controller.dart';
import 'dart:io' show Platform;

class ViewGroupOrderScreen extends StatefulWidget {
  dynamic groupId;

  ViewGroupOrderScreen({this.groupId});

  @override
  _ViewGroupOrderDialogScreenState createState() =>
      _ViewGroupOrderDialogScreenState();
}

class _ViewGroupOrderDialogScreenState extends State<ViewGroupOrderScreen> {
  final ViewGroupCartController viewGroupCartController =
      Get.put(ViewGroupCartController());
  dynamic goDataIndex, addressId, groupId, restaurantId, userId;
  final PaymentController paymentController = Get.put(PaymentController());
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());
  final OrderCheckoutController orderCheckoutController =
      Get.put(OrderCheckoutController());
  var deviceType;
  int? selectedTimeIndex;
  String selectTime = "";
  String select24HoursTime = "";
  dynamic date;
  String _orderType = "DELIVERY";
  DateTime selectedDate = DateTime.now();
  dynamic dateSec = DateTime.now().millisecondsSinceEpoch;

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  getSharedPrefs() async {
    if (_networkManager.connectionType != 0) {
      debugPrint('Connection Type: ${_networkManager.connectionType}');
      var data = await AppPreferences.getUserData();
      var userID = jsonEncode(data?.userId.toString());
      userId = userID.replaceAll(new RegExp(r'[^\w\s]+'), '');
      debugPrint('UserId ====> $userId');
      if (userId != null) {
        await viewGroupCartController.callViewGroupOrderAPI(
            groupId: widget.groupId, userId: userId);
        if (viewGroupCartController.viewGoCartModel.data?[0].isDelivery ==
            true) {
          _orderType = "DELIVERY";
          debugPrint('_orderType: $_orderType');
        } else {
          _orderType = "PICKUP";
          debugPrint('_orderType: $_orderType');
        }
      }
      addressId = await AppPreferences.getAddressId();
      debugPrint('ADDRESSID: $addressId');
      setState(() {
        if (Platform.isIOS) {
          deviceType = 'ios';
          debugPrint('DeviceType: $deviceType');
        } else if (Platform.isAndroid) {
          deviceType = 'android';
          debugPrint('DeviceType: $deviceType');
        }
      });
      if (addressId != null) {
        if (addressId != "") {
          debugPrint('AddressId not null');
          orderCheckoutController.callAddressDetailsAPI(
            addressId: addressId.toString(),
          );
        }
      } else {
        debugPrint('AddressId null');
        await orderCheckoutController.callGetAddressAPI();
        addressId = await AppPreferences.getAddressId();
      }
      date = DateTime.now().millisecondsSinceEpoch;
      debugPrint('date: $date');
      await orderCheckoutController.callGetSlotAPI(
          restaurantId: viewGroupCartController
                  .viewGoCartModel.data?[0].restaurantId
                  .toString() ??
              "",
          date: date.toString());
  /*    if (orderCheckoutController.getSlotTypeModel.meta?.status == true) {
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
      appBar: WidgetAppbar.simpleAppBar(context, "Group Order",false ),
      body: SafeArea(
        child: Container(
            child: GetBuilder<ViewGroupCartController>(builder: (logic) {
          return logic.isLoaderVisible
              ? Center(
                  child: CircularProgressIndicator(
                    color: Color(ORANGE),
                  ),
                )
              : logic.viewGoCartModel.meta?.status == false
                  ? Center(
                      child: Container(
                      child: Text('Group Cart Not Found'),
                    ))
                  : Card(
                      margin: EdgeInsets.all(20),
                      elevation: 5.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(WHITE),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: WidgetText.widgetPoppinsRegularText(
                                        "Your Group Order",
                                        Color(BLACK),
                                        20,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        WidgetText.widgetPoppinsMediumText(
                                          "Order from :",
                                          Color(GREY4),
                                          16,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.loose,
                                          child: WidgetText.widgetPoppinsBoldText(
                                            logic.viewGoCartModel.data?[0]
                                                    .restaurantName ??
                                                "",
                                            // "Vegan Vinnies",
                                            Color(GREY4),
                                            16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    logic.isAdmin == true
                                        ? Container(
                                            width: 200,
                                            alignment: Alignment.center,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(
                                                  Color(ORANGE),
                                                ),
                                                minimumSize: MaterialStateProperty
                                                    .all<Size>(
                                                  Size(double.maxFinite, 50.0),
                                                ),
                                              ),
                                              onPressed: () {
                                                if (groupId != null) {
                                                  Get.to(() => AddGroupScreen(
                                                        isViewGroup: true,
                                                        groupName: logic
                                                            .viewGoCartModel
                                                            .data?[0]
                                                            .restaurantName,
                                                        groupId: groupId,
                                                        restaurantId:
                                                            restaurantId,
                                                      ));
                                                }
                                              },
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    ic_plus,
                                                    height: 18,
                                                    width: 18,
                                                    color: Color(WHITE),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  WidgetText
                                                      .widgetPoppinsMediumText(
                                                    "Add Invitees",
                                                    Colors.white,
                                                    16,
                                                    align: TextAlign.end,
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    logic.isAdmin == true
                                        ? WidgetText.widgetPoppinsRegularText(
                                            "You can still invite people to your order!",
                                            Color(BLACK),
                                            14,
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    //set timeSlot
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: WidgetText.widgetPoppinsMediumText(
                                        "Time slot",
                                        Color(BLACK),
                                        16,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: InkWell(
                                        onTap: () async {
                                          // pickupTimeOrderDialog(context);
                                          dynamic result =
                                              await pickupTimeOrderDialog(
                                                  context);
                                          setState(() {
                                            // result = selectTimeSlot;
                                            selectTime = result;
                                            debugPrint(
                                                'Timing Result: $result , selectTime : $selectTime');
                                          });
                                        },
                                        child: Card(
                                          elevation: 5,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(WHITE),
                                              borderRadius: BorderRadius.circular(12.0),
                                            ),
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.fromLTRB(
                                                15, 15, 15, 15),
                                            child: WidgetText
                                                .widgetPoppinsRegularText(
                                              selectTime.toString(),
                                              Color(DARKGREY),
                                              16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        itemCount:
                                            logic.viewGoCartModel.data?.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          debugPrint(
                                              'restaurantName ===> ${logic.viewGoCartModel.data?[0].restaurantName}');

                                          groupId = logic
                                              .viewGoCartModel.data?[0].groupId;
                                          restaurantId = logic.viewGoCartModel.data?[0].restaurantId;

                                          goDataIndex = index;

                                          debugPrint('GoDataIndex: ${goDataIndex.toString()}');

                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(WHITE),
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    color: Color(ORANGE),
                                                    width: 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  WidgetText
                                                      .widgetPoppinsRegularText(
                                                    logic.viewGoCartModel
                                                            .data?[index].name ??
                                                        "",
                                                    // "Brittany(You)",
                                                    Color(BLACK),
                                                    20,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 7),
                                                      child: WidgetText
                                                          .widgetPoppinsRegularText(
                                                        "Items",
                                                        Color(BLACK),
                                                        16,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        itemCount: logic
                                                            .viewGoCartModel
                                                            .data?[goDataIndex]
                                                            .cartMenu
                                                            ?.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Column(
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(10),
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
                                                                  borderRadius: BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              10)),
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: <
                                                                          Widget>[
                                                                        Expanded(
                                                                          child: WidgetText
                                                                              .widgetPoppinsRegularOverflowText(
                                                                            logic.viewGoCartModel.data?[goDataIndex].cartMenu?[index].dishName ??
                                                                                "",
                                                                            // "Food Name ${index + 1}",
                                                                            Color(
                                                                                BLACK),
                                                                            16,
                                                                          ),
                                                                        ),
                                                                        logic.viewGoCartModel.data?[goDataIndex].cartMenu?[index].itemDelete ==
                                                                                false
                                                                            ? InkWell(
                                                                                onTap: () async {
                                                                                  setState(() {
                                                                                    logic.viewGoCartModel.data?[goDataIndex].cartMenu?[index].itemDelete = true;
                                                                                  });
                                                                                  // deleteCartAPI
                                                                                  dynamic cartId, userId;
                                                                                  userId = logic.viewGoCartModel.data?[goDataIndex].userId;
                                                                                  if (logic.viewGoCartModel.data?[goDataIndex].cartMenu?[index].cartId != null) {
                                                                                    cartId = logic.viewGoCartModel.data?[goDataIndex].cartMenu?[index].cartId;
                                                                                    await logic.deleteCartAPI(cartId: cartId, groupId: groupId, userId: userId);

                                                                                    Future.delayed(const Duration(milliseconds: 500), () {
                                                                                      if (logic.deleteCartModel.meta?.status == true) {
                                                                                        setState(() {
                                                                                          viewGroupCartController.callViewGroupOrderAPI(groupId: widget.groupId, userId: userId);
                                                                                          logic.viewGoCartModel.data?[goDataIndex].cartMenu?[index].itemDelete = false;
                                                                                        });
                                                                                      } else {
                                                                                        setState(() {
                                                                                          logic.viewGoCartModel.data?[goDataIndex].cartMenu?[index].itemDelete = false;
                                                                                        });
                                                                                      }
                                                                                    });
                                                                                  }
                                                                                },
                                                                                child: Image.asset(
                                                                                  ic_delete,
                                                                                  height: 18,
                                                                                  width: 18,
                                                                                  color: Color(RED),
                                                                                ),
                                                                              )
                                                                            : Center(
                                                                                child: Container(
                                                                                    height: 20,
                                                                                    width: 20,
                                                                                    child: CircularProgressIndicator(
                                                                                      color: Color(ORANGE),
                                                                                    )),
                                                                              ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: 10,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: <
                                                                          Widget>[
                                                                        WidgetText
                                                                            .widgetPoppinsRegularText(
                                                                          "Quantity",
                                                                          Color(
                                                                              GREY3),
                                                                          14,
                                                                        ),
                                                                        // logic.viewGoCartModel.data?[goDataIndex].cartMenu?[index].price == null
                                                                        logic.viewGoCartModel.data?[goDataIndex].cartMenu?[index].calclulatePrice ==
                                                                                null
                                                                            ? WidgetText
                                                                                .widgetPoppinsMediumText(
                                                                                "\$",
                                                                                Color(ORANGE),
                                                                                16,
                                                                              )
                                                                            : WidgetText
                                                                                .widgetPoppinsMediumText(
                                                                                "\$" + "${logic.viewGoCartModel.data?[goDataIndex].cartMenu?[index].calclulatePrice}",
                                                                                // logic.viewGoCartModel.data![goDataIndex].cartMenu![index].price.toString(),
                                                                                Color(ORANGE),
                                                                                16,
                                                                              )
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: <
                                                                          Widget>[
                                                                        WidgetText
                                                                            .widgetPoppinsRegularText(
                                                                          logic.viewGoCartModel.data?[goDataIndex].cartMenu?[index].selectQuantity.toString() ??
                                                                              "",
                                                                          Color(
                                                                              BLACK),
                                                                          14,
                                                                        ),
                                                                        WidgetText
                                                                            .widgetPoppinsMediumText(
                                                                          "(Amount)",
                                                                          Color(
                                                                              GREY3),
                                                                          13,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                            ],
                                                          );
                                                        }),
                                                  ),
                                                  logic.isAdmin == true
                                                      ? InkWell(
                                                          onTap: () async {
                                                            setState(() {
                                                              logic
                                                                  .viewGoCartModel
                                                                  .data?[
                                                                      goDataIndex]
                                                                  .userDelete = true;
                                                            });
                                                            // deleteCartAPI
                                                            dynamic userId;
                                                            userId = logic
                                                                .viewGoCartModel
                                                                .data?[
                                                                    goDataIndex]
                                                                .userId;
                                                            if (userId != null) {
                                                              await logic
                                                                  .deleteUserAPI(
                                                                      groupId:
                                                                          groupId,
                                                                      userId:
                                                                          userId);

                                                              Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          500),
                                                                  () {
                                                                if (logic
                                                                        .deleteCartModel
                                                                        .meta
                                                                        ?.status ==
                                                                    true) {
                                                                  setState(() {
                                                                    // viewGroupCartController.callViewGroupOrderAPI(groupId: widget.groupId, userId: userId);
                                                                    getSharedPrefs();
                                                                    logic
                                                                        .viewGoCartModel
                                                                        .data?[
                                                                            goDataIndex]
                                                                        .userDelete = false;
                                                                  });
                                                                } else {
                                                                  setState(() {
                                                                    logic
                                                                        .viewGoCartModel
                                                                        .data?[
                                                                            goDataIndex]
                                                                        .userDelete = false;
                                                                  });
                                                                }
                                                              });
                                                            }
                                                          },
                                                          child: logic
                                                                      .viewGoCartModel
                                                                      .data?[
                                                                          goDataIndex]
                                                                      .userDelete ==
                                                                  false
                                                              ? Container(
                                                                  margin: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              5),
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
                                                                    deleteUser,
                                                                    Color(WHITE),
                                                                    14,
                                                                  ),
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
                                                        )
                                                      : Container()
                                                ],
                                              ),
                                            ),
                                          );
                                        })
                                  ],
                                ),
                              ),
                            ),
                            logic.isAdmin == true
                                ? Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Flexible(
                                        flex: 5,
                                        fit: FlexFit.tight,
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 0, 5, 15),
                                          child: WidgetButton.widgetDefaultButton(
                                              "Checkout", () {
                                            debugPrint('groupId: ${widget.groupId}');
                                            debugPrint('addressId: $addressId');
                                            debugPrint('dateSec: $dateSec');
                                            debugPrint('totalAmount: ${logic.viewGoCartModel.total}');

                                            if (_orderType == 'DELIVERY') {
                                              if (addressId != "" ||
                                                  addressId != null) {
                                                // if (select24HoursTime != "") {
                                                  showEditServeDialog(
                                                      mContext: context,
                                                      date: dateSec,
                                                      groupId: widget.groupId,
                                                      amount: logic.totalAmount, addressId: addressId);
                                                } /*else {
                                                  showToastMessage('Please add TimeSlot');
                                                }}*/
                                               else {
                                                showToastMessage('Default Delivery Address not found');
                                              }
                                            } else {
                                              // if (select24HoursTime != "") {
                                                showEditServeDialog(
                                                    mContext: context,
                                                    date: dateSec,
                                                    groupId: widget.groupId,
                                                    amount: logic.totalAmount);
                                              // } else {
                                              //   showToastMessage(
                                              //       'Please add TimeSlot');
                                              // }
                                            }
                                          }),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 5,
                                        fit: FlexFit.tight,
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 15, 15),
                                          child: WidgetButton.widgetDefaultButton(
                                              "Cancel Group Order", () {
                                            debugPrint(
                                                'GroupCartId: ${logic.viewGoCartModel.data?[goDataIndex].groupId}');
                                            showCancelGroupOrderDialog(
                                                context,
                                                logic.viewGoCartModel
                                                    .data?[goDataIndex].groupId
                                                // "62eba0f795d0188c33c308a8"
                                                );
                                          }, bgColor: RED),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    );
        })),
      ),
    );
  }

  Future<dynamic> pickupTimeOrderDialog(BuildContext mContext) async {
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
                                        restaurantId: viewGroupCartController
                                            .viewGoCartModel.data?[0].restaurantId
                                            .toString() ??
                                            "",
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
                                // width: MediaQuery.of(context).size.width / 4,
                                padding: EdgeInsets.all(0),
                                child: SfDateRangePicker(
                                  enablePastDates: false,
                                  view: DateRangePickerView.month,
                                  initialDisplayDate: DateTime.now(),
                                  initialSelectedDate: DateTime.now(),
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
                                "Set Time Slot",
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
                                    child: Text(
                                        'Restaurant hasn\'t add any TimeSlot'),
                                  ))
                                : GridView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 5,
                                            mainAxisExtent: 70,
                                            mainAxisSpacing: 10),
                                    itemCount:
                                        logic.getSlotTypeModel.data?.length,
                                    // itemCount: timingList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                            /*          String start = DateFormat.jm().format(
                                          DateFormat("hh:mm").parse(
                                              orderCheckoutController
                                                  .getSlotTypeModel
                                                  .data![index]
                                                  .startTime
                                                  .replaceAll('.', ':')));
                                      String end = DateFormat.jm().format(
                                          DateFormat("hh:mm").parse(
                                              orderCheckoutController
                                                  .getSlotTypeModel
                                                  .data![index]
                                                  .endTime
                                                  .replaceAll('.', ':')));
                                      // debugPrint('start: $start, end: $end');

                                      selectTimeSlot = start + " - " + end;*/

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

                                          /*  dynamic startTime =
                                                orderCheckoutController
                                                    .getSlotTypeModel
                                                    .data?[index]
                                                    .startTime
                                                    .replaceAll('.', ':');
                                            dynamic endTime =
                                                orderCheckoutController
                                                    .getSlotTypeModel
                                                    .data?[index]
                                                    .endTime
                                                    .replaceAll('.', ':');

                                            if (start.isNotEmpty) {
                                              // debugPrint("compareTimecompareTime");
                                              // debugPrint("Inside TimeSlot ===>>> $startTime - $endTime");
                                              if (revFormatter.format(DateTime.now()) == compareDate) {
                                                statusOpen = isValidTimeRange(
                                                    startTime ?? "",
                                                    endTime ?? "");
                                                debugPrint('ISOPEN: $statusOpen');
                                              }else{
                                                debugPrint('Future date');
                                                statusOpen = true;
                                              }
                                            }

                                            if (statusOpen == true) {
                                              selectTimeSlot =
                                                  start + " - " + end;
                                              select24HoursTime =
                                                  startTime + "-" + endTime;
                                              debugPrint(
                                                  "now selectTimeSlot ===>>> $selectTimeSlot");
                                              debugPrint(
                                                  "now select24HoursTime ===>>> $select24HoursTime");
                                              selectTime = selectTimeSlot;
                                              debugPrint(
                                                  "now selectTime ===>>> $selectTime");
                                            } *//*else {
                                              showToastMessage('You cannot select that time');
                                            }*/
                                          });
                                        },
                                        child:  Card(
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

  void showCancelGroupOrderDialog(BuildContext context, dynamic groupId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Dialog(
              backgroundColor: Color(WHITE),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              //this right here
              child: Container(
                  height: 230,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
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
                      WidgetText.widgetPoppinsRegularText(
                        "Cancel Group Order?",
                        Color(BLACK),
                        18,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop(context);
                        },
                        child: WidgetText.widgetPoppinsRegularText(
                          "Keep Order",
                          Color(BLACK),
                          16,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GetBuilder<ViewGroupCartController>(builder: (logic) {
                        return logic.isOrderDeleted == false
                            ? InkWell(
                                onTap: () async {
                                  await logic.deleteGroupAPI(groupId: groupId);
                                  if (logic.deleteCartModel.meta?.status ==
                                      true) {
                                    debugPrint(
                                        'Delete Status : ${logic.deleteCartModel.meta?.status}');
                                    setState(() {
                                      Navigator.of(context).pop(context);
                                      AppPreferences.setGroupId("");
                                      // Navigator.of(context).pop(context);
                                      Navigator.of(context).pop(true);
                                    });
                                  } else {
                                    Navigator.of(context).pop(context);
                                  }
                                },
                                child: WidgetText.widgetPoppinsRegularText(
                                  "Cancel Order",
                                  Color(RED),
                                  16,
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                color: Color(ORANGE),
                              ));
                      }),
                    ],
                  )),
            );
          });
        });
  }

  void showEditServeDialog(
      {required BuildContext mContext,
      required String groupId,
      required dynamic date,
        String? addressId,
      dynamic amount}) {
    TextEditingController spReqController = TextEditingController();

    double total = double.parse(amount) * 100;

    debugPrint('total: $total');
    dynamic totalAmount = total.toInt();
    debugPrint('totalAmount Vivek: $totalAmount');

    showDialog(
        context: mContext,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                padding: EdgeInsets.all(10),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      elevation: 5,
                      color: Color(WHITE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: TextFormField(
                          controller: spReqController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Color(0xff8C8989),
                              fontSize: 16,
                              fontFamily: FontPoppins,
                              fontWeight: PoppinsRegular,
                            ),
                            hintText: "Enter your special request",
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
                                  // showToastMessage('Please Select Cash on Delivery');
                                    await Get.to(() => CardPaymentScreen(
                                          isGroupPayment: true,
                                          groupId: groupId,
                                          date: date.toString(),
                                          orderType: _orderType,
                                          spReq: spReqController.text,
                                          amount: totalAmount,
                                          addressId: addressId ?? "",
                                          timeSlot: select24HoursTime,
                                          restaurantName:
                                              viewGroupCartController
                                                  .viewGoCartModel
                                                  .data![0]
                                                  .restaurantName
                                                  .toString(),
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
}

/*class CustomDialogBox extends StatefulWidget {
  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            WidgetText.widgetPoppinsRegularText(
              "Cancel Group Order?",
              Color(BLACK),
              22,
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop(context);
              },
              child: WidgetText.widgetPoppinsRegularText(
                "Keep Order",
                Color(BLACK),
                18,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop(context);
                FoodDetailScreen.setIsGroupOrder(false);
                Navigator.of(context).pop(context);
                // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => FoodDetailScreen()));
              },
              child: WidgetText.widgetPoppinsRegularText(
                "Cancel Order",
                Color(RED),
                18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/

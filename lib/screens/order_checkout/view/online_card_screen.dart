import 'dart:convert';
import 'dart:io';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/http_utils/http_constants.dart';
import '../../../core/utils/app_color_utils.dart';
import '../../../core/utils/app_images_utils.dart';
import '../../../core/utils/app_preferences.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/widgets/widget_button.dart';
import '../../orders/view/group_order/track_group_order_screen.dart';
import '../../orders/view/normal_order/track_order_screen.dart';
import '../controller/payment_controller.dart';

class CardPaymentScreen extends StatefulWidget {
  bool isGroupPayment;
  dynamic
      date,
      spReq,
      orderType,
      amount,
      groupId,
      addressId,
      restaurantName, timeSlot;

  CardPaymentScreen(
      {required this.isGroupPayment,
      // required this.getMenuCartModel,
      this.groupId,
      this.addressId,
      required this.date,
      required this.spReq,
      required this.orderType,
      required this.amount,
      required this.restaurantName, this.timeSlot});

  @override
  _CardPaymentScreenState createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  final PaymentController paymentController = Get.put(PaymentController());
  dynamic stripeToken, deviceType, amount, orderType;
  bool isGroupPayment = false;
  // final controller = CardFormEditController();
  final controller = CardEditController();

  @override
  void initState() {
    getDeviceType();
    paymentController.tokenLoader = false;
    isGroupPayment = widget.isGroupPayment;
    debugPrint('isGroupPayment: $isGroupPayment');
    orderType = widget.orderType;
    amount = widget.amount.toString();
    debugPrint('amount: $amount');
    debugPrint('isGroupPayment: $isGroupPayment');
    super.initState();
  }

  getDeviceType(){
    setState(() {
      if(Platform.isIOS){
        deviceType = 'ios' ;
        print('DeviceType: $deviceType');
      }else if(Platform.isAndroid){
        deviceType = 'android' ;
        print('DeviceType: $deviceType');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.transparent, //change your color here
        ),
        toolbarHeight: 60,
        shadowColor: Colors.transparent,
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
              Flexible(
                child: WidgetText.widgetPoppinsRegularText(
                  "Card Payments",
                  Color(BLACK),
                  18,
                ),
                flex: 1,
                fit: FlexFit.tight,
              ),
            ],
          ),
        ),
      ),
      body: GetBuilder<PaymentController>(builder: (logic) {
        return Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: [

                CardField(
                  numberHintText: cardNumber,
                  onCardChanged: (card) {
                    setState(() {
                      logic.card = card;
                      debugPrint('Card: $card');
                      debugPrint('controller: $controller');
                    });
                  },
                ),
              SizedBox(height: 20),
              logic.tokenLoader
                  ? Center(
                      child: CircularProgressIndicator(
                      color: Color(ORANGE),
                    ))
                  : WidgetButton.widgetDefaultButton("Pay Online", () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      debugPrint('Pressed');
                      setState(() {
                        logic.tokenLoader = true;
                      });

                      debugPrint('card ==> ${logic.card?.toJson()}');
                      debugPrint('card completed? ==> ${logic.card?.complete}');
                      if (logic.card?.complete == true) {
                        await logic.handleCreateToken();

                        if (logic.tokenLoader == true) {
                          debugPrint('tokenData: ${logic.tokenData}');
                          stripeToken = logic.tokenData?.id.toString();
                          debugPrint('StripeToken: $stripeToken');
                          if (stripeToken != null) {
                            if (isGroupPayment == false) {
                              late Map<String, String> params;
                              late dynamic mapParams;

                                params = <String, String>{
                                  HttpConstants.PARAMS_PAYMENTMETHOD: online,
                                  HttpConstants.PARAMS_DELIVERYDATE: widget.date,
                                  HttpConstants.PARAMS_DEVICETYPE: deviceType,
                                  HttpConstants.PARAMS_SPREQUEST: widget.spReq,
                                  HttpConstants.PARAMS_ORDERTYPE: widget.orderType,
                                  HttpConstants.PARAMS_STRIPE_TOKEN: stripeToken,
                                  HttpConstants.PARAMS_TOKEN_AMT: amount,
                                };
                              if(orderType == 'DELIVERY') {
                                params[HttpConstants.PARAMS_ADDRESSID] = widget.addressId;
                              }

                              if(widget.timeSlot.toString().isNotEmpty){
                                params[HttpConstants.PARAMS_TIMESLOT] = widget.timeSlot ?? "";
                              }

                              print('Params: $params');
                              mapParams = jsonEncode(params);
                              print('MapParams: $mapParams');
                              await logic.postNormalOrderOnlineApi(
                                  params: mapParams);
                              if (logic.isPaymentPosted == true) {
                                final prefs =
                                await SharedPreferences.getInstance();
                                prefs.setString(PREF_CUSTOMCARTLIST, "");
                                debugPrint('menuOrderId: ${logic.menuOrderId}');
                                setState(() {
                                  logic.isPaymentPosted = false;
                                  Navigator.pop(context);
                                  logic.tokenLoader = false;

                                  removeGroupId();
                                  navigateOrderDetails(logic.menuOrderId);
                                 /* Get.to(() => CheckoutSuccessScreen(
                                    restaurantName: widget.restaurantName,
                                    orderId: logic.menuOrderId,
                                    isNormalOrder: true,
                                  ));*/
                                });
                              } else {
                                setState(() {
                                  logic.tokenLoader = false;
                                });
                              }

                            } else {
                              late Map<String, String> params;
                              late dynamic mapParams;

                              params = <String, String>{
                                HttpConstants.PARAMS_GROUPID: widget.groupId,
                                HttpConstants.PARAMS_PAYMENTMETHOD: online,
                                HttpConstants.PARAMS_DELIVERYDATE: widget.date,
                                HttpConstants.PARAMS_DEVICETYPE: deviceType,
                                HttpConstants.PARAMS_SPREQUEST: widget.spReq,
                                HttpConstants.PARAMS_ORDERTYPE: widget.orderType,
                                HttpConstants.PARAMS_STRIPE_TOKEN: stripeToken,
                                HttpConstants.PARAMS_TOKEN_AMT: amount,
                              };

                              if(orderType == 'DELIVERY') {
                                params[HttpConstants.PARAMS_ADDRESSID] = widget.addressId;
                              }

                              if(widget.timeSlot.toString().isNotEmpty){
                                params[HttpConstants.PARAMS_TIMESLOT] = widget.timeSlot ?? "";
                              }

                              debugPrint('Params: $params');
                              mapParams = jsonEncode(params);
                              debugPrint('MapParams: $mapParams');

                              await logic.postGroupCartCheckoutApi(
                                  params: mapParams);
                              if (logic.isPaymentPosted == true) {
                                setState(() {
                                  logic.isPaymentPosted = false;
                                  Navigator.pop(context);
                                  logic.tokenLoader = false;
                                  // Get.offAll(() => BaseApplication());
                                  removeGroupId();
                                  navigateGroupTrackDetails(logic.groupOrderId);

                                 /* Get.to(() => CheckoutSuccessScreen(
                                        restaurantName: widget.restaurantName,
                                    orderId: logic.groupOrderId,
                                     isNormalOrder: false,
                                      ));*/
                                });
                              } else {
                                setState(() {
                                  logic.tokenLoader = false;
                                });
                              }
                            }
                          } else {
                            showToastMessage('Token not generated');
                          }
                        }
                      }
                    }),
            ],
          ),
        );
      }),
    );
  }


  navigateOrderDetails(dynamic orderID) {
    if (orderID.isNotEmpty) {
      if (orderID != null) {
        debugPrint('MenuOrderid not null: ${orderID}');
        Get.to(() =>
            TrackOrderScreen(
              orderId: orderID.toString(),
              isNormalOrder: false,
            ));
      }
    }
  }

  navigateGroupTrackDetails(dynamic orderID) {
    if (orderID.isNotEmpty) {
      if (orderID != null) {
        debugPrint('MenuOrderid not null: ${orderID}');
          Get.to(()=> TrackGroupOrderScreen(orderId:  orderID.toString(), isGroupOrder: false,));
      }
    }
  }


  removeGroupId() {
    setState(() {
      AppPreferences.setGroupId("");
    });
  }
}

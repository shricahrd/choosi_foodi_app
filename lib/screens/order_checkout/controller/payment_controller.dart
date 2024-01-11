import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../core/http_utils/http_post_util.dart';
import '../../../core/utils/app_constants.dart';
import '../../../routes/general_path.dart';
import '../../cart/model/delete_cart_model.dart';
import '../model/place_go_model.dart';
import '../model/place_order_model.dart';

class PaymentController extends GetxController {
  DeleteCartModel deleteCartModel = DeleteCartModel();
  PlaceOrderModel paymentModel = PlaceOrderModel();
  PlaceGOModel placeGOModel = PlaceGOModel();
  bool isPaymentPosted = false;
  Map<String, dynamic>? paymentIntentData;
  CardFieldInputDetails? card;
  TokenData? tokenData;
  bool tokenLoader = false;
  String menuOrderId = "";
  String groupOrderId = "";

  Future<void> postNormalOrderOnlineApi({required final params}) async{
    await postRequest(GeneralPath.API_NORMAL_ORDER_ONLINE, params).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        paymentModel = PlaceOrderModel.fromJson(mResponse);
        if (paymentModel.meta?.status == true) {
          // showToastMessage(deleteCartModel.meta!.msg.toString());
          debugPrint('status in Controller: ${paymentModel.meta?.status}');
          isPaymentPosted = true;
          menuOrderId = paymentModel.data?.menuOrderId ?? "";
          debugPrint('menuOrderId: $menuOrderId');
          update();
        }else{
          debugPrint('response msg: ${paymentModel.meta?.msg ?? ""}');
          showToastMessage(paymentModel.meta?.msg ?? "");
          isPaymentPosted = false;
          update();
        }
        update();
      } else {
        showToastMessage(paymentModel.meta?.msg ?? "");
        isPaymentPosted = false;
        update();
      }
      update();
      return paymentModel;
    });
  }

  Future<void> handleCreateTokenPress({required String city, required String country, required String line1,  required String line2,required String state, required String postalCode}) async {
    if (card == null) {
      return;
    }
    try {
      // 1. Gather customer billing information (ex. email)
      final address = Address(
        city: city,
        country: country,
        line1: line1,
        line2: line2,
        state: state,
        postalCode: postalCode,
      ); // mocked data for tests

      debugPrint('address: $address');

      // 2. Create payment method
      final tokenData = await Stripe.instance.createToken(CreateTokenParams.card(
          params: CardTokenParams(
              address: address,
              currency: 'USD'
          )));
        this.tokenData = tokenData;
        debugPrint('tokenData bedore if: $tokenData');
        if(tokenData != null){
          debugPrint('tokenData: $tokenData');
          tokenLoader = true;
          update();
        }
       update();
        debugPrint('Success: The token was created successfully!');
        debugPrint('TokenResponse: $tokenData');
        debugPrint('TokenResponse Id: ${tokenData.id}');
        // showToastMessage('Success: The token was created successfully!');
      return;
    } catch (e) {
      tokenLoader = false;
      update();
      showToastMessage('Error: $e');
      rethrow;
    }
  }

  Future<void> handleCreateToken() async {
    if (card == null) {
      return;
    }
    try {

      // 2. Create payment method
      final tokenData = await Stripe.instance.createToken(CreateTokenParams.card(
          params: CardTokenParams(
              currency: 'USD',
          )));
      this.tokenData = tokenData;
      debugPrint('tokenData before if: $tokenData');
      if(tokenData != null){
        debugPrint('tokenData: $tokenData');
        tokenLoader = true;
        update();
      }
      update();
      debugPrint('Success: The token was created successfully!');
      debugPrint('TokenResponse: $tokenData');
      debugPrint('TokenResponse Id: ${tokenData.id.toString()}');
      // showToastMessage('Success: The token was created successfully!');
      return;
    } catch (e) {
      tokenLoader = false;
      update();
      showToastMessage('Error: $e');
      rethrow;
    }
  }

 /* Future<void> handleApplePay() async {
    try {
      debugPrint('In try method');
      Map<String, dynamic> params = {
        "currency": 'USD'
      };
      debugPrint('params: $params');
      // 2. Create payment method
      final tokenData = await Stripe.instance.createApplePayToken(params);
      this.tokenData = tokenData;
      debugPrint('tokenData before if: $tokenData');
      if(tokenData != null){
        debugPrint('tokenData: $tokenData');
        tokenLoader = true;
        update();
      }
      update();
      debugPrint('Success: The token was created successfully!');
      debugPrint('TokenResponse: $tokenData');
      debugPrint('TokenResponse Id: ${tokenData.id}');
      // showToastMessage('Success: The token was created successfully!');
      return;
    } catch (e) {
      tokenLoader = false;
      update();
      showToastMessage('Error: $e');
      rethrow;
    }
  }*/

  Future<void> postGroupCartCheckoutApi({required final params}) async{
    await postRequest(GeneralPath.API_GROUP_CHECKOUT, params).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        placeGOModel = PlaceGOModel.fromJson(mResponse);
        if (placeGOModel.meta?.status == true) {
          // showToastMessage(deleteCartModel.meta!.msg.toString());
          debugPrint('status in Controller: ${placeGOModel.meta?.status}');
          groupOrderId = placeGOModel.data?.groupOrderId ?? "";
          debugPrint('groupOrderId: $groupOrderId');
          isPaymentPosted = true;
          update();
        }else{
          showToastMessage(placeGOModel.meta?.msg.toString() ?? "");
          isPaymentPosted = false;
          update();
        }
        update();
      } else {
        showToastMessage(placeGOModel.meta?.msg ?? "");
        isPaymentPosted = false;
        update();
      }
      update();
      return placeGOModel;
    });
  }
}

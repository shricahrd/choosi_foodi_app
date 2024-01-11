import 'dart:convert';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:choosifoodi/screens/restaurants_panel/order/model/order_restaurant_details_model.dart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../model/group_order_details_model.dart';

class GORestDetailsController extends GetxController {
  bool isViewOrderVisible = true;
  GORestDetailsModel viewDetailsModel = GORestDetailsModel();
  String orderPlacedDate = "", deliveryDate = "-", deliveryAddress = "", pincode = "";

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String parseTimeOrderPlaced(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterMonth.format(date);
    orderPlacedDate = d12;
    debugPrint('orderPlacedDate: $orderPlacedDate');
    return d12;
  }

  String parseTimeStampDeliveryDate(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterMonth.format(date);
    deliveryDate = d12;
    debugPrint('deliveryDate: $deliveryDate');
    return d12;
  }

  callViewOrderDetailsAPI(String orderId) {
    getRequest(GeneralPath.API_REST_GROUP_ORDER_DETAILS + orderId).then((response) {

      if (response.statusCode == 200) {
        viewDetailsModel = GORestDetailsModel.fromJson(json.decode(response.body));
        if (viewDetailsModel.meta?.status == true) {
          print('status true: ${viewDetailsModel.meta?.status}');
          print('Response Data: ${viewDetailsModel.data}');

          if(viewDetailsModel.data?.userData.createdAt == 0){
            orderPlacedDate = "";
          }else {
            parseTimeOrderPlaced(int.parse(viewDetailsModel.data?.createdAt.toString() ?? ""));
          }

          if(viewDetailsModel.data?.deliveryDate == 0){
            deliveryDate = "-";
          }else {
            parseTimeStampDeliveryDate(
                int.parse(viewDetailsModel.data?.deliveryDate.toString() ?? ""));
          }

          for(int i = 0; i< (viewDetailsModel.data?.productDetails.length ?? 0); i++) {
            for(int j = 0; j< (viewDetailsModel.data?.productDetails[i].cartMenu.length ?? 0); j++) {
              int selectedPrice =
                  (viewDetailsModel.data?.productDetails[i].cartMenu[j].selectQuantity ?? 0) *
                      (viewDetailsModel.data?.productDetails[i].cartMenu[j].price ?? 0);

              viewDetailsModel.data?.productDetails[i].cartMenu[j].setPrice = selectedPrice;
              debugPrint('Total Price : ${viewDetailsModel.data?.productDetails[i].cartMenu[j].price}');
            }
          }

         /* String addressLine1 = "", addressLine2 = "", city = "", state = "", country = "";
            if(viewDetailsModel.data?.paymentDetails.billingDetails.address.line1 != null && viewDetailsModel.data?.paymentDetails.billingDetails.address.line1.isNotEmpty) {
              addressLine1 = (viewDetailsModel.data?.paymentDetails.billingDetails.address.line1.toString() ?? "") + " ";
              debugPrint('addressLine1: $addressLine1');
          }else{
              addressLine1 = "";
            }

          if(viewDetailsModel.data?.paymentDetails.billingDetails.address.line2 != null && viewDetailsModel.data?.paymentDetails.billingDetails.address.line2.isNotEmpty){
              addressLine2 =
                  (viewDetailsModel.data?.paymentDetails.billingDetails.address.line2.toString() ?? "") + ", ";
          }else{
            addressLine2 = "";
          }

          if(viewDetailsModel.data?.paymentDetails.billingDetails.address.city != null && viewDetailsModel.data?.paymentDetails.billingDetails.address.city.isNotEmpty){
              city =
                  (viewDetailsModel.data?.paymentDetails.billingDetails.address.city.toString() ?? "") + ", ";
          }else{
            city= "";
          }

          if(viewDetailsModel.data?.paymentDetails.billingDetails.address.state != null && viewDetailsModel.data?.paymentDetails.billingDetails.address.state.isNotEmpty){
              state =
                  viewDetailsModel.data!.paymentDetails.billingDetails.address.state.toString() + ", ";
          }else{
            state = "";
          }

          if(viewDetailsModel.data?.paymentDetails.billingDetails.address.country != null && viewDetailsModel.data?.paymentDetails.billingDetails.address.country.isNotEmpty){
              country = viewDetailsModel.data!.paymentDetails.billingDetails.address.country.toString();
          }else{
            country = "";
          }

          if(viewDetailsModel.data?.paymentDetails.billingDetails.address.postalCode != null && viewDetailsModel.data?.paymentDetails.billingDetails.address.postalCode.isNotEmpty){
              pincode = (viewDetailsModel.data?.paymentDetails.billingDetails.address.postalCode.toString() ?? "");
          }else{
            pincode = "";
          }

          deliveryAddress = addressLine1 + addressLine2 + city + state + country;
          debugPrint('deliveryAddress: $deliveryAddress');
          // update();
*/
          isViewOrderVisible = false;
          // update();
        }else{
          showToastMessage(viewDetailsModel.meta?.msg.toString() ?? "");
          isViewOrderVisible = false;
          // update();
        }
      } else {
        showToastMessage(viewDetailsModel.meta?.msg.toString() ?? "");
        isViewOrderVisible = true;
        // update();
        throw Exception('Failed to load data.');
      }
      update();
    });
  }

}

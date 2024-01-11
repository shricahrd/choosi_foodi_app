import 'dart:convert';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../../model/normal_order/view_order_details_model.dart';

class MenuOrderDetailsController extends GetxController {
  bool isViewOrderVisible = true;
  ViewOrderDetailsModel viewDetailsModel = ViewOrderDetailsModel();
  String orderPlacedDate = "";
  String deliveryDate = "";
  String deliveryAddress = "";
  String name = "";
  double caloriesTotal = 0.0;
  double fatTotal = 0.0;
  double carbsTotal = 0.0;
  double proteinTotal = 0.0;
  dynamic orderStatusVal;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    carbsTotal = 0.0;
    fatTotal = 0.0;
    carbsTotal = 0.0;
    proteinTotal = 0.0;
    super.dispose();
  }

  String parseTimeStampReport(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    // var d12 = formatterShortMonth.format(date);
    var d12 = formatterMonth.format(date);
    orderPlacedDate = d12;
    debugPrint('orderPlacedDate: $orderPlacedDate');
    return d12;
  }

  String parseTimeStampDeliveryDate(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    // var d12 = formatterShortMonth.format(date);
    // var d12 = formatterMonth.format(date);
    var d12 = formatterMonthWithTime.format(date);
    deliveryDate = d12;
    debugPrint('deliveryDate: $orderPlacedDate');
    return d12;
  }

  Future<void> callViewOrderDetailsAPI(String orderId) async{
    await getRequest(GeneralPath.API_VIEW_ORDER + orderId).then((response) {

      if (response.statusCode == 200) {
        viewDetailsModel = ViewOrderDetailsModel.fromJson(json.decode(response.body));
        if (viewDetailsModel.meta?.status == true) {
          debugPrint('status true: ${viewDetailsModel.meta?.status}');
          debugPrint('Response Data: ${viewDetailsModel.data}');
          if(viewDetailsModel.data?.createdAt == ""){
            orderPlacedDate = "";
          }else {
            // debugPrint('created date: ${viewDetailsModel.data!.restaurantData!.createdAt}');
            parseTimeStampReport(
                int.parse(viewDetailsModel.data!.createdAt.toString()));
          }

          if(viewDetailsModel.data?.deliveryDate == ""){
            deliveryDate = "";
          }else {
            debugPrint('deliveryDate api: ${viewDetailsModel.data?.deliveryDate}');
            parseTimeStampDeliveryDate(
                int.parse(viewDetailsModel.data!.deliveryDate.toString()));
          }

          orderStatusVal =  getOrderStatus(viewDetailsModel.data?.orderStatus ?? 0);
          debugPrint('orderStatusVal: $orderStatusVal');

          for(int i = 0; i< (viewDetailsModel.data?.productDetails?.length ?? 0); i++) {
            double result1, result2, result3, result4;
            if (viewDetailsModel.data?.productDetails?[i].calories?.isNotEmpty == true) {
            if (viewDetailsModel.data?.productDetails?[i].calories != null) {
                 result1 = double.parse(viewDetailsModel.data!.productDetails?[i].calories.toString() ?? "")
                    * (double.parse(viewDetailsModel.data!.productDetails?[i].selectQuantity.toString() ?? ""));
                caloriesTotal = caloriesTotal + result1;
                 viewDetailsModel.data?.productDetails?[i].setCaloriesTotal = caloriesTotal;
                debugPrint('CaloriesTotal: $caloriesTotal');
                update();
              } else {
                result1 = 0.0;
                caloriesTotal = caloriesTotal  + result1;
                viewDetailsModel.data?.productDetails?[i].setCaloriesTotal = caloriesTotal;
                update();
              }
            } else {
              result1 = 0.0;
              caloriesTotal = caloriesTotal  + result1;
              viewDetailsModel.data?.productDetails?[i].setCaloriesTotal = caloriesTotal;
              update();
            }

              if (viewDetailsModel.data?.productDetails?[i].fat?.isNotEmpty == true) {
                if (viewDetailsModel.data?.productDetails?[i].fat != null) {
                 result2 = double.parse(
                    viewDetailsModel.data?.productDetails?[i].fat.toString() ?? "")
                    * (double.parse(
                        viewDetailsModel.data?.productDetails?[i].selectQuantity.toString() ?? ""));
                fatTotal = fatTotal + result2;
                 viewDetailsModel.data?.productDetails?[i].setFatTotal = fatTotal;
                update();
              } else {
                result2 = 0.0;
                viewDetailsModel.data?.productDetails?[i].setFatTotal = result2;
                update();
              }
            } else {
              result2 = 0.0;
              viewDetailsModel.data?.productDetails?[i].setFatTotal = result2;
              update();
            }

            if (viewDetailsModel.data?.productDetails?[i].carbs?.isNotEmpty == true) {
              if (viewDetailsModel.data?.productDetails?[i].carbs != null) {
                 result3 = double.parse(
                    viewDetailsModel.data?.productDetails?[i].carbs.toString() ?? "")
                    * (double.parse(
                        viewDetailsModel.data?.productDetails?[i].selectQuantity.toString() ?? ""));
                carbsTotal = carbsTotal + result3;
                 viewDetailsModel.data?.productDetails?[i].setCarbsTotal = carbsTotal;
                update();
              } else {
                result3 = 0.0;
                viewDetailsModel.data?.productDetails?[i].setCarbsTotal = result3;
                update();
              }
            } else {
              result3 = 0.0;
              viewDetailsModel.data?.productDetails?[i].setCarbsTotal = result3;
              update();
            }

            if (viewDetailsModel.data?.productDetails?[i].protein?.isNotEmpty == true) {
              if (viewDetailsModel.data?.productDetails?[i].protein != null) {
                 result4 = double.parse(
                    viewDetailsModel.data?.productDetails?[i].protein.toString() ?? "")
                    * (double.parse(
                        viewDetailsModel.data?.productDetails?[i].selectQuantity.toString() ?? ""));
                proteinTotal = proteinTotal + result4;
                 viewDetailsModel.data?.productDetails?[i].setProteinTotal = proteinTotal;
                update();
              } else {
                result4 = 0.0;
                viewDetailsModel.data?.productDetails?[i].setProteinTotal = result4;
                update();
              }
            } else {
              result4 = 0.0;
              viewDetailsModel.data?.productDetails?[i].setProteinTotal = result4;
              update();
            }
          }


          String addressLine1 = "", landmark = "", city = "", state = "", pincode = "";
          if(viewDetailsModel.data?.shippingAddress?.addressLine1 != null){
            addressLine1 = (viewDetailsModel.data!.shippingAddress?.addressLine1.toString() ?? "") + ", ";
            debugPrint('addressLine1: $addressLine1');
          }
          if(viewDetailsModel.data?.shippingAddress?.landmark != null){
            landmark = viewDetailsModel.data!.shippingAddress!.landmark.toString() + ", ";
          }
          if(viewDetailsModel.data?.shippingAddress?.cityName != null){
            city = (viewDetailsModel.data!.shippingAddress?.cityName.toString() ?? "") + ", ";
          }
          if(viewDetailsModel.data?.shippingAddress?.stateName != null){
            state = (viewDetailsModel.data!.shippingAddress?.stateName.toString() ?? "") + ", ";
          }
          if(viewDetailsModel.data?.shippingAddress?.pincode != null){
            pincode = (viewDetailsModel.data!.shippingAddress?.pincode.toString() ?? "") + ", ";
          }

          deliveryAddress = addressLine1 + landmark + city + state + pincode;
          debugPrint('deliveryAddress: $deliveryAddress');
          update();
          // debugPrint('deliveryAddress: $deliveryAddress');

          if(viewDetailsModel.data?.shippingAddress?.name != null){
            name = (viewDetailsModel.data!.shippingAddress?.name.toString() ?? "") + ", ";
            debugPrint('Name: $name');
            update();
          }

          isViewOrderVisible = false;
          update();
        }else{
          showToastMessage(viewDetailsModel.meta?.msg.toString() ?? "");
          isViewOrderVisible = false;
          update();
        }
      } else {
        showToastMessage(viewDetailsModel.meta?.msg.toString() ?? "");
        isViewOrderVisible = true;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return viewDetailsModel;
    });
  }

}

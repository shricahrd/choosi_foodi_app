import 'dart:convert';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../../model/group_order/get_go_details_model.dart.dart';

class GroupOrderDetailsController extends GetxController {
  bool isViewOrderVisible = true;
  GetGODetailsModel groupOrderDetailsModel = GetGODetailsModel();
  String orderPlacedDate = "";
  String deliveryDate = "";
  String deliveryAddress = "";
  String name = "";
  dynamic orderStatusVal;

  String parseTimeStampReport(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterMonth.format(date);
    orderPlacedDate = d12;
    debugPrint('orderPlacedDate: $orderPlacedDate');
    return d12;
  }

  String parseTimeStampDeliveryDate(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    // var d12 = formatterMonth.format(date);
    var d12 = formatterMonthWithTime.format(date);
    deliveryDate = d12;
    debugPrint('deliveryDate: $deliveryDate');
    return d12;
  }

  Future<void> callViewOrderDetailsAPI(String orderId) async{
    await getRequest(GeneralPath.API_GROUP_DETAILS_LIST + orderId).then((response) {

      if (response.statusCode == 200) {
        groupOrderDetailsModel = GetGODetailsModel.fromJson(json.decode(response.body));
        if (groupOrderDetailsModel.meta?.status == true) {
          debugPrint('status true: ${groupOrderDetailsModel.meta?.status}');
          debugPrint('Response Data: ${groupOrderDetailsModel.data}');
          if(groupOrderDetailsModel.data?.createdAt == 0){
            orderPlacedDate = "";
          }else {
            parseTimeStampReport(
                int.parse(groupOrderDetailsModel.data!.createdAt.toString()));
          }
          if(groupOrderDetailsModel.data?.deliveryDate == 0){
            deliveryDate = "";
          }else {
            debugPrint('deliveryDate: ${groupOrderDetailsModel.data?.deliveryDate.toString()}');
            parseTimeStampDeliveryDate(
                int.parse(groupOrderDetailsModel.data?.deliveryDate.toString() ?? ""));
          }

          if(groupOrderDetailsModel.data?.shippingAddress != null){
            deliveryAddress = groupOrderDetailsModel.data?.shippingAddress.toString() ?? "";
            debugPrint('deliveryAddress: $deliveryAddress');
          }

          orderStatusVal =  getOrderStatus(groupOrderDetailsModel.data?.orderStatus ?? 0);
          debugPrint('orderStatusVal: $orderStatusVal');

          for(int i = 0; i< (groupOrderDetailsModel.data?.productDetails.length ?? 0); i++) {
          for(int j = 0; j< (groupOrderDetailsModel.data?.productDetails[i].cartMenu.length ?? 0); j++) {
            dynamic caloriesTotal = 0.0;
            dynamic fatTotal = 0.0;
            dynamic carbsTotal = 0.0;
            dynamic proteinTotal = 0.0;
            // double result1, result2, result3, result4;
            if (groupOrderDetailsModel.data?.productDetails[i].cartMenu[j].calories.isNotEmpty == true) {
              var result1 = double.parse(
                  groupOrderDetailsModel.data?.productDetails[i].cartMenu[j].calories.toString() ?? "")
                  * (double.parse(
                      groupOrderDetailsModel.data?.productDetails[i].cartMenu[j].selectQuantity.toString() ?? ""));
              caloriesTotal = caloriesTotal + result1;
              groupOrderDetailsModel.data?.productDetails[i].cartMenu[j].setCaloriesTotal = caloriesTotal;
              debugPrint('calorie: ${groupOrderDetailsModel.data?.productDetails[i].cartMenu[j].calories}');
              debugPrint('select: ${ groupOrderDetailsModel.data?.productDetails[i].cartMenu[j].selectQuantity}');
              debugPrint('CaloriesTotal: $caloriesTotal');
              update();
            } else {
              caloriesTotal = 0.0;
              groupOrderDetailsModel.data?.productDetails[i].cartMenu[j].setCaloriesTotal = caloriesTotal;
              update();
            }

            if (groupOrderDetailsModel.data?.productDetails[i].cartMenu[j].fat.isNotEmpty == true) {
              var result2 = double.parse(
                  groupOrderDetailsModel.data?.productDetails[i].cartMenu[j].fat.toString() ?? "")
                  * (double.parse(
                      groupOrderDetailsModel.data?.productDetails[i].cartMenu[j].selectQuantity.toString() ?? ""));
              fatTotal = fatTotal + result2;
              groupOrderDetailsModel.data?.productDetails[i].cartMenu[j].setFatTotal = fatTotal;
              update();
            } else {
              fatTotal = 0.0;
              groupOrderDetailsModel.data?.productDetails[i].cartMenu[j].setFatTotal = fatTotal;
              update();
            }

            if (groupOrderDetailsModel.data?.productDetails[i].cartMenu[j].carbs.isNotEmpty == true) {
             var result3 = double.parse(
                  groupOrderDetailsModel.data?.productDetails[i].cartMenu[j].carbs.toString() ?? "")
                  * (double.parse(
                      groupOrderDetailsModel.data?.productDetails[i].cartMenu[j].selectQuantity.toString() ?? ""));
              carbsTotal = carbsTotal + result3;
             groupOrderDetailsModel.data?.productDetails[i].cartMenu[j].setCarbsTotal = carbsTotal;
              update();
            } else {
              carbsTotal = 0.0;
              groupOrderDetailsModel.data?.productDetails[i].cartMenu[j].setCarbsTotal = carbsTotal;
              update();
            }

            if (groupOrderDetailsModel.data?.productDetails[i].cartMenu[j].protein.isNotEmpty == true) {
             var result4 = double.parse(
                  groupOrderDetailsModel.data?.productDetails[i].cartMenu[j].protein.toString() ?? "")
                  * (double.parse(
                      groupOrderDetailsModel.data?.productDetails[i].cartMenu[j].selectQuantity.toString() ?? ""));
              proteinTotal = proteinTotal + result4;
              groupOrderDetailsModel.data?.productDetails[i].cartMenu[j].setProteinTotal = proteinTotal;
              update();
            } else {
              proteinTotal = 0.0;
              groupOrderDetailsModel.data?.productDetails[i].cartMenu[j].setProteinTotal = proteinTotal;
              update();
            }
           }
          }

          name = (groupOrderDetailsModel.data!.restaurantData?.managerName.toString() ?? "") + ", ";
          debugPrint('Name: $name');

          isViewOrderVisible = false;
          update();
        }else{
          showToastMessage(groupOrderDetailsModel.meta!.msg.toString());
          isViewOrderVisible = false;
          update();
        }
      } else {
        showToastMessage(groupOrderDetailsModel.meta!.msg.toString());
        isViewOrderVisible = true;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return groupOrderDetailsModel;
    });
  }

}

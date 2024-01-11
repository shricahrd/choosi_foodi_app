import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/http_utils/http_constants.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../../../../core/http_utils/http_post_util.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../routes/general_path.dart';
import '../../../cart/model/delete_cart_model.dart';
import '../../model/group_order/get_go_list_model.dart.dart';
import '../../model/group_order/view_go_cart_model.dart';

class GroupOrderListController extends GetxController{
  GetGoListModel groupOrderListModel = GetGoListModel();
  bool isGroupListVisible = true;
  List<DataItem> getFilterGOModel = [];
  int orderStatus = 0;
  bool isOrderCanceledLoader = true;
  DeleteCartModel deleteCartModel = DeleteCartModel();
  String? cartRestaurantName;
  int orderStatusFilter = 1;
  Set<String> uniqueNames = Set<String>();

  Future<void> callGroupOrderListAPI({required List filterType,
    required String searchString,
    dynamic startDateSearch,
    dynamic endDateSearch,
    dynamic orderType,
  }) async{

    if(startDateSearch == null || startDateSearch == "null"){
      startDateSearch = '';
      endDateSearch = '';
    }else {
      debugPrint('startDateinMiliSec: $startDateSearch');
      debugPrint('endDateinMiliSec $endDateSearch');
    }

    debugPrint('filterType: $filterType');

    if(filterType.contains(1)){
      orderStatusFilter = 1;
    }else if(filterType.contains(6)){
      orderStatusFilter = 6;
    }else{
      orderStatusFilter = 7;
    }
    debugPrint('orderStatusFilter: $orderStatusFilter');

    if(orderType == selOrderType){
      orderType = "";
    }else{
      debugPrint('orderType: $orderType');
    }

    String url = GeneralPath.API_GROUP_ORDER_LIST +
        "?orderStatus=$orderStatusFilter"
            "&searchKey=$searchString&startDate=$startDateSearch&endDate=$endDateSearch&orderType=$orderType";
    getFilterGOModel.clear();
    uniqueNames.clear();
    debugPrint('Url: $url');

    // await getRequest(GeneralPath.API_GROUP_ORDER_LIST).then((response) {
    await getRequest(url).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        groupOrderListModel = GetGoListModel.fromJson(mResponse);
        if (groupOrderListModel.meta?.status == true) {
          int len = 0;
          for(int i=0; i<(groupOrderListModel.data?.first.data.length ?? 0); i++){
            String currentName = groupOrderListModel.data?.first.data[i].groupOrderID ?? "";
            for(int j=0;j<filterType.length; j++) {
              if (!uniqueNames.contains(currentName)) {
                if (groupOrderListModel.data!.first.data[i].orderStatus == filterType[j]) {
                  len++;
                  getFilterGOModel.add(groupOrderListModel.data!.first.data[i]);
                  // debugPrint('cartMenu len: ${groupOrderListModel.data!.first.data[i].productDetails[0].cartMenu.length}');
                }
                uniqueNames.add(currentName);
              }
            }
          }
          
          orderStatus = len;
          debugPrint('OrderStatus Len: $orderStatus');

          for (int i = 0; i < getFilterGOModel.length; i++) {

            var date = DateTime.fromMicrosecondsSinceEpoch(getFilterGOModel[i].deliveryDate * 1000);
            var d12 = formatterMonthWithTime.format(date);
            getFilterGOModel[i].setParsedDate = d12;

            var mainCalaryTotal = 0.0;
            var mainFatTotal = 0.0;
            var mainProteinTotal = 0.0;
            var mainCarbsTotal = 0.0;
            for (int j = 0; j < (getFilterGOModel[i].productDetails.length); j++) {
              // print('Index sub: $j');
              for (int k = 0; k < (getFilterGOModel[i].productDetails[j].cartMenu.length); k++) {
                // print('Index sub: $j');
                if (getFilterGOModel[i].productDetails[j].cartMenu[k].calories.isNotEmpty == true) {
                    var subCalaryTotal = double.parse(
                        '${getFilterGOModel[i].productDetails[j].cartMenu[k].calories.toString()}')
                        * (double.parse(
                            '${getFilterGOModel[i].productDetails[j].cartMenu[k].selectQuantity.toString()}'));
                    mainCalaryTotal = mainCalaryTotal + subCalaryTotal;
                    getFilterGOModel[i].setCaloriesTotal = mainCalaryTotal;
                    update();
                } else {
                  mainCalaryTotal = 0.0;
                  getFilterGOModel[i].setCaloriesTotal = mainCalaryTotal;
                  // caloriesTotal = 0.0;
                  update();
                }

                if (getFilterGOModel[i].productDetails[j].cartMenu[k].fat.isNotEmpty ==
                    true) {
                    var subFatTotal = double.parse(
                        '${getFilterGOModel[i].productDetails[j].cartMenu[k].fat.toString()}')
                        * (double.parse(
                            '${getFilterGOModel[i].productDetails[j].cartMenu[k].selectQuantity.toString()}'));
                    mainFatTotal = mainFatTotal + subFatTotal;
                    getFilterGOModel[i].setFatTotal = mainFatTotal;
                    update();
                } else {
                  mainFatTotal = 0.0;
                  getFilterGOModel[i].setFatTotal = mainFatTotal;
                  update();
                }

                if (getFilterGOModel[i].productDetails[j].cartMenu[k].carbs.isNotEmpty ==
                    true) {
                    var subCarbsTotal = double.parse(
                        '${getFilterGOModel[i].productDetails[j].cartMenu[k].carbs
                            .toString()}')
                        * (double.parse(
                            '${getFilterGOModel[i].productDetails[j]
                                .cartMenu[k].selectQuantity.toString()}'));
                    mainCarbsTotal = mainCarbsTotal + subCarbsTotal;
                    getFilterGOModel[i].setCarbsTotal = mainCarbsTotal;
                    update();
                } else {
                  mainCarbsTotal = 0.0;
                  getFilterGOModel[i].setCarbsTotal = mainCarbsTotal;
                  update();
                }

                if (getFilterGOModel[i].productDetails[j].cartMenu[k].protein.isNotEmpty == true) {
                    var subProteinTotal = double.parse(
                        '${getFilterGOModel[i].productDetails[j].cartMenu[k].protein
                            .toString()}')
                        * (double.parse(
                            '${getFilterGOModel[i].productDetails[j]
                                .cartMenu[k].selectQuantity.toString()}'));
                    mainProteinTotal = mainProteinTotal + subProteinTotal;
                    getFilterGOModel[i].setProteinTotal = mainProteinTotal;
                    update();
                } else {
                  mainProteinTotal = 0.0;
                  getFilterGOModel[i].setProteinTotal = mainProteinTotal;
                  update();
                }
              }
            }
          }

          isGroupListVisible = false;
          update();
        }else{
          isGroupListVisible = false;
          update();
        }
      } else {
        isGroupListVisible = true;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return groupOrderListModel;
    });
  }

  cancelGroupOrderApi({required String groupOrderId, required String reason,}){
    final params = jsonEncode({
      HttpConstants.PARAMS_GROUP_ORDER_ID: groupOrderId,
      HttpConstants.PARAMS_REASON: reason
    });
    putRequest(GeneralPath.API_CANCEL_GROUP_ORDER, params).then((response) {
      if (response.statusCode == 200) {
        print('Response Data: ${response.body}');
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        deleteCartModel = DeleteCartModel.fromJson(mResponse);
        if (deleteCartModel.meta?.status == true) {
          debugPrint('status : ${deleteCartModel.meta?.status}');
          // showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
          isOrderCanceledLoader = false;
          update();
        }else{
          showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
          isOrderCanceledLoader = false;
          update();
        }
      } else {
        showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
        isOrderCanceledLoader = true;
        update();
        throw Exception('Failed to load data.');
      }
      update();
    });
  }

}
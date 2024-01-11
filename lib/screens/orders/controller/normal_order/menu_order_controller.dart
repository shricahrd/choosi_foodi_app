import 'dart:convert';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../core/http_utils/http_constants.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../../../../core/http_utils/http_post_util.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../cart/model/delete_cart_model.dart';
import '../../../cart/model/get_cart_model.dart';
import '../../../restaurant_details/model/get_qty_update_model.dart.dart';
import '../../model/normal_order/get_order_model.dart';

class MenuOrderController extends GetxController {
  bool isLoaderVisible = true;
  bool isOrderCanceledLoader = true;
  GetOrderModel getOrderModel = GetOrderModel();
  List<GetOrderData> getFilterOrderModel = [];
  DeleteCartModel deleteCartModel = DeleteCartModel();
  GetQtyUpdateModel getQtyUpdateModel = GetQtyUpdateModel();
  int orderCount = 0;
  GetCartModel getMenuCartModel = GetCartModel();
  bool cartFound = false;
  bool isReOrderLoaded = false;
  String? cartRestaurantName;
  // String createdDate = "";
  int orderStatusFilter = 1;
  Set<String> uniqueNames = Set<String>();


  @override
  void onInit() {
    isLoaderVisible = true;
    super.onInit();
  }

  @override
  void dispose() {
    isLoaderVisible = false;
    super.dispose();
  }

  Future<void> callGetOrderAPI( {required List filterType,
    required String searchString,
    dynamic startDateSearch,
    dynamic endDateSearch,
    dynamic orderType,}) async{
    isLoaderVisible = true;

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

    String url = GeneralPath.API_GET_ORDER +
        "?orderStatus=$orderStatusFilter"
            "&searchKey=$searchString&startDate=$startDateSearch&endDate=$endDateSearch&orderType=$orderType";
    getFilterOrderModel.clear();
    uniqueNames.clear();
    debugPrint('Url: $url');

    update();
    // await getRequest(GeneralPath.API_GET_ORDER).then((response) {
    await getRequest(url).then((response) {
      if (response.statusCode == 200) {
        getOrderModel = GetOrderModel.fromJson(json.decode(response.body));
        if (getOrderModel.meta?.status == true) {
          debugPrint('status true: ${getOrderModel.meta?.status}');
          debugPrint('Response Data: ${getOrderModel.data}');

          int len = 0;
          for (int i = 0; i < (getOrderModel.data?.length ?? 0); i++) {
            String currentName = getOrderModel.data?[i].menuOrderID ?? "";
            for (int j = 0; j < filterType.length; j++) {
              if (!uniqueNames.contains(currentName)) {
                debugPrint('FilterType: ${filterType[j]}');
                if (getOrderModel.data?[i].orderStatus == filterType[j]) {
                  len++;
                  debugPrint('OrderStatus Length: $len');
                  // debugPrint('OrderId: ${getOrderModel.data?[i].menuOrderID}');
                  getFilterOrderModel.add(getOrderModel.data![i]);
                  // debugPrint('getFilterOrderModel Length: ${getFilterOrderModel.length}');
                }
                uniqueNames.add(currentName);
              }
            }
          }
          orderCount = len;
          debugPrint('orderCount Len: $orderCount');
          update();

          for (int i = 0; i < getFilterOrderModel.length; i++) {

            if (getFilterOrderModel[i].deliveryDate.toString().isEmpty == true) {
              // createdDate = "";
              getFilterOrderModel[i].setParsedDate = "";
            } else {
              // parseTimeStampReport(int.parse(getFilterOrderModel[i].createdAt.toString()));
              int dateParse = getFilterOrderModel[i].deliveryDate ?? 0;
              var date = DateTime.fromMicrosecondsSinceEpoch(dateParse * 1000);
              var d12 = formatterMonthWithTime.format(date);
              getFilterOrderModel[i].setParsedDate = d12;
            }

            // debugPrint('Index main: $i');
            var mainCalaryTotal = 0.0;
            var mainFatTotal = 0.0;
            var mainProteinTotal = 0.0;
            var mainCarbsTotal = 0.0;
            for (int j = 0; j < (getFilterOrderModel[i].productDetails?.length ?? 0); j++) {
              // debugPrint('Index sub: $j');
              if (getFilterOrderModel[i].productDetails?[j].calories
                  ?.isNotEmpty == true) {
                if (getFilterOrderModel[i].productDetails?[j].calories !=
                    null) {
                  var subCalaryTotal = double.parse(
                      '${getFilterOrderModel[i].productDetails?[j].calories
                          .toString()}')
                      * (double.parse(
                          '${getFilterOrderModel[i].productDetails?[j]
                              .selectQuantity.toString()}'));
                  mainCalaryTotal = mainCalaryTotal + subCalaryTotal;
                  getFilterOrderModel[i].setCaloriesTotal = mainCalaryTotal;
                  update();
                } else {
                  mainCalaryTotal = 0.0;
                  getFilterOrderModel[i].setCaloriesTotal = mainCalaryTotal;
                  update();
                }
              } else {
                mainCalaryTotal = 0.0;
                getFilterOrderModel[i].setCaloriesTotal = mainCalaryTotal;
                // caloriesTotal = 0.0;
                update();
              }

              if (getFilterOrderModel[i].productDetails?[j].fat?.isNotEmpty == true) {
                if (getFilterOrderModel[i].productDetails?[j].fat != null) {

                  var subFatTotal = double.parse(
                      '${getFilterOrderModel[i].productDetails?[j].fat
                          .toString()}')
                      * (double.parse(
                          '${getFilterOrderModel[i].productDetails?[j]
                              .selectQuantity.toString()}'));
                  mainFatTotal = mainFatTotal + subFatTotal;
                  getFilterOrderModel[i].setFatTotal = mainFatTotal;
                  update();
                } else {
                  mainFatTotal = 0.0;
                  getFilterOrderModel[i].setFatTotal = mainFatTotal;
                  update();
                }
              } else {
                mainFatTotal = 0.0;
                getFilterOrderModel[i].setFatTotal = mainFatTotal;
                update();
              }

              if (getFilterOrderModel[i].productDetails?[j].carbs?.isNotEmpty ==
                  true) {
                if (getFilterOrderModel[i].productDetails?[j].carbs != null) {
                  var subCarbsTotal = double.parse(
                      '${getFilterOrderModel[i].productDetails?[j].carbs.toString()}')
                      * (double.parse(
                          '${getFilterOrderModel[i].productDetails?[j].selectQuantity.toString()}'));
                  mainCarbsTotal = mainCarbsTotal + subCarbsTotal;
                  getFilterOrderModel[i].setCarbsTotal = mainCarbsTotal;
                  update();
                } else {
                  mainCarbsTotal = 0.0;
                  getFilterOrderModel[i].setCarbsTotal = mainCarbsTotal;
                  update();
                }
              } else {
                mainCarbsTotal = 0.0;
                getFilterOrderModel[i].setCarbsTotal = mainCarbsTotal;
                update();
              }

              if (getFilterOrderModel[i].productDetails?[j].protein
                  ?.isNotEmpty == true) {
                if (getFilterOrderModel[i].productDetails?[j].protein != null) {
                  var subProteinTotal = double.parse(
                      '${getFilterOrderModel[i].productDetails?[j].protein.toString()}')
                      * (double.parse(
                          '${getFilterOrderModel[i].productDetails?[j].selectQuantity.toString()}'));
                  mainProteinTotal = mainProteinTotal + subProteinTotal;
                  getFilterOrderModel[i].setProteinTotal = mainProteinTotal;
                  update();
                } else {
                  mainProteinTotal = 0.0;
                  getFilterOrderModel[i].setProteinTotal = mainProteinTotal;
                  update();
                }
              } else {
                mainProteinTotal = 0.0;
                getFilterOrderModel[i].setProteinTotal = mainProteinTotal;
                update();
              }
            }
          }

          // if (isLoaderShow) {
          //   isLoaderVisible = false;
          // }
          update();
        } else {
          // showToastMessage(getOrderModel.meta!.msg.toString());
          debugPrint('Token Issue else');
        }
        // if (isLoaderShow) {
        //   isLoaderVisible = false;
        // }
      } else {
        // showToastMessage(getOrderModel.meta?.msg ?? "");
        // isLoaderVisible = false;
        // update();
        throw Exception('Failed to load data.');
      }
      isLoaderVisible = false;
      update();
      return getFilterOrderModel;
    });
  }

  cancelOrderApi({required String menuOrderId, required String reason,}) {
    // isOrderCanceledLoader = true;
    // update();
    final params = jsonEncode({
      HttpConstants.PARAMS_MENUORDERID: menuOrderId,
      HttpConstants.PARAMS_REASON: reason
    });
    putRequest(GeneralPath.API_CENCEL_ORDER, params).then((response) {
      if (response.statusCode == 200) {
        debugPrint('Response Data: ${response.body}');
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        deleteCartModel = DeleteCartModel.fromJson(mResponse);
        if (deleteCartModel.meta?.status == true) {
          debugPrint('status : ${deleteCartModel.meta?.status}');
          // showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
        } else {
          showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
        }
        isOrderCanceledLoader = false;
        update();
      } else {
        showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
        isOrderCanceledLoader = true;
        update();
        throw Exception('Failed to load data.');
      }
      update();
    });
  }

  Future<void> callGetCartAPI() async {
    await getRequest(GeneralPath.API_GET_CART).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);

        getMenuCartModel = GetCartModel.fromJson(mResponse);
        if (getMenuCartModel.meta?.status == true) {
          debugPrint('status true: ${getMenuCartModel.meta?.status}');
          debugPrint('Response Cart Data: ${getMenuCartModel.data}');
          if (getMenuCartModel.data?.cartMenu?.length != 0) {
            cartFound = true;
            cartRestaurantName =
                getMenuCartModel.data?.restaurant?.restaurantName;
            update();
          }
          update();
        }
      } else {
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return getMenuCartModel;
    });
  }

  Future<void> postReOrderApi({required String menuOrderId}) async {
    // final params = jsonEncode({
    //   HttpConstants.PARAMS_MENUORDERID: menuOrderId,
    // });

    // isReOrderLoaded = !isReOrderLoaded;
    // debugPrint('start loader: $isReOrderLoaded');
    // update();

    await postRequestUrl(GeneralPath.API_REORDER + menuOrderId).then((
        response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        getQtyUpdateModel = GetQtyUpdateModel.fromJson(mResponse);
        if (getQtyUpdateModel.meta?.status == true) {
          showToastMessage(getQtyUpdateModel.meta!.msg.toString());
          // Get.back(result: true);
        } else {
          showToastMessage(getQtyUpdateModel.meta!.msg.toString());
        }
        isReOrderLoaded = !isReOrderLoaded;
        debugPrint('success loader: $isReOrderLoaded');
        update();
      } else {
        showToastMessage(getQtyUpdateModel.meta!.msg.toString());
        isReOrderLoaded = false;
        debugPrint('false loader: $isReOrderLoaded');
        update();
      }
      update();
      return getQtyUpdateModel;
    });
  }
}

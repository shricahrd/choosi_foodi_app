import 'dart:convert';
import 'package:choosifoodi/core/http_utils/http_constants.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import '../../../core/http_utils/http_get_util.dart';
import '../../../core/http_utils/http_post_util.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../cart/model/delete_cart_model.dart';
import '../../cart/model/get_cart_model.dart';
import '../model/restaurant_details_model.dart';

class RestaurantDetailsController extends GetxController {
  bool isLoaderVisible = false;
  RestaurantDetailsModel restaurantDetailsModel = RestaurantDetailsModel();
  DeleteCartModel deleteCartModel = DeleteCartModel();
  GetCartModel getMenuCartModel = GetCartModel();
  // bool isRestAvailCart = false;
  int cartItemCount = 0;
  String restaurantId = "";
  var arrDistance;
  bool statusOpen = false;
  String start = "";
  bool addToCartBool = false;
  double caloriesTotal = 0.0;
  double fatTotal = 0.0;
  double carbsTotal = 0.0;
  double proteinTotal = 0.0;
  dynamic foodTypeData;
  // List<GetCustomCartModel> getCustomModelList = [];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    isLoaderVisible = false;
    super.dispose();
  }

  initialTotalCategories(){
    caloriesTotal = 0.0;
    fatTotal = 0.0;
    carbsTotal = 0.0;
    proteinTotal = 0.0;
    for(int i = 0; i< restaurantDetailsModel.data!.menus!.length; i++) {
      double result1, result2, result3, result4;


   /*   if(getCustomModelList.length != 0 && cartItemCount !=0) {
        debugPrint('GetCartModel list Len: ${getCustomModelList.length}');
        for (int j = 0; j < getCustomModelList.length; j++) {
          debugPrint('getCustomModelList index : $j ===> ${getCustomModelList[j].menuId}');
          if (getCustomModelList[j].menuId == restaurantDetailsModel.data!.menus![i].menuId) {
            debugPrint('MenuId Match');
            debugPrint('MenuId Qty ===> ${getCustomModelList[j].selectQty.toString()}');
            if(restaurantDetailsModel.data!.menus![i].isAddToCartEnable == true){
              restaurantDetailsModel.data!.menus![i].setAddToCartEnable = false;
              update();
            }
          }
        }
      }*/

      int selectedPrice = int.parse(restaurantDetailsModel.data!.menus![i].selectQuantity.toString()) *  int.parse(restaurantDetailsModel.data!.menus![i].price.toString());
      restaurantDetailsModel.data!.menus![i].setPrice = selectedPrice;

      if (restaurantDetailsModel.data!.menus![i].calories != null) {
        if (restaurantDetailsModel.data!.menus![i].calories!= 0) {
          result1 = double.parse(restaurantDetailsModel.data!.menus![i].calories.toString())
              * (double.parse(restaurantDetailsModel.data!.menus![i].selectQuantity.toString()));
          restaurantDetailsModel.data!.menus![i].setCalories = result1;
          caloriesTotal = caloriesTotal + result1;
          update();
        } else {
          result1 = 0.0;
          restaurantDetailsModel.data!.menus![i].setCalories = result1;
          caloriesTotal = caloriesTotal  + result1;
          update();
        }
      } else {
        result1 = 0.0;
        restaurantDetailsModel.data!.menus![i].setCalories = result1;
        caloriesTotal = caloriesTotal  + result1;
        update();
      }

      if (restaurantDetailsModel.data?.menus?[i].fat != null) {
        if (restaurantDetailsModel.data?.menus?[i].fat!=0) {
          // debugPrint('FatModel type: ${restaurantDetailsModel.data!.menus![i].fat.runtimeType}');
          // debugPrint('FatModel: ${restaurantDetailsModel.data!.menus![i].fat?.split('gm').first.toString()}');

          if(restaurantDetailsModel.data!.menus![i].fat.toString().contains('gm')){
            result2 = double.parse(
                restaurantDetailsModel.data!.menus![i].fat!.split('gm').first.toString())
                * (double.parse(
                    restaurantDetailsModel.data!.menus![i].selectQuantity
                        .toString()));
          }else{
            result2 = double.parse(
                restaurantDetailsModel.data!.menus![i].fat.toString())
                * (double.parse(
                    restaurantDetailsModel.data!.menus![i].selectQuantity
                        .toString()));
          }

          restaurantDetailsModel.data!.menus![i].setFat = result2;
          fatTotal = fatTotal + result2;
          update();
        } else {
          result2 = 0.0;
          restaurantDetailsModel.data!.menus![i].setFat = result2;
          fatTotal = fatTotal  + result2;
          update();
        }
      } else {
        result2 = 0.0;
        restaurantDetailsModel.data!.menus![i].setFat = result2;
        fatTotal = fatTotal  + result2;
        update();
      }

      if (restaurantDetailsModel.data!.menus?[i].carbs != null) {
        if (restaurantDetailsModel.data!.menus![i].carbs!= 0) {

          if(restaurantDetailsModel.data!.menus![i].fat.toString().contains('gm')){
            result3 = double.parse(
                restaurantDetailsModel.data!.menus![i].carbs!.split('gm').first.toString())
                * (double.parse(
                    restaurantDetailsModel.data!.menus![i].selectQuantity
                        .toString()));
          }else{
            result3 = double.parse(
                restaurantDetailsModel.data!.menus![i].carbs.toString())
                * (double.parse(
                    restaurantDetailsModel.data!.menus![i].selectQuantity
                        .toString()));
          }

          restaurantDetailsModel.data!.menus![i].setCarbs = result3;
          carbsTotal = carbsTotal + result3;
          update();
        } else {
          result3 = 0.0;
          restaurantDetailsModel.data!.menus![i].setCarbs = result3;
          carbsTotal = carbsTotal + result3;
          update();
        }
      } else {
        result3 = 0.0;
        restaurantDetailsModel.data!.menus![i].setCarbs = result3;
        carbsTotal = carbsTotal + result3;
        update();
      }

      if (restaurantDetailsModel.data!.menus?[i].protein != null) {
        if (restaurantDetailsModel.data!.menus![i].protein!=0) {

          if(restaurantDetailsModel.data!.menus![i].fat.toString().contains('gm')){
            result4 = double.parse(
                restaurantDetailsModel.data!.menus![i].protein!.split('gm').first
                    .toString())
                * (double.parse(
                    restaurantDetailsModel.data!.menus![i].selectQuantity
                        .toString()));
          }else{
            result4 = double.parse(
                restaurantDetailsModel.data!.menus![i].protein.toString())
                * (double.parse(
                    restaurantDetailsModel.data!.menus![i].selectQuantity
                        .toString()));
          }
          restaurantDetailsModel.data!.menus![i].setProtein = result4;
          proteinTotal = proteinTotal + result4;
          update();
        } else {
          result4 = 0.0;
          restaurantDetailsModel.data!.menus![i].setProtein = result4;
          proteinTotal = proteinTotal + result4;
          update();
        }
      } else {
        result4 = 0.0;
        restaurantDetailsModel.data!.menus![i].setProtein = result4;
        proteinTotal = proteinTotal + result4;
        update();
      }
    }
  }

  Future<void> callRestaurantDetailsAPI({required String lat,required String long,required String restaurantId,}) async {
    Map<String, String> queryParams = {
      HttpConstants.PARAMS_LAT: lat,
      HttpConstants.PARAMS_LONG: long,
    };
    await getRequestWithRequest(GeneralPath.API_RESTAURANT_DETAILS + restaurantId, queryParams).then((response) {
      isLoaderVisible = true;
      update();

      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        restaurantDetailsModel = RestaurantDetailsModel.fromJson(mResponse);
        if (restaurantDetailsModel.meta?.status == true) {
          // debugPrint('status true: ${restaurantDetailsModel.meta?.status}');
          // debugPrint('Response Home Data: ${restaurantDetailsModel.data}');
          if(restaurantDetailsModel.data != null) {

            initialTotalCategories();
            // isLoaderVisible = true;
            var distance = restaurantDetailsModel.data?.distance;
            var totalDistance = distance! / 1609.344;
            arrDistance =  totalDistance.round().toString();
            debugPrint('arrDistance: ${arrDistance}');
            bool restOpen = false;
            if(restaurantDetailsModel.data?.timings!.openingTime != null) {
              start = restaurantDetailsModel.data?.timings!.openingTime.toString() ?? "";
              String end = restaurantDetailsModel.data?.timings!.closingTime.toString() ?? "";

              if(restaurantDetailsModel.data?.rootCategory?.isNotEmpty == true){
                for (int i = 0; i < (restaurantDetailsModel.data?.rootCategory?.length ?? 0); i++) {
                  if (i == 0) {
                    foodTypeData =
                        restaurantDetailsModel.data?.rootCategory?[i]
                            .categoryName ??
                            "";
                  } else {
                    foodTypeData += ", " +
                        (restaurantDetailsModel.data?.rootCategory?[i]
                            .categoryName ??
                            "");
                  }
                }
              }else{
                foodTypeData = "";
              }

              if(restaurantDetailsModel.data?.timings?.day?.isNotEmpty == true) {
                DateTime now = DateTime.now();
                var d12 = formatterDay.format(now);
                debugPrint('d12 : ${d12.toUpperCase()}');
                List restDay = [];
                dynamic daySplit = restaurantDetailsModel.data?.timings?.day.toString().split(',').toSet().toList();
                restDay = daySplit;
                debugPrint('restDay day : ${restDay}');
                for (int i = 0; i < restDay.length; i++) {
                  if (restDay[i] == d12.toUpperCase()) {
                    debugPrint('restaurant open');
                    restOpen = true;
                    if (start.isNotEmpty) {
                      statusOpen = isRestaurantOpen(start, end);
                      debugPrint('ISOPEN: $statusOpen');
                    }
                  }
                }

                if (restOpen == false) {
                  statusOpen = false;
                }
              }else{
                if (start.isNotEmpty) {
                  statusOpen = isRestaurantOpen(start, end);
                  debugPrint('ISOPEN: $statusOpen');
                }
              }
            }else{
              statusOpen = false;
            }
            update();
          }
        }else{
          debugPrint('status false : ${restaurantDetailsModel.meta?.msg ?? ""}');
          // showToastMessage(restaurantDetailsModel.meta?.msg ?? "");
        }
      } else {
        showToastMessage(restaurantDetailsModel.meta?.msg ?? "");
        throw Exception('Failed to load data.');
      }
      isLoaderVisible = false;
      update();
      return restaurantDetailsModel;
    });
  }

  Future<void> postAddCardApi({required String restId, required String menuId, required int selectQty, required bool isAddOn, List? otherAddList}) async{
    dynamic params;

    if(isAddOn == true){
      params = jsonEncode({
        HttpConstants.PARAMS_RESTID: restId,
        HttpConstants.PARAMS_MENUID: menuId,
        HttpConstants.PARAMS_SELECTQTY: selectQty,
        HttpConstants.PARAMS_OTHER_ADDONS: otherAddList,
      });
    }else{
      params = jsonEncode({
        HttpConstants.PARAMS_RESTID: restId,
        HttpConstants.PARAMS_MENUID: menuId,
        HttpConstants.PARAMS_SELECTQTY: selectQty,
      });
    }

    await postRequest(GeneralPath.API_ADD_CART, params).then((response) async {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        deleteCartModel = DeleteCartModel.fromJson(mResponse);
        if (deleteCartModel.meta?.status == true) {
          debugPrint('status in Controller: ${deleteCartModel.meta?.msg}');
          if(deleteCartModel.meta?.msg.toString() == differentCafe){
            // showToastMessage(deleteCartModel.meta?.msg ?? "");
            showToastMessage(clearCart);
          }
          // showToastMessage(deleteCartModel.meta?.msg ?? "");
          addToCartBool = true;
          callGetCartAPI();
          update();
        }else{
          showToastMessage(deleteCartModel.meta?.msg ?? "");
          addToCartBool = false;
          update();
        }
        update();
      } else {
        showToastMessage(deleteCartModel.meta?.msg ?? "");
        addToCartBool = false;
        update();
      }
      update();
      return deleteCartModel;
    });
  }



  Future<void> postAddGroupCardApi({required String groupId, required String menuId, required int selectQty,}) async{
    final params = jsonEncode({
      HttpConstants.PARAMS_GROUPID: groupId,
      HttpConstants.PARAMS_MENUID: menuId,
      HttpConstants.PARAMS_SELECTQTY: selectQty,
    });

    await postRequest(GeneralPath.API_GROUP_CART_ADD, params).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        deleteCartModel = DeleteCartModel.fromJson(mResponse);
        if (deleteCartModel.meta?.status == true) {
          showToastMessage(deleteCartModel.meta?.msg ?? "");
          // debugPrint('status in Controller: ${deleteCartModel.meta?.status}');
          // update();
        }else{
          showToastMessage(deleteCartModel.meta?.msg ?? "");
          // update();
        }
        update();
      } else {
        showToastMessage(deleteCartModel.meta?.msg ?? "");
        // update();
      }
      update();
      return deleteCartModel;
    });
  }

 /* Future<void> addToSP(List<GetCustomCartModel> getCustomModelList) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(PREF_CUSTOMCARTLIST, jsonEncode(getCustomModelList));
    debugPrint('getSpList ====> : ${jsonEncode(getCustomModelList.map((data) => data.toMap()).toList())}');
    debugPrint('Total SpLen: ${getCustomModelList.length}');
  }*/

  Future<void> callGetCartAPI({String? restaurantId}) async {
    debugPrint('RestaurantId: $restaurantId');
    await getRequest(GeneralPath.API_GET_CART).then((response) async {
      if (response.statusCode == 200) {
        debugPrint('Response Cart statusCode: ${response.statusCode}');
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        getMenuCartModel = GetCartModel.fromJson(mResponse);
        if (getMenuCartModel.meta?.status == true) {

          debugPrint('Response Cart Data: ${getMenuCartModel.data}');

          cartItemCount = getMenuCartModel.data!.cartMenu!.length;
          update();
          debugPrint('Total CartLen: $cartItemCount');
          update();
        }else{
          cartItemCount = 0;
          update();
        }
      } else {
        // isRestAvailCart = false;
        // update();
        throw Exception('Failed to load data.');
      }
      update();
      return getMenuCartModel;
    });
  }


}
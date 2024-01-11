import 'dart:convert';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/http_utils/http_constants.dart';
import '../../../core/http_utils/http_get_util.dart';
import '../../../core/http_utils/http_post_util.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../restaurant_details/model/get_qty_update_model.dart.dart';
import '../model/delete_cart_model.dart';
import '../model/get_cart_model.dart';

class MenuCartController extends GetxController {
  bool isLoaderVisible = true;
  GetCartModel getMenuCartModel = GetCartModel();
  DeleteCartModel deleteCartModel = DeleteCartModel();
  GetQtyUpdateModel getQtyUpdateModel = GetQtyUpdateModel();
  bool couponApply = false;
  bool couponRemove = false;
  bool removeCouponAvail = false;
  bool addToCartBool = false;
  bool isCartDeleted = false;
  double caloriesTotal = 0.0;
  double fatTotal = 0.0;
  double carbsTotal = 0.0;
  double proteinTotal = 0.0;
  int price = 0;
  int itemCount = 0;
  // List<GetCustomCartModel> getCustomModelList = [];
  dynamic couponName;

  @override
  void onInit() {
    isLoaderVisible = true;
    super.onInit();
  }

/*  getSPList(String menuId) async{
    print('menuId spList: $menuId');
    final prefs = await SharedPreferences.getInstance();
    // Fetch and decode data
    final data1 = json.decode(prefs.getString(PREF_CUSTOMCARTLIST).toString());
    final item = List<GetCustomCartModel>.from(data1.map((i) => GetCustomCartModel.fromJson(i)));
    getCustomModelList = item;
    print('GETCARTMODEL Method Len : ${getCustomModelList.length}');


    for (int j = 0; j < getCustomModelList.length; j++) {
      if (menuId == getCustomModelList[j].menuId) {
        print('getCustomModelList index : $j ===> ${getCustomModelList[j].menuId}');
        getCustomModelList.remove(getCustomModelList[j]);
        update();
      }
    }

    print('getCustomModelList Len => ${getCustomModelList.length} ');
    if(getCustomModelList.length != 0) {
      prefs.setString(PREF_CUSTOMCARTLIST, jsonEncode(getCustomModelList));
      for (int j = 0; j < getCustomModelList.length; j++) {
        print('JSonData available $j: ${getCustomModelList[j].menuId}');
      }
    }else{
      print('Remove');
      getCustomModelList.clear();
      prefs.setString(PREF_CUSTOMCARTLIST, jsonEncode(getCustomModelList));
      print('getCustomModelList clear Len => ${getCustomModelList.length} ');
      await prefs.remove(PREF_CUSTOMCARTLIST);
      update();
    }
    update();
  }*/

  @override
  void dispose() {
    caloriesTotal = 0.0;
    fatTotal = 0.0;
    carbsTotal = 0.0;
    proteinTotal = 0.0;
    super.dispose();
  }

  initialTotalCategories() {
    caloriesTotal = 0.0;
    fatTotal = 0.0;
    carbsTotal = 0.0;
    proteinTotal = 0.0;
    for (int i = 0; i < getMenuCartModel.data!.cartMenu!.length; i++) {
      double result1, result2, result3, result4;

      if(getMenuCartModel.data?.cartMenu?[i].selectQuantity == null || getMenuCartModel.data?.cartMenu?[i].selectQuantity == 0){
        getMenuCartModel.data?.cartMenu?[i].setQuantity = 1;
        update();
      }else {
         int selectedPrice = int.parse(
              (getMenuCartModel.data?.cartMenu?[i].selectQuantity.toString() ?? "")) *
              int.parse((getMenuCartModel.data?.cartMenu?[i].price.toString() ?? ""));
          getMenuCartModel.data?.cartMenu?[i].setPrice = selectedPrice;

        // getMenuCartModel.calculateSubTotal = getMenuCartModel.subTotal;

        if (getMenuCartModel.data?.cartMenu?[i].calories != null) {
          if (getMenuCartModel.data?.cartMenu?[i].calories?.isNotEmpty == true) {
            result1 = double.parse(
                (getMenuCartModel.data?.cartMenu?[i].calories.toString() ?? "")) *
                (double.parse((getMenuCartModel.data?.cartMenu?[i].selectQuantity
                    .toString() ?? "")));
            // print('Result1: $result1');
            // print('selectQuantity: ${getMenuCartModel.data!.cartMenu![i].selectQuantity}');
            getMenuCartModel.data?.cartMenu?[i].setCalories = result1;
            caloriesTotal = caloriesTotal + result1;
            // print('caloriesTotal: $caloriesTotal');
            update();
          } else {
            result1 = 0.0;
            getMenuCartModel.data?.cartMenu?[i].setCalories = result1;
            caloriesTotal = caloriesTotal + result1;
            update();
          }
        } else {
          result1 = 0.0;
          getMenuCartModel.data?.cartMenu?[i].setCalories = result1;
          caloriesTotal = caloriesTotal + result1;
          update();
        }

        if (getMenuCartModel.data?.cartMenu?[i].fat != null) {
          if (getMenuCartModel.data?.cartMenu?[i].fat?.isNotEmpty == true) {
            // print('fatTotalbefore: ${getMenuCartModel.data!.cartMenu![i].fat}');
            result2 =
                double.parse(
                    (getMenuCartModel.data?.cartMenu![i].fat.toString() ?? "")) *
                    (double.parse((getMenuCartModel
                        .data?.cartMenu?[i].selectQuantity
                        .toString() ?? "")));
            getMenuCartModel.data?.cartMenu?[i].setFat = result2;
            fatTotal = fatTotal + result2;
            // print('fatTotal: $fatTotal');
            update();
          } else {
            // print('fatTotal empty: $fatTotal');
            fatTotal = 0.0;
            result2 = 0.0;
            getMenuCartModel.data?.cartMenu?[i].setFat = result2;
            fatTotal = fatTotal + result2;
            update();
          }
        } else {
          print('fatTotal null: $fatTotal');
          fatTotal = 0.0;
          result2 = 0.0;
          getMenuCartModel.data?.cartMenu?[i].setFat = result2;
          fatTotal = fatTotal + result2;
          update();
        }

        if (getMenuCartModel.data?.cartMenu?[i].carbs != null) {
          if (getMenuCartModel.data?.cartMenu?[i].carbs?.isNotEmpty == true) {
            result3 = double.parse(
                (getMenuCartModel.data?.cartMenu?[i].carbs.toString() ?? "")) *
                (double.parse((getMenuCartModel.data?.cartMenu?[i].selectQuantity
                    .toString() ?? "")));
            getMenuCartModel.data?.cartMenu?[i].setCarbs = result3;
            carbsTotal = carbsTotal + result3;
            update();
          } else {
            result3 = 0.0;
            getMenuCartModel.data?.cartMenu?[i].setCarbs = result3;
            carbsTotal = carbsTotal + result3;
            update();
          }
        } else {
          result3 = 0.0;
          getMenuCartModel.data?.cartMenu?[i].setCarbs = result3;
          carbsTotal = carbsTotal + result3;
          update();
        }

        if (getMenuCartModel.data?.cartMenu?[i].protein != null) {
          if (getMenuCartModel.data?.cartMenu?[i].protein?.isNotEmpty == true) {
            result4 = double.parse(
                (getMenuCartModel.data?.cartMenu?[i].protein.toString() ?? "")) *
                (double.parse((getMenuCartModel.data?.cartMenu?[i].selectQuantity
                    .toString() ?? "")));
            getMenuCartModel.data?.cartMenu?[i].setProtein = result4;
            proteinTotal = proteinTotal + result4;
            update();
          } else {
            result4 = 0.0;
            getMenuCartModel.data?.cartMenu?[i].setProtein = result4;
            proteinTotal = proteinTotal + result4;
            update();
          }
        } else {
          result4 = 0.0;
          getMenuCartModel.data?.cartMenu?[i].setProtein = result4;
          proteinTotal = proteinTotal + result4;
          update();
        }
      }

    }
  }

  Future<void> callGetCartAPI() async {
    // isLoaderVisible = true;
    await getRequest(GeneralPath.API_GET_CART).then((response) async {
      debugPrint('Code : => ${response.statusCode}');

      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);

        getMenuCartModel = GetCartModel.fromJson(mResponse);
        if (getMenuCartModel.meta?.status == true) {
          debugPrint('status true: ${getMenuCartModel.meta?.status}');
          debugPrint('Response Data: ${getMenuCartModel.data}');
          itemCount = getMenuCartModel.data?.cartMenu?.length ?? 0;
          debugPrint('Discount: ${getMenuCartModel.discount}');
          update();
          if(getMenuCartModel.data?.coupon?.couponName != null){
            if(getMenuCartModel.data!.coupon!.couponName!.isNotEmpty){
              couponName = getMenuCartModel.data?.coupon?.couponName;
              debugPrint('Response couponName: $couponName');
              update();
            }
          }
          initialTotalCategories();
          // isLoaderVisible = false;
          // update();
        } else {
          // isLoaderVisible = false;
          final prefs = await SharedPreferences.getInstance();
          prefs.setString(PREF_CUSTOMCARTLIST, "");
          // getCountSpList();
          update();
        }

        isLoaderVisible = false;
        update();
      } else {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString(PREF_CUSTOMCARTLIST, "");
        // getCountSpList();
        showToastMessage(getMenuCartModel.meta?.msg.toString() ?? "");
        isLoaderVisible = true;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return getMenuCartModel;
    });
  }

  Future<void> incrementQtyApi({required String restaurantId, required String menuId,required int selectQty,}) async{
    final params = jsonEncode({
      HttpConstants.PARAMS_RESTID: restaurantId,
      HttpConstants.PARAMS_MENUID: menuId,
      HttpConstants.PARAMS_SELECTQTY: selectQty,
    });

    await putRequest(GeneralPath.API_CART_INC, params).then((response) {
      if (response.statusCode == 200) {
        print('Response Data: ${response.body}');
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        getQtyUpdateModel = GetQtyUpdateModel.fromJson(mResponse);
        if (getQtyUpdateModel.meta?.status == true) {
          debugPrint('status : ${getQtyUpdateModel.meta?.status}');
          // showToastMessage(deleteCartModel.meta!.msg.toString());
        }else{
          debugPrint('status : ${getQtyUpdateModel.meta?.status} msg: ${getQtyUpdateModel.meta?.msg} ');
          showToastMessage(getQtyUpdateModel.meta?.msg.toString() ?? "");
        }
      } else {
        showToastMessage(getQtyUpdateModel.meta?.msg.toString() ?? "");
        throw Exception('Failed to load data.');
      }
      update();
      return getQtyUpdateModel;
    });
  }

  Future<void> decrementQtyApi({required String restaurantId, required String menuId,required int selectQty,}) async{
    final params = jsonEncode({
      HttpConstants.PARAMS_RESTID: restaurantId,
      HttpConstants.PARAMS_MENUID: menuId,
      HttpConstants.PARAMS_SELECTQTY: selectQty,
    });

    await putRequest(GeneralPath.API_CART_DEC, params).then((response) {
      if (response.statusCode == 200) {
        print('Response Data: ${response.body}');
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        getQtyUpdateModel = GetQtyUpdateModel.fromJson(mResponse);
        if (getQtyUpdateModel.meta?.status == true) {
          print('status : ${getQtyUpdateModel.meta?.status}');
        }else{
          showToastMessage(getQtyUpdateModel.meta?.msg.toString() ?? "");
        }
      } else {
        showToastMessage(getQtyUpdateModel.meta?.msg.toString() ?? "");
        throw Exception('Failed to load data.');
      }
      update();
      return getQtyUpdateModel;
    });
  }

  Future<void> deleteCartAPI({required String cartId, required String menuId}) async{
    isCartDeleted = true;
    update();
    await deleteRequest(
      GeneralPath.API_REMOVE_CART + cartId,
    ).then((response) {
      if (response.statusCode == 200) {
        print('Response Data: ${response.body}');

        Map<String, dynamic> mResponse = jsonDecode(response.body);

        deleteCartModel = DeleteCartModel.fromJson(mResponse);
        if (deleteCartModel.meta?.status == true) {
          print('status : ${deleteCartModel.meta?.status}');
          print('menuId : $menuId');
          // getSPList(menuId);
          callGetCartAPI();
          isCartDeleted = false;
          update();
        } else {
          showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
          isCartDeleted = false;
          update();
        }
      } else {
        showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
        isCartDeleted = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return deleteCartModel;
    });
  }

  Future<void> postAddCardApi({
    required String restId,
    required String menuId,
    required int selectQty,
  }) async {
    final params = jsonEncode({
      HttpConstants.PARAMS_RESTID: restId,
      HttpConstants.PARAMS_MENUID: menuId,
      HttpConstants.PARAMS_SELECTQTY: selectQty,
    });

    await postRequest(GeneralPath.API_ADD_CART, params).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        deleteCartModel = DeleteCartModel.fromJson(mResponse);
        if (deleteCartModel.meta?.status == true) {
          // showToastMessage(deleteCartModel.meta!.msg.toString());
          print('status in Controller: ${deleteCartModel.meta?.status}');
          addToCartBool = true;
          update();
        } else {
          showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
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

  Future<void>applyCouponApi({required String restaurantId ,required String couponName,}) async{
    couponApply = true;
    update();

    final params = jsonEncode({
      HttpConstants.PARAMS_RESTID: restaurantId,
      HttpConstants.PARAMS_COUPON_NAME: couponName,
    });

    await postRequest(GeneralPath.API_COUPON_APPLY, params).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        deleteCartModel = DeleteCartModel.fromJson(mResponse);
        if (deleteCartModel.meta?.status == true) {
          print('status : ${deleteCartModel.meta?.status}');
          showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
          couponApply = true;
          removeCouponAvail = true;
          update();
        } else {
          showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
          couponApply = false;
          couponRemove = false;
          update();
        }
      } else {
        showToastMessage(deleteCartModel.meta?.msg ?? "");
        couponApply = false;
        update();
      }
      update();
      return deleteCartModel;
    });
  }

  deleteCouponAPI() {
    removeCouponAvail = true;
    couponRemove = true;
    update();
    deleteRequest(GeneralPath.API_COUPON_REMOVE).then((response) {
      if (response.statusCode == 200) {
        print('Response Data: ${response.body}');
        Map<String, dynamic> mResponse = jsonDecode(response.body);

        deleteCartModel = DeleteCartModel.fromJson(mResponse);
        if (deleteCartModel.meta?.status == true) {
          print('status : ${deleteCartModel.meta?.status}');
          showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
          couponRemove = true;
          couponApply = false;
          removeCouponAvail = false;
          callGetCartAPI();
          update();
        } else {
          showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
          couponRemove = false;
          removeCouponAvail = true;
          update();
        }
      } else {
        showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
        couponRemove = false;
        removeCouponAvail = true;
        update();
        throw Exception('Failed to load data.');
      }
      update();
    });
  }

}

import 'dart:convert';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import '../../../core/http_utils/http_get_util.dart';
import '../model/restaurant_model.dart';

class RestaurantFilterController extends GetxController {
  bool isLoaderVisible = false;
  RestaurantModel restaurantModel = RestaurantModel();
  List<RestaurantData> restaurantList = [];
  String lat = "", long = "";

  @override
  void onInit() {
    isLoaderVisible = false;
    super.onInit();
  }

  Future<void> callRestaurantAPI(Map<String, String>? queryParams) async {
    isLoaderVisible = !isLoaderVisible;
    update();
      await getRequestWithRequest(GeneralPath.API_RESTAURANT, queryParams!).then((
          response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> mResponse = jsonDecode(response.body);
          restaurantModel = RestaurantModel.fromJson(mResponse);
          if (restaurantModel.meta?.status == true) {
            debugPrint('status true: ${restaurantModel.meta?.status}');
            debugPrint('Response Home Data: ${restaurantModel.data}');

            restaurantList = restaurantModel.data!;
            debugPrint('restaurantList: ${restaurantList.length}');
            var filterlen = restaurantList.length;
            debugPrint('filterlen: $filterlen');
            var newLentgh = filterlen == null
                ? filterlen = 0
                : filterlen;
            debugPrint('newLenth: $newLentgh');
            for (var i = 0; i < newLentgh; i++) {
              if (restaurantList[i].restaurantName != null) {
                if (restaurantList[i].restaurantName?.isNotEmpty == true) {
                  String categoryName = "", openTime = "", closeTime = "";
                  dynamic totalDistance1;
                  if(restaurantList[i].distance != null){
                    var distance = restaurantList[i].distance;
                    dynamic totalDistance = num.parse(distance.toString()) / 1609.344;
                    // String dist =  totalDistance.round().toString();
                    // totalDistance1 =  dist.toString();
                    totalDistance1 =  totalDistance.round().toString();
                    debugPrint('totalDistance1: $totalDistance1');
                  }else{
                    totalDistance1 = "";
                  }

                  restaurantList[i].setTotalDistance = totalDistance1;

                  if(restaurantList[i].rootCategory?.isNotEmpty == true){
                      for (int j = 0; j < (restaurantList[i].rootCategory?.length ?? 0); j++) {
                        if (j == 0) {
                          categoryName =
                              restaurantList[i].rootCategory?[j]
                                  .categoryName ??
                                  "";
                        } else {
                          categoryName += ", " +
                              (restaurantList[i].rootCategory?[j]
                                  .categoryName ??
                                  "");
                        }
                    }
                  }else{
                    categoryName = "";
                  }

                  restaurantList[i].setCategoryName = categoryName;

                  if(restaurantList[i].timings != null){
                    if(restaurantList[i].timings?.isOpen  == false){
                      openTime = "";
                      closeTime = "";
                    }else {
                      if (restaurantList[i].timings?.openingTime?.isNotEmpty == true) {
                        openTime = restaurantList[i].timings?.openingTime.toString() ?? "";
                      } else {
                        openTime = "";
                      }
                      if (restaurantList[i].timings?.closingTime?.isNotEmpty == true) {
                        closeTime =
                            restaurantList[i].timings?.closingTime.toString() ?? "";
                      } else {
                        closeTime = "";
                      }
                    }
                  }

                  restaurantList[i].setOpeningTime = openTime;
                  restaurantList[i].setClosingTime = closeTime;
                  update();
                }
              }
            }
          }
          update();
          isLoaderVisible = !isLoaderVisible;
          update();
        }
        else {
          showToastMessage(restaurantModel.meta?.msg.toString() ?? "");
          isLoaderVisible = false;
          update();
          throw Exception('Failed to load data.');
        }
        update();
        return restaurantList;
      });
    }

  @override
  void dispose() {
    isLoaderVisible = false;
    super.dispose();
  }
}
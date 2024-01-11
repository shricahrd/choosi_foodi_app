import 'dart:convert';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../core/http_utils/http_constants.dart';
import '../../../core/http_utils/http_get_util.dart';
import '../../../core/http_utils/http_post_util.dart';
import '../../../core/utils/app_constants.dart';
import '../../../routes/general_path.dart';
import '../../cart/model/delete_cart_model.dart';
import '../../profile/model/change_pwd_model.dart';
import '../model/food_log_filter_model.dart';
import '../model/food_log_list_model.dart';

class FoodLogController extends GetxController {
  FoodLogListModel foodLogListModel = FoodLogListModel();
  List<FoodLogFilterMainList> foodLogFilterMainList = [];
  List<FoodData> foodLogFilterList = [];
  DeleteCartModel deleteCartModel = DeleteCartModel();
  bool isLoaderVisible = true;
  bool isLoaderTodayVisible = true;
  bool isLogUpdated = false;
  double caloriesCTotal = 0.0;
  double fatCTotal = 0.0;
  double carbsCTotal = 0.0;
  double proteinCTotal = 0.0;
  String createdDate = "";
  String apiTodayDate = "";
  late DateTime currentDate;

  @override
  void onInit() {
    foodLogFilterMainList.clear();
    super.onInit();
  }

  @override
  void dispose() {
    foodLogFilterMainList.clear();
    caloriesCTotal = 0.0;
    fatCTotal = 0.0;
    carbsCTotal = 0.0;
    proteinCTotal = 0.0;
    super.dispose();
  }

  initialTodayCalculation() {
    caloriesCTotal = 0.0;
    fatCTotal = 0.0;
    carbsCTotal = 0.0;
    proteinCTotal = 0.0;
    for (int i = 0; i < foodLogFilterList.length; i++) {
      double result1, result2, result3, result4;

      if (foodLogFilterList[i].calories != null) {
        if (foodLogFilterList[i].calories!.isNotEmpty) {
          result1 = double.parse(foodLogFilterList[i].calories.toString()) *
              (double.parse(foodLogFilterList[i].selectQuantity.toString()));
          foodLogFilterList[i].setCalories = result1;
          caloriesCTotal = caloriesCTotal + result1;
          update();
        } else {
          result1 = 0.0;
          foodLogFilterList[i].setCalories = result1;
          caloriesCTotal = caloriesCTotal + result1;
          update();
        }
      } else {
        result1 = 0.0;
        foodLogFilterList[i].setCalories = result1;
        caloriesCTotal = caloriesCTotal + result1;
        // caloriesTotal = 0.0;
        update();
      }

      if (foodLogFilterList[i].fat != null) {
        if (foodLogFilterList[i].fat!.isNotEmpty) {
          // print('fatTotalbefore: ${ foodLogFilterList[i].fat}');
          result2 = double.parse(foodLogFilterList[i].fat.toString()) *
              (double.parse(foodLogFilterList[i].selectQuantity.toString()));
          // print('Result2: $result2');
          foodLogFilterList[i].setFat = result2;
          fatCTotal = fatCTotal + result2;
          // print('fatTotal: $fatTotal');
          update();
        } else {
          // print('fatTotal empty: $fatTotal');
          fatCTotal = 0.0;
          result2 = 0.0;
          foodLogFilterList[i].setFat = result2;
          fatCTotal = fatCTotal + result2;
          update();
        }
      } else {
        // print('fatTotal null: $fatTotal');
        fatCTotal = 0.0;
        result2 = 0.0;
        foodLogFilterList[i].setFat = result2;
        fatCTotal = fatCTotal + result2;
        update();
      }

      if (foodLogFilterList[i].carbs != null) {
        if (foodLogFilterList[i].carbs!.isNotEmpty) {
          result3 = double.parse(foodLogFilterList[i].carbs.toString()) *
              (double.parse(foodLogFilterList[i].selectQuantity.toString()));
          foodLogFilterList[i].setCarbs = result3;
          carbsCTotal = carbsCTotal + result3;
          update();
        } else {
          result3 = 0.0;
          foodLogFilterList[i].setCarbs = result3;
          carbsCTotal = carbsCTotal + result3;
          update();
        }
      } else {
        result3 = 0.0;
        foodLogFilterList[i].setCarbs = result3;
        carbsCTotal = carbsCTotal + result3;
        update();
      }

      if (foodLogFilterList[i].protein != null) {
        if (foodLogFilterList[i].protein!.isNotEmpty) {
          result4 = double.parse(foodLogFilterList[i].protein.toString()) *
              (double.parse(foodLogFilterList[i].selectQuantity.toString()));
          foodLogFilterList[i].setProtein = result4;
          proteinCTotal = proteinCTotal + result4;
          update();
        } else {
          result4 = 0.0;
          foodLogFilterList[i].setProtein = result4;
          proteinCTotal = proteinCTotal + result4;
          update();
        }
      } else {
        result4 = 0.0;
        foodLogFilterList[i].setProtein = result4;
        proteinCTotal = proteinCTotal + result4;
        update();
      }
    }
  }

  initialTotalCategories(int index) {
    List<FoodData> foodLogFilterDateList = [];
    foodLogFilterDateList = foodLogFilterMainList[index].foodLogFilterList;
    print('FoodLogDateLen : ${foodLogFilterDateList.length} ');
    for (int i = 0; i < foodLogFilterDateList.length; i++) {
      double result1, result2, result3, result4;

      if (foodLogFilterDateList[i].calories != null) {
        if (foodLogFilterDateList[i].calories!.isNotEmpty) {
          result1 = double.parse(foodLogFilterDateList[i].calories.toString()) *
              (double.parse(
                  foodLogFilterDateList[i].selectQuantity.toString()));
          foodLogFilterDateList[i].setCalories = result1;
          update();
        } else {
          result1 = 0.0;
          foodLogFilterDateList[i].setCalories = result1;
          update();
        }
      } else {
        result1 = 0.0;
        foodLogFilterDateList[i].setCalories = result1;
        update();
      }

      if (foodLogFilterDateList[i].fat != null) {
        if (foodLogFilterDateList[i].fat!.isNotEmpty) {
          result2 = double.parse(foodLogFilterDateList[i].fat.toString()) *
              (double.parse(
                  foodLogFilterDateList[i].selectQuantity.toString()));
          foodLogFilterDateList[i].setFat = result2;
          update();
        } else {
          result2 = 0.0;
          foodLogFilterDateList[i].setFat = result2;
          update();
        }
      } else {
        result2 = 0.0;
        foodLogFilterDateList[i].setFat = result2;
        update();
      }

      if (foodLogFilterDateList[i].carbs != null) {
        if (foodLogFilterDateList[i].carbs!.isNotEmpty) {
          result3 = double.parse(foodLogFilterDateList[i].carbs.toString()) *
              (double.parse(
                  foodLogFilterDateList[i].selectQuantity.toString()));
          foodLogFilterDateList[i].setCarbs = result3;
          update();
        } else {
          result3 = 0.0;
          foodLogFilterDateList[i].setCarbs = result3;
          update();
        }
      } else {
        result3 = 0.0;
        foodLogFilterDateList[i].setCarbs = result3;
        update();
      }

      if (foodLogFilterDateList[i].protein != null) {
        if (foodLogFilterDateList[i].protein!.isNotEmpty) {
          result4 = double.parse(foodLogFilterDateList[i].protein.toString()) *
              (double.parse(
                  foodLogFilterDateList[i].selectQuantity.toString()));
          foodLogFilterDateList[i].setProtein = result4;
          update();
        } else {
          result4 = 0.0;
          foodLogFilterDateList[i].setProtein = result4;
          update();
        }
      } else {
        result4 = 0.0;
        foodLogFilterDateList[i].setProtein = result4;
        update();
      }
    }
  }

  callFoodLogListAPI() {
    foodLogFilterMainList.clear();

    getRequest(GeneralPath.API_FOOD_LOG_LIST).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        List dateList = [];
        // List<FoodData>? foodData = [];
        dynamic uniqList;
        foodLogListModel = FoodLogListModel.fromJson(mResponse);
        if (foodLogListModel.meta?.status == true) {
          print('status true: ${foodLogListModel.meta?.status}');
          for (int i = 0; i < foodLogListModel.data!.length; i++) {
            // parseTimeStampReport(int.parse(foodLogListModel.data![i].createdAt.toString()));
            var date = DateTime.fromMicrosecondsSinceEpoch(
                int.parse(foodLogListModel.data![i].createdAt.toString()) *
                    1000);
            var d12 = formatterMDY.format(date);
            createdDate = d12;
            dateList.add(createdDate);
            uniqList = dateList.toSet().toList();
            print('UniqDate : $uniqList');
            // foodData = foodLogListModel.data;
            currentDate = DateTime.now();
            var cDate = formatterMDY.format(currentDate);
            print('cDate: $cDate');
            print('apiDate: $createdDate');
            /* if(createdDate.compareTo(cDate) < 0){

              initialTotalCategories();
              isLoaderVisible = false;
              isLoaderTodayVisible = false;
              update();
            }*/
            if (cDate.compareTo(createdDate) == 0) {
              // print("Both date time are at same moment.");
              apiTodayDate = createdDate;
              // print("apiTodayDate: $apiTodayDate");
              foodLogFilterList.add(foodLogListModel.data![i]);
              print("FilterData Len: ${foodLogFilterList.length}");
              initialTodayCalculation();
              isLoaderTodayVisible = false;
              update();
            }
          }

          for (int i = 0; i < uniqList.length; i++) {
            //stringdateList 4
            List<FoodData>? foodData = [];
            for (int j = 0; j < foodLogListModel.data!.length; j++) {
              //templist
              var date = DateTime.fromMicrosecondsSinceEpoch(
                  int.parse(foodLogListModel.data![j].createdAt.toString()) *
                      1000);
              var d12 = formatterMDY.format(date);
              createdDate = d12;

              if (uniqList[i] == createdDate) {
                // print('Match : $foodData');
                foodData.add(foodLogListModel.data![j]);
                // foodLogFilterMainList.add(FoodLogFilterMainList(date: uniqList[i], foodLogFilterList: tempfiltereddatelist));
              }

              if (j == (foodLogListModel.data!.length - 1)) {
                print('End j loop : ----');
                foodLogFilterMainList.add(FoodLogFilterMainList(
                    date: uniqList[i], foodLogFilterList: foodData));
                initialTotalCategories(i);
                isLoaderVisible = false;
                isLoaderTodayVisible = false;
                update();
              }
            }
          }

          print('FoodMainList len: ${foodLogFilterMainList.length}');
          print(
              'FoodMainList : ${jsonEncode(foodLogFilterMainList.map((player) => player.toMap()).toList())}');
          update();
        } else {
          isLoaderTodayVisible = false;
          isLoaderVisible = false;
          update();
        }
      } else {
        showToastMessage(foodLogListModel.meta!.msg.toString());
        isLoaderTodayVisible = true;
        isLoaderVisible = true;
        throw Exception('Failed to load data.');
      }
      update();
    });
  }

  callDeleteMenuAPI(String menuid) {
    var url = GeneralPath.API_FOOD_LOG_MENU_DELETE + menuid;
    deleteRequest(url).then((response) {
      if (response.statusCode == 200) {
        print('Response Data: ${response.body}');
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        ChangePwdModel changePwd = ChangePwdModel.fromJson(mResponse);
        callFoodLogListAPI();
        showToastMessage(changePwd.meta.msg.toString());
      } else {
        showToastMessage("Something wrong please contact Admin");
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return deleteCartModel;
    });
  }

  Future<void> callUpdateLogAPI({
    required String foodLogId,
    required String selectQuantity,
  }) async {
    // isLogUpdated = true;
    // update();
    final params = jsonEncode({
      HttpConstants.PARAMS_FOODLOGID: foodLogId,
      HttpConstants.PARAMS_SELECTQTY: selectQuantity,
    });
    await putRequest(GeneralPath.API_FOOD_LOG_UPDATE, params).then((response) {
      if (response.statusCode == 200) {
        print('Response Data: ${response.body}');
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        deleteCartModel = DeleteCartModel.fromJson(mResponse);
        if (deleteCartModel.meta?.status == true) {
          print('status : ${deleteCartModel.meta?.status}');
          showToastMessage(deleteCartModel.meta!.msg.toString());
          isLogUpdated = true;
          callFoodLogListAPI();
          update();
        } else {
          showToastMessage(deleteCartModel.meta!.msg.toString());
          isLogUpdated = false;
          update();
        }
      } else {
        showToastMessage(deleteCartModel.meta!.msg.toString());
        isLogUpdated = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return deleteCartModel;
    });
  }
}

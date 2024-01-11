import 'dart:convert';
import 'package:choosifoodi/core/utils/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import '../../../core/http_utils/http_get_util.dart';
import '../../../core/http_utils/http_post_util.dart';
import '../../../core/utils/app_constants.dart';
import '../../../routes/general_path.dart';
import '../../cart/model/delete_cart_model.dart';
import '../model/get_foodi_goal_model.dart.dart';

class FoodieViewController extends GetxController {
  bool isLoaderVisible = false;
  dynamic lat = "", long = "";
  var userGoal, activityLeval, gender;
  DeleteCartModel deleteCartModel = DeleteCartModel();
  FoodiGoalModel foodiGoalModel = FoodiGoalModel();
  bool isFoodGoalUpdate = false;
  dynamic caloriesMeal, fatMeal, carbsMeal, proteinMeal;

  @override
  void onInit() {
    super.onInit();
    isLoaderVisible = false;
    getSharedPrefsData();
  }

  getSharedPrefsData() async{
    lat = await AppPreferences.getLat();
    long = await AppPreferences.getLong();
    debugPrint('Lat: $lat');
    debugPrint('Long: $long');
    var data = await AppPreferences.getUserData();
    userGoal = jsonEncode(data?.userGoal.toString());
    activityLeval = jsonEncode(data?.activityLevel.toString());
    gender = jsonEncode(data?.gender.toString());
    debugPrint('goal: $userGoal, leval: $activityLeval, gender: $gender');
  }

  // API_FOOD_GOAL

  Future<void>callFoodGoalUpdateAPI({required final params}) async{
    isFoodGoalUpdate = !isFoodGoalUpdate;
    update();

    await putRequest(GeneralPath.API_FOOD_GOAL, params).then((response) {
      if (response.statusCode == 200) {
        debugPrint('Response Data: ${response.body}');
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        deleteCartModel = DeleteCartModel.fromJson(mResponse);
        if (deleteCartModel.meta?.status == true) {
          debugPrint('status : ${deleteCartModel.meta?.status}');
          // showToastMessage(deleteCartModel.meta?.msg ?? "");
          // isFoodGoalUpdate = true;
          // update();
        }else{
          showToastMessage(deleteCartModel.meta?.msg ?? "");
          // isFoodGoalUpdate = false;
          // update();
        }
        // isFoodGoalUpdate = !isFoodGoalUpdate;
        // update();
      } else {
        showToastMessage(deleteCartModel.meta?.msg ?? "");
        // isFoodGoalUpdate = false;
        // update();
        throw Exception('Failed to load data.');
      }
      isFoodGoalUpdate = !isFoodGoalUpdate;
      update();
      update();
      return deleteCartModel;
    });
  }

  Future<void>callGetFoodGoalAPI() async{
    await getRequest(GeneralPath.API_FOOD_GOAL).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);

        foodiGoalModel = FoodiGoalModel.fromJson(mResponse);
        if (foodiGoalModel.meta?.status == true) {
          debugPrint('status true: ${foodiGoalModel.meta?.status}');
          debugPrint('Response callGetFoodGoalAPI Data: ${foodiGoalModel.data}');
          var meal = foodiGoalModel.data?.meals;
          debugPrint(meal.runtimeType.toString());
          // fatMeal = double.parse(foodiGoalModel.data?.fat.toString() ?? "") ~/ double.parse(meal.toString());
          if(foodiGoalModel.data?.caloriesPerDay != null) {
            caloriesMeal = double.parse(foodiGoalModel.data?.caloriesPerDay.toString() ?? "") /
                double.parse(meal.toString());
            debugPrint('caloriesMeal: $caloriesMeal');
          }

          if(foodiGoalModel.data?.fat != null) {
            fatMeal = double.parse(foodiGoalModel.data?.fat.toString() ?? "") /
                double.parse(meal.toString());
            debugPrint('fatMeal: $fatMeal');
          }
          // carbsMeal = int.parse(foodiGoalModel.data!.carbohydrates.toString().split('.').first) ~/ int.parse(meal.toString());
          if(foodiGoalModel.data?.carbohydrates != null) {
            debugPrint('protein: ${foodiGoalModel.data?.carbohydrates}');
            carbsMeal = double.parse(
                foodiGoalModel.data?.carbohydrates.toString() ?? "") /
                double.parse(meal.toString());
            debugPrint('carbsMeal: $carbsMeal');
          }
          if(foodiGoalModel.data?.protein != null) {
            debugPrint('protein: ${foodiGoalModel.data?.protein}');
            proteinMeal =
                double.parse(foodiGoalModel.data?.protein.toString() ?? "") /
                    double.parse(meal.toString());
          }
          debugPrint('proteinMeal: $proteinMeal');
        }
        isLoaderVisible = !isLoaderVisible;
        update();
      } else {
        showToastMessage(foodiGoalModel.meta?.msg.toString() ?? "");
        isLoaderVisible = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return foodiGoalModel;
    });
  }

  @override
  void dispose() {
    isLoaderVisible = false;
    super.dispose();
  }
}
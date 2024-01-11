import 'dart:convert';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../core/http_utils/http_get_util.dart';
import '../models/foodi_fact_model.dart';

class FoodiFactController extends GetxController {
  bool isLoaderVisible = true;
  FoodiFactModel foodiFactModel = FoodiFactModel();

  @override
  void onInit() {
    isLoaderVisible = true;
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  callGetFoodFactListAPI() {
    getRequest(GeneralPath.API_FOOD_FACT_LIST).then((response) {

      if (response.statusCode == 200) {
        foodiFactModel = FoodiFactModel.fromJson(json.decode(response.body));
        if (foodiFactModel.meta?.status == true) {
          print('status true: ${foodiFactModel.meta?.status}');
          print('Response Data: ${foodiFactModel.data}');
          isLoaderVisible = false;
          update();
        }else{
          isLoaderVisible = false;
          update();
        }
      } else {
        showToastMessage(foodiFactModel.meta!.msg.toString());
        isLoaderVisible = true;
        update();
        throw Exception('Failed to load data.');
      }
      update();
    });
  }
}

import 'dart:convert';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import '../../../core/http_utils/http_get_util.dart';
import '../model/foodi_highlight_model.dart';

class FoodiHighlightFilterCtrl extends GetxController {
  bool isLoaderVisible = false;
  FoodiHighlightModel foodiHighlightModel = FoodiHighlightModel();
  List<FoodiHighlightsItem> foodiHighlightList = [];
  String lat = "", long = "";

  @override
  void onInit() {
    isLoaderVisible = false;
    super.onInit();
  }

  Future<void> callFoodiHighlightAPI(Map<String, String>? queryParams) async {
    isLoaderVisible = !isLoaderVisible;
    update();
      await getRequestWithRequest(GeneralPath.API_FOODIE_HIGHLIGHT, queryParams!).then((
          response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> mResponse = jsonDecode(response.body);
          foodiHighlightModel = FoodiHighlightModel.fromJson(mResponse);
          if (foodiHighlightModel.meta?.status == true) {
            debugPrint('status true: ${foodiHighlightModel.meta?.status}');
            debugPrint('Response Home Data: ${foodiHighlightModel.data}');

            foodiHighlightList = foodiHighlightModel.data!.foodiHighlights;
            debugPrint('foodiHighlightList: ${foodiHighlightList.length}');
            var filterlen = foodiHighlightList.length;
            debugPrint('filterlen: $filterlen');
            var newLentgh = filterlen == null
                ? filterlen = 0
                : filterlen;
            debugPrint('newLenth: $newLentgh');
          }
          update();
          isLoaderVisible = !isLoaderVisible;
          update();
        }
        else {
          showToastMessage(foodiHighlightModel.meta?.msg.toString() ?? "");
          isLoaderVisible = false;
          update();
          throw Exception('Failed to load data.');
        }
        update();
        return foodiHighlightList;
      });
    }

  @override
  void dispose() {
    isLoaderVisible = false;
    super.dispose();
  }
}
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../core/http_utils/http_constants.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../../../../routes/general_path.dart';
import '../../../home/model/review_list_model.dart';

class RestReviewController extends GetxController{
  ReviewListModel reviewListModel = ReviewListModel();
  bool isReviewVisible = false;

  Future<void> callRestaurantReviewListAPI(String? startDate, String? endDate) async {
    isReviewVisible = true;
    update();

    Map<String, String> queryParams = {
      HttpConstants.PARAMS_REST_STARTDATE: startDate.toString(),
      HttpConstants.PARAMS_REST_ENDDATE: endDate.toString(),
    };

    await getRequestWithRequest(GeneralPath.API_REVIEW_LIST, queryParams).then((response) {

      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);

        reviewListModel = ReviewListModel.fromJson(mResponse);
        if (reviewListModel.meta?.status == true) {
          debugPrint('status true: ${reviewListModel.meta?.status}');
          debugPrint('Response Review Data: ${reviewListModel.data}');
        }
      } else {
        throw Exception('Failed to load data.');
      }
      isReviewVisible = false;
      update();
      return reviewListModel;
    });
  }

}
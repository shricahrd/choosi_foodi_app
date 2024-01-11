import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/http_utils/http_constants.dart';
import '../../../core/http_utils/http_get_util.dart';
import '../../../core/utils/app_constants.dart';
import '../../../routes/general_path.dart';
import '../model/review_list_model.dart';

class TestimonialsController extends GetxController{
  ReviewListModel reviewListModel = ReviewListModel();
  bool isReviewVisible = false;

  Future<void> callRestaurantReviewListAPI(String? restId) async {
    isReviewVisible = !isReviewVisible;
    update();

    Map<String, String> queryParams = {
      HttpConstants.PARAMS_RESTID: restId.toString(),
    };

    // await getRequest(GeneralPath.API_REVIEW_LIST + "?$restId").then((response) {
    await getRequestWithRequest(GeneralPath.API_REVIEW_LIST, queryParams).then((response) {

      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);

        reviewListModel = ReviewListModel.fromJson(mResponse);
        if (reviewListModel.meta?.status == true) {
          print('status true: ${reviewListModel.meta?.status}');
          print('Response Review Data: ${reviewListModel.data}');
        }
        isReviewVisible = !isReviewVisible;
        update();
      } else {
        isReviewVisible = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return reviewListModel;
    });
  }

  Future<void> callReviewListAPI(String? restId) async {
    isReviewVisible = !isReviewVisible;
    update();

    // await getRequest(GeneralPath.API_REVIEW_LIST + "?$restId").then((response) {
    await getRequest(GeneralPath.API_REVIEW_LIST).then((response) {

      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);

        reviewListModel = ReviewListModel.fromJson(mResponse);
        if (reviewListModel.meta?.status == true) {
          print('status true: ${reviewListModel.meta?.status}');
          print('Response Review Data: ${reviewListModel.data}');
        }
        isReviewVisible = !isReviewVisible;
        update();
      } else {
        isReviewVisible = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return reviewListModel;
    });
  }
}
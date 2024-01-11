
import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../core/http_utils/http_constants.dart';
import '../../../core/http_utils/http_post_util.dart';
import '../../../core/utils/app_constants.dart';
import '../../../routes/general_path.dart';
import '../model/add_rating_model.dart';

class RatingController extends GetxController {
  bool isLoaderVisible = true;
  AddRatingModel addRatingModel = AddRatingModel();

  Future<void> postRatingApi({
    required String restId,
    required dynamic rating,
    required String review,
  }) async {
    final params = jsonEncode({
      HttpConstants.PARAMS_RESTID: restId,
      HttpConstants.PARAMS_RATING: rating,
      HttpConstants.PARAMS_REVIEW: review,
    });

    await postRequest(GeneralPath.API_ADD_REVIEW, params).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        addRatingModel = AddRatingModel.fromJson(mResponse);
        if (addRatingModel.meta?.status == true) {
          showToastMessage(addRatingModel.meta!.msg.toString());
          print('status in Controller: ${addRatingModel.meta?.status}');
          isLoaderVisible = false;
          update();
        } else {
          showToastMessage(addRatingModel.meta!.msg.toString());
          isLoaderVisible = false;
          update();
        }
        update();
      } else {
        showToastMessage(addRatingModel.meta!.msg!);
        isLoaderVisible = true;
        update();
      }
      update();
      return addRatingModel;
    });
  }
}
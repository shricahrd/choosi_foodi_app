import 'dart:convert';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../core/http_utils/http_get_util.dart';
import '../models/about_us_model.dart.dart';
import '../models/faq_list_model.dart';
import '../models/terms_model.dart.dart';

class TermsController extends GetxController {
  bool isLoaderVisible = false;
  TermsModel termsModel = TermsModel();

  callTermsAPI() {
    getUserRequest(GeneralPath.API_TERMS).then((response) {
      if (response.statusCode == 200) {
        termsModel = TermsModel.fromJson(json.decode(response.body));
        if (termsModel.meta?.status == true) {
          print('status true: ${termsModel.meta?.status}');
          print('Response Data: ${termsModel.data}');
        }
        isLoaderVisible = !isLoaderVisible;
        update();
      } else {
        showToastMessage(termsModel.meta!.msg.toString());
        isLoaderVisible = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
    });
  }
}

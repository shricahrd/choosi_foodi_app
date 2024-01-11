import 'dart:convert';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../core/http_utils/http_get_util.dart';
import '../models/about_us_model.dart.dart';
import '../models/faq_list_model.dart';

class AboutUsController extends GetxController {
  bool isLoaderVisible = true;
  bool isLoaderVisiblePP = false;
  AboutUsModel aboutUsModel = AboutUsModel();

  callAboutUsAPI() {
    // isLoaderVisible = !isLoaderVisible;
    // update();
    getRequest(GeneralPath.API_ABOUT_US).then((response) {

      if (response.statusCode == 200) {
        aboutUsModel = AboutUsModel.fromJson(json.decode(response.body));
        if (aboutUsModel.meta?.status == true) {
          print('status true: ${aboutUsModel.meta?.status}');
          print('Response Data: ${aboutUsModel.data}');
          isLoaderVisible = false;
          update();
        }
        // isLoaderVisible = !isLoaderVisible;
        // update();
      } else {
        showToastMessage(aboutUsModel.meta?.msg.toString() ?? "");
        isLoaderVisible = true;
        update();
        throw Exception('Failed to load data.');
      }
      update();
    });
  }

  callPrivacyPolicyAPI() {
    getUserRequest(GeneralPath.API_PRIVACY_POLICY).then((response) {
      if (response.statusCode == 200) {
        aboutUsModel = AboutUsModel.fromJson(json.decode(response.body));
        if (aboutUsModel.meta?.status == true) {
          print('status true: ${aboutUsModel.meta?.status}');
          print('Response Data: ${aboutUsModel.data}');
        }
        isLoaderVisiblePP = !isLoaderVisiblePP;
        update();
      } else {
        showToastMessage(aboutUsModel.meta?.msg.toString() ?? "");
        isLoaderVisiblePP = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
    });
  }
}

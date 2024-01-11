import 'dart:convert';
import 'package:choosifoodi/core/http_utils/http_constants.dart';
import 'package:choosifoodi/core/http_utils/http_post_util.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import '../../../routes/all_routes.dart';
import '../model/reset_password_data_model.dart';

class ResetPwdController extends GetxController {

  bool isLoaderVisible = false;
  TextEditingController passwordController = new TextEditingController();
  String email = '';
  String otpText = '';

  @override
  void onInit() {
    isLoaderVisible = false;
    super.onInit();
  }

  callResetPasswordAPI({required String mobile,required String password,}) {
    isLoaderVisible = !isLoaderVisible;
    update();

    final params = jsonEncode({
      HttpConstants.PARAMS_MOBILE: mobile,
      HttpConstants.PARAMS_PASSWORD: password,
    });
    postRequest(GeneralPath.API_RESET_PASSWORD, params).then((response) {

      if (response.statusCode == 200) {
        ResetPasswordDataModel resetPasswordDataModel =
        ResetPasswordDataModelFromJson(response.body.toString());
        showToastMessage(resetPasswordDataModel.meta.msg);
        if (resetPasswordDataModel.meta.status == true) {
          Get.offAllNamed(AllRoutes.login);
        }else{
          showToastMessage(resetPasswordDataModel.meta.msg);
        }
        isLoaderVisible = !isLoaderVisible;
        update();
      } else {
        isLoaderVisible = !isLoaderVisible;
        update();
        throw Exception('Failed to load data.');
      }
      update();
    });
  }
}

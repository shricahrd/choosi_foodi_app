import 'dart:convert';
import 'package:choosifoodi/core/http_utils/http_constants.dart';
import 'package:choosifoodi/core/http_utils/http_post_util.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import '../model/ForgotPasswordModel.dart';
import '../view/user_otp_verify_screen.dart';

class ForgotPwdController extends GetxController {
  bool isLoaderVisible = false;
  TextEditingController phoneNumberController = new TextEditingController();

  @override
  void onInit() {
    isLoaderVisible = false;
    super.onInit();
  }

  callForgotPasswordAPI({required String mobile,}) {
    isLoaderVisible = !isLoaderVisible;
    update();
    final params = jsonEncode({
      HttpConstants.PARAMS_MOBILE: mobile,
    });
    postRequest(GeneralPath.API_FORGET_PASSWORD, params).then((response) {
      if (response.statusCode == 200) {
        ForgotPasswordModel forgotPasswordModel = forgotPasswordModelFromJson(response.body.toString());
        if (forgotPasswordModel.meta?.status == true) {
          Get.to(() => UserOTPVerifyScreen(mobile: mobile,));
        }else{
          showToastMessage(forgotPasswordModel.meta!.msg.toString());
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

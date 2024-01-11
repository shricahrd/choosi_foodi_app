import 'dart:convert';
import 'package:choosifoodi/core/http_utils/http_constants.dart';
import 'package:choosifoodi/core/http_utils/http_post_util.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:choosifoodi/screens/restaurants_panel/signup/view/restaurant_otp_verify_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import '../../../forgot_password/model/ForgotPasswordModel.dart';

class RestaurantMobileController extends GetxController {
  bool isLoaderVisible = false;
  TextEditingController mobileController = new TextEditingController();

  @override
  void onInit() {
    isLoaderVisible = false;
    super.onInit();
  }

  callMobileVerifyAPI({required String mobile,}) {
    isLoaderVisible = !isLoaderVisible;
    update();
    final params = jsonEncode({
      HttpConstants.PARAMS_MOBILE: mobile,
    });
     postRequest(GeneralPath.API_MOBILE_VERIFY, params).then((response) {

      if (response.statusCode == 200) {
        ForgotPasswordModel forgotPasswordDataModel =
            forgotPasswordModelFromJson(response.body.toString());
        if (forgotPasswordDataModel.meta!.status == false) {
          // var otp = forgotPasswordDataModel.data?.otp;
          // print('Otp: $otp');
          // showSnackBar('Your Otp is : $otp');
          Get.to(() => RestaurantOTPVerifyScreen(mobile: mobile, ),);
        }else{
          showToastMessage(forgotPasswordDataModel.meta!.msg.toString());
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

  @override
  void dispose() {
    isLoaderVisible = true;
    super.dispose();
  }
}
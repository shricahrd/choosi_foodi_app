import 'dart:convert';
import 'package:choosifoodi/core/http_utils/http_constants.dart';
import 'package:choosifoodi/core/http_utils/http_post_util.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/model/forgot_password/forgot_password_data_model.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import '../../../forgot_password/model/ForgotPasswordModel.dart';
import '../view/tabs/signup_tab_screen.dart';

class RestaurantOTPVerifyController extends GetxController {
  bool isLoaderVisible = false;
  TextEditingController otpController = new TextEditingController();
  ForgotPasswordModel forgotPasswordModel =  ForgotPasswordModel();
  bool isVerified = false;
  var otpText = 0;

  @override
  void onInit() {
    isLoaderVisible = false;
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }


  callOtpVerifyAPI({required String mobile, required String otp, }) {

    final params = jsonEncode({
      HttpConstants.PARAMS_MOBILE: mobile,
      HttpConstants.PARAMS_OTP: otp,
    });
    postRequest(GeneralPath.API_OTP_VERIFY, params).then((response) {

      if (response.statusCode == 200) {
        ForgotPasswordDataModel forgotPasswordModel =
        ForgotPasswordDataModelFromJson(response.body.toString());

        showToastMessage(forgotPasswordModel.meta.msg.toString());
        isLoaderVisible = true;
        isVerified = true;
        update();
        if (forgotPasswordModel.meta.status) {
            Get.offAll(() => SignupTabScreen(mobile: mobile,));
            // Get.offAll(() => SignupVendorScreen(mobile: mobile,));
        }
      } else {
        isVerified = false;
        isLoaderVisible = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
    });
  }

  callMobileVerifyAPI({required String mobile,}) {

    final params = jsonEncode({
      HttpConstants.PARAMS_MOBILE: mobile,
    });
    postRequest(GeneralPath.API_MOBILE_VERIFY, params).then((response) {

      if (response.statusCode == 200) {
        ForgotPasswordModel forgotPasswordModel =  ForgotPasswordModel();
       forgotPasswordModel = forgotPasswordModelFromJson(response.body.toString());
        showToastMessage(forgotPasswordModel.meta?.msg.toString() ?? "");
        if (forgotPasswordModel.meta!.status == true) {
          var otp = forgotPasswordModel.data?.otp;
          print('Otp: $otp');
          otpText = otp!;
          update();
          print('OtpText: $otpText');
        }
      } else {

        isLoaderVisible = false;
        throw Exception('Failed to load data.');
      }
      update();
    });
  }

}
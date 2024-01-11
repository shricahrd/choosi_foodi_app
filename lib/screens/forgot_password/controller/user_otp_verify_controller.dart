import 'dart:convert';
import 'package:choosifoodi/core/http_utils/http_constants.dart';
import 'package:choosifoodi/core/http_utils/http_post_util.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/model/forgot_password/forgot_password_data_model.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

import '../../reset_password/view/reset_password_screen.dart';
import '../model/ForgotPasswordModel.dart';

class UserOTPVerifyController extends GetxController {
  bool isLoaderVisible = false;
  var otpText = 0;
  ForgotPasswordModel forgotPasswordModel =  ForgotPasswordModel();

  @override
  void onInit() {
    isLoaderVisible = false;
    super.onInit();
  }

  callOtpVerifyAPI({required String mobile, required String otp, }) {
    isLoaderVisible = !isLoaderVisible;
    update();
    final params = jsonEncode({
      HttpConstants.PARAMS_MOBILE: mobile,
      HttpConstants.PARAMS_OTP: otp,
    });
    postRequest(GeneralPath.API_USER_OTP_VERIFY, params).then((response) {

      if (response.statusCode == 200) {
        ForgotPasswordDataModel forgotPasswordDataModel =
        ForgotPasswordDataModelFromJson(response.body.toString());

        showToastMessage(forgotPasswordDataModel.meta.msg);
        if (forgotPasswordDataModel.meta.status == true) {
            Get.offAll(() => ResetPasswordScreen(mobile: mobile,));
        }else{
          showToastMessage(forgotPasswordDataModel.meta.msg);
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

  Future<void>callMobileVerifyAPI({required String mobile,}) async{

    final params = jsonEncode({
      HttpConstants.PARAMS_MOBILE : mobile,
    });
    await postRequest(GeneralPath.API_FORGET_PASSWORD, params).then((response) {

      if (response.statusCode == 200) {
        forgotPasswordModel =
        forgotPasswordModelFromJson(response.body.toString());
        showToastMessage(forgotPasswordModel.meta!.msg.toString());
        if (forgotPasswordModel.meta!.status == true) {
          var otp = forgotPasswordModel.data?.otp;
          print('Otp: $otp');
          otpText = otp!;
          update();
          print('OtpText: $otpText');
        }
      } else {
        throw Exception('Failed to load data.');
      }
      update();
      return otpText;
    }


    );
  }

}
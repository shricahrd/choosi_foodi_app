import 'dart:convert';

import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../core/http_utils/http_constants.dart';
import '../../../core/http_utils/http_post_util.dart';
import '../model/change_pwd_model.dart';

class ChangePwdController extends GetxController {
  bool isLoaderVisible = false;
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  Future<void> changePasswordApi(
      {required String password, required String confirmPassword}) async {
    isLoaderVisible = !isLoaderVisible;
    update();

    final params = jsonEncode(
        {  HttpConstants.PARAMS_CONFIRM_PASSWORD: confirmPassword,
          HttpConstants.PARAMS_PASSWORD: password,
        }
    );

    await postRequest(GeneralPath.API_CHANGE_PWD, params).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        ChangePwdModel changePwdModel = ChangePwdModel.fromJson(mResponse);
        if (changePwdModel.meta.status == true) {
          showToastMessage(changePwdModel.meta.msg.toString());
          debugPrint('status in Controller: ${changePwdModel.meta.status}');
        } else {
          showToastMessage(changePwdModel.meta.msg.toString());
        }
        Get.back();
      }
      isLoaderVisible = !isLoaderVisible;
      update();
    });
  }
}

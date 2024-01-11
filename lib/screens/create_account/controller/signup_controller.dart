import 'dart:convert';
import 'package:choosifoodi/core/http_utils/http_constants.dart';
import 'package:choosifoodi/core/http_utils/http_post_util.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/model/registration/registration_data_model.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:choosifoodi/screens/location_details/view/location_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class SignupController extends GetxController {
  var passwordVisible = false;
  bool isLoaderVisible = false;
  // TextEditingController fNameController = new TextEditingController();
  // TextEditingController lNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  late RegistrationDataModel registrationDataModel;

  @override
  void onInit() {
    isLoaderVisible = false;
    super.onInit();
  }

  pwdOnOff(){
    passwordVisible = !passwordVisible;
    update();
  }

  clearController(){
    // fNameController.clear();
    // lNameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneNumberController.clear();
  }

  callRegistrationAPI() {
    isLoaderVisible = !isLoaderVisible;
    update();

    final params = jsonEncode({
      HttpConstants.PARAMS_EMAIL: emailController.text,
      HttpConstants.PARAMS_PASSWORD: passwordController.text,
      HttpConstants.PARAMS_PHONE_NUMBER: phoneNumberController.text,
    });

    postRequest(GeneralPath.API_REGISTRATION, params).then((response) {
      if (response.statusCode == 200) {
        registrationDataModel =
        RegistrationDataModelFromJson(response.body.toString());
        if(registrationDataModel.meta.status == true) {
          showToastMessage(registrationDataModel.meta.msg);
          Future.delayed(const Duration(milliseconds: 1000), () {
            Get.offAll(LocationDetailsScreen(
              isFromSignup: true,
              mobile: phoneNumberController.text,
            ));
           /* Get.offAll(FoodiGoalAddEditScreen(
              isEditFoodiGoal: false,
              isFromHome: false,
              isFromSignup: true,
            ));*/
          });
        }else{
          showToastMessage(registrationDataModel.meta.msg);
        }
      } else {
        isLoaderVisible = !isLoaderVisible;
        showToastMessage(registrationDataModel.meta.msg);
        update();
        throw Exception('Failed to load data.');
      }
      isLoaderVisible = !isLoaderVisible;
      update();
    });
  }

  /*onClickSetupLater() async {
    await Get.to(()=>LocationDetailsScreen(
      isFromSignup: true,
      mobile: '8989898989',
      userName: 'test1',
    ));
    print('Back to Signup');
    isLoaderVisible = false;
    update();
    clearController();
  }*/
}
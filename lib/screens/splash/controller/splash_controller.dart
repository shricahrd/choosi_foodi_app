import 'package:choosifoodi/core/utils/app_preferences.dart';
import 'package:choosifoodi/model/login/user_data_model.dart';
import 'package:choosifoodi/routes/all_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_constants.dart';
import '../../../model/login/vendorLogin/vendor_data_model.dart';
import '../../start/view/start_screen.dart';

class SplashController extends GetxController{

  @override
  void onInit(){
    print('initSplash');
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
      // Color(WHITE),
    ));
    Future.delayed(const Duration(milliseconds: 3000), () {
      checkIsLogin();
    });
    super.onInit();
  }

  void checkIsLogin() {
    AppPreferences.getIsLogin().then((value) => {
      if (value == true){

        if (IsCustomerApp) {
          AppPreferences.getUserData().then((userData) => {
            if (userData != null)
              {
                moveToBaseScreen(userData)
              }
          })
        }else{
          AppPreferences.getVendorData().then((userData) => {
            if (userData != null)
              {
                moveToRestaurantBaseScreen(userData)
              }
          })
        }
      }
      else {
          Get.toNamed(AllRoutes.start)
        }
    });
    getFirebaseToken();
  }

  void getFirebaseToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      print("FCM Token : $token"); // Print the Token in Console
      AppPreferences.setFireToken(token.toString());
      print("FCM Set Token : $token");
    }).catchError((onError) {});
  }

  void moveToBaseScreen(UserDataModel userData) {
    userDataModel = userData;
    Get.offAndToNamed(AllRoutes.baseUser);
  }

  void moveToRestaurantBaseScreen(VendorDataModel userData) {
    vendorDataModel = userData;
    Get.offAndToNamed(AllRoutes.baseRestaurant);
  }

}

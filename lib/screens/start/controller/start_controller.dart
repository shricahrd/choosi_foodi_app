import 'package:choosifoodi/core/utils/app_preferences.dart';
import 'package:choosifoodi/model/login/user_data_model.dart';
import 'package:choosifoodi/model/login/vendorLogin/vendor_data_model.dart';
import 'package:choosifoodi/routes/all_routes.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_constants.dart';
import '../../location_details/view/location_details_screen.dart';
import '../../start/view/start_screen.dart';

class StartController extends GetxController {

  @override
  void onInit() {
    print('initStart');
    super.onInit();
  }

  void checkIsLogin() {
    AppPreferences.getIsLogin().then((value) => {
          if (value == true){
              if (IsCustomerApp){
                  AppPreferences.getUserData().then((userData) => {
                        if (userData != null) {moveToBaseScreen(userData)}
                      })
                }
              else {
                  AppPreferences.getVendorData().then((userData) => {
                        if (userData != null)
                          {moveToRestaurantBaseScreen(userData)}
                      })
                }
            }
          else {
              Get.toNamed(AllRoutes.login)
            }
        });
  }

  void moveToBaseScreen(UserDataModel userData) {
    userDataModel = userData;
    Get.offAndToNamed(AllRoutes.baseUser);
  }

  void moveToRestaurantBaseScreen(VendorDataModel userData) {
    vendorDataModel = userData;
    Get.offAndToNamed(AllRoutes.baseRestaurant);
  }

  onClickSignUp() {
    if (IsCustomerApp) {
      Get.toNamed(AllRoutes.signupUser);
    } else {
      // Get.to(()=>SignupTabScreen());
      Get.toNamed(AllRoutes.restMobile);
    }
  }
}

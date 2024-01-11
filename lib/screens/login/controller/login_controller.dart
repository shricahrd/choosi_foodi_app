import 'dart:convert';
import 'package:choosifoodi/core/http_utils/http_constants.dart';
import 'package:choosifoodi/core/http_utils/http_post_util.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/utils/app_preferences.dart';
import 'package:choosifoodi/model/login/login_data_model.dart';
import 'package:choosifoodi/model/login/user_data_model.dart';
import 'package:choosifoodi/model/login/vendorLogin/login_vendor_model.dart';
import 'package:choosifoodi/routes/all_routes.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:choosifoodi/screens/login/view/login_view.dart';
import 'package:choosifoodi/screens/start/view/start_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../model/login/vendorLogin/vendor_data_model.dart';
import '../model/social_login_model.dart.dart';

class LoginController extends GetxController {
  var passwordVisible = false;
  bool isLoaderVisible = false;
  TextEditingController uNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool isRestaurantAdded = false;
  SocialLoginModel socialLoginModel = SocialLoginModel();
  bool isEnable = true;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void onInit() {
    isLoaderVisible = false;
    super.onInit();
  }

  pwdOnOff() {
    passwordVisible = !passwordVisible;
    update();
  }

  callLoginAPI({required String mobile, required String password, required String token}) {
    isLoaderVisible = !isLoaderVisible;
    isEnable = false;
    update();
    final params = jsonEncode({
      HttpConstants.PARAMS_MOBILE: mobile,
      HttpConstants.PARAMS_PASSWORD: password,
      HttpConstants.PARAMS_DEVICETOKEN: token,
    });

    postRequest(GeneralPath.API_LOGIN, params).then((response) {

      if (response.statusCode == 200) {
        if (IsCustomerApp) {
          LoginDataModel loginDataModel =
              LoginDataModelFromJson(response.body.toString());
          if (loginDataModel.meta.status == true) {
            userDataModel = loginDataModel.data;
            AppPreferences.setIsLogin(true);
            AppPreferences.setUserData(UserDataModelToJson(loginDataModel.data!));
            debugPrint("token  ${loginDataModel.token.toString()}");
            String token = loginDataModel.token.toString();
            AppPreferences.setUserToken(token);
            update();
            Get.offAllNamed(AllRoutes.baseUser);
          } else {
            showToastMessage(loginDataModel.meta.msg);
          }
          isLoaderVisible = !isLoaderVisible;
          isEnable = true;
          update();
        } else {
          LoginVendorModel loginDataModel =
              LoginVendorModelFromJson(response.body.toString());
          if (loginDataModel.meta.status) {
            vendorDataModel = loginDataModel.data;

            AppPreferences.setIsLogin(true);
            AppPreferences.setUserData(VendorDataModelToJson(loginDataModel.data!));
            String token = loginDataModel.token.toString();
            AppPreferences.setUserToken(token);
            update();
            Future.delayed(const Duration(milliseconds: 1000), () {
              Get.offAllNamed(AllRoutes.baseRestaurant);
            });
            // onClickLogin();
          } else {
            showToastMessage(loginDataModel.meta.msg);
          }
          // for the Loder Hide
          isLoaderVisible = !isLoaderVisible;
          isEnable = true;
          // for the update UI
          update();
        }
      } else {
        isEnable = true;
        isLoaderVisible = !isLoaderVisible;
        AppPreferences.setIsLogin(false);
        update();
        throw Exception('Failed to load data.');
      }
      update();
    });
  }

/*  callAdminLoginAPI({required String email, required String password,}) {
    isLoaderVisible = !isLoaderVisible;
    update();
    final params = jsonEncode({
      HttpConstants.PARAMS_EMAIL: email,
      HttpConstants.PARAMS_PASSWORD: password,
    });

    postRequest(GeneralPath.API_LOGIN, params).then((response) {

      if (response.statusCode == 200) {
        if (IsCustomerApp) {
          LoginDataModel loginDataModel =
          LoginDataModelFromJson(response.body.toString());
          if (loginDataModel.meta.status == true) {
            userDataModel = loginDataModel.data;
            AppPreferences.setIsLogin(true);
            AppPreferences.setUserData(UserDataModelToJson(loginDataModel.data!));
            debugPrint("token  ${loginDataModel.token.toString()}");
            String token = loginDataModel.token.toString();
            AppPreferences.setUserToken(token);
            update();
            Get.offAllNamed(AllRoutes.baseUser);
          } else {
            showToastMessage(loginDataModel.meta.msg);
          }
          isLoaderVisible = !isLoaderVisible;
          update();
        } else {
          LoginVendorModel loginDataModel =
          LoginVendorModelFromJson(response.body.toString());
          if (loginDataModel.meta.status) {
            vendorDataModel = loginDataModel.data;

            AppPreferences.setIsLogin(true);
            AppPreferences.setUserData(VendorDataModelToJson(loginDataModel.data!));
            String token = loginDataModel.token.toString();
            AppPreferences.setUserToken(token);
            update();
            Future.delayed(const Duration(milliseconds: 1000), () {
              Get.offAllNamed(AllRoutes.baseRestaurant);
            });
            // onClickLogin();
          } else {
            showToastMessage(loginDataModel.meta.msg);
          }
          // for the Loder Hide
          isLoaderVisible = !isLoaderVisible;
          // for the update UI
          update();
        }
      } else {
        isLoaderVisible = !isLoaderVisible;
        AppPreferences.setIsLogin(false);
        update();
        throw Exception('Failed to load data.');
      }
      update();
    });

  }*/


  callSocialLoginAPI({required String email, required String firstname, required String lastname,required String photo,required String authId,  }) {
    isLoaderVisible = !isLoaderVisible;
    update();
    final params = jsonEncode({
      HttpConstants.PARAMS_EMAIL: email,
      HttpConstants.PARAMS_FIRSTNAME: firstname,
      HttpConstants.PARAMS_LASTNAME: lastname,
      HttpConstants.PARAMS_PHOTOURL: photo,
      HttpConstants.PARAMS_AUTHID: authId,
      HttpConstants.PARAMS_LOGINTYPE: "google",
    });

    debugPrint('params: $params');

    postRequest(GeneralPath.API_SOCIAL_LOGIN, params).then((response) {

      if (response.statusCode == 200) {
        if (IsCustomerApp) {
          Map<String, dynamic> mResponse = jsonDecode(response.body);

          socialLoginModel = SocialLoginModel.fromJson(mResponse);

          if (socialLoginModel.meta?.status == true) {
            AppPreferences.setIsLogin(true);
            AppPreferences.setUserData(SocialDataModelToJson(socialLoginModel.data!));
            debugPrint("token  ${socialLoginModel.token.toString()}");
            String token = socialLoginModel.token.toString();
            AppPreferences.setUserToken(token);
            update();
            Get.offAllNamed(AllRoutes.baseUser);
          } else {
            showToastMessage(socialLoginModel.meta?.msg ?? "");
          }
          isLoaderVisible = !isLoaderVisible;
          update();
        }
      } else {
        isLoaderVisible = !isLoaderVisible;
        AppPreferences.setIsLogin(false);
        update();
        throw Exception('Failed to load data.');
      }
      update();
    });

  }

  Future<User?> currentUser() async {
    final GoogleSignInAccount? account = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? authentication =
    await account?.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: authentication?.idToken,
        accessToken: authentication?.accessToken);

    final UserCredential authResult =
    await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = authResult.user;
    debugPrint('Userdata number: ${user?.phoneNumber}');
    debugPrint('Userdata name: ${user?.displayName}');
    debugPrint('Userdata email: ${user?.email}');
    debugPrint('Userdata uid: ${user?.uid}');
    debugPrint('Userdata url: ${user?.photoURL}');
    debugPrint('Userdata token: ${user?.refreshToken}');
    debugPrint('Userdata : ${user?.toString()}');

    return user;
  }

  void navigateToLogin() {
    update();
    Get.offAllNamed(LoginView.routeName);
  }

  @override
  void dispose() {
    isLoaderVisible = false;
    super.dispose();
  }
}

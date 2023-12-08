import 'package:choosifoodi/model/login/user_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  /*
  * Login User
  * */
  static const PREF_ISLOGIN = "pref_isLogin";
  static const PREF_USERDATA = "pref_userData";

  static setIsLogin(bool isLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PREF_ISLOGIN, isLogin);
  }

  static Future<bool?> getIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(PREF_ISLOGIN);
  }

  static setUserData(String mapData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_USERDATA, mapData);
  }

  static Future<UserDataModel?> getUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userData = prefs.getString(PREF_USERDATA);
      if (userData != null) {
        return UserDataModelFromJson(userData);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static void clearPreferenceData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

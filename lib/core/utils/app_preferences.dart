import 'package:choosifoodi/model/login/user_data_model.dart';
import 'package:choosifoodi/model/login/vendorLogin/vendor_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppPreferences {
  /*
  * Login User
  * */
  static const PREF_ISLOGIN = "pref_isLogin";
  static const PREF_USERDATA = "pref_userData";
  static const PREF_LAT = "pref_lat";
  static const PREF_LONG = "pref_long";
  static const PREF_USERTOKEN = "pref_userToken";
  static const PREF_ADDRESSID = "pref_userAddressId";
  static const PREF_ADDRESS1 = "pref_userAddress1";
  static const PREF_ADDRESS2 = "pref_userAddress2";
  static const PREF_GROUPID = "pref_userGroupId";
  static const PREF_FIRE_TOKEN = "firetoken";
  static const PREF_LOCATION_LIST = "locationList";


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
  static setUserToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_USERTOKEN, token);
  }

  static Future<String?> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PREF_USERTOKEN);
  }
  static setLat(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_LAT, data);
  }

  static setLong(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.reload();
    await prefs.setString(PREF_LONG, data);
  }

  static Future<String?> getLat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.reload();
    return prefs.getString(PREF_LAT);
  }

  static setLocation(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_LOCATION_LIST, data);
  }

  static Future<String?> getLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PREF_LOCATION_LIST);
  }

  static setAddressId(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_ADDRESSID, data);
    print('AddressData In Prefs: $data');
  }

  static Future<String?> getAddressId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PREF_ADDRESSID);
  }

 static setGroupId(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_GROUPID, data);
  }

  static Future<String?> getGroupId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PREF_GROUPID);
  }

  static setAddress1(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_ADDRESS1, data);
  }

  static Future<String?> getAddress1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PREF_ADDRESS1);
  }

  static setAddress2(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_ADDRESS2, data);
  }

  static Future<String?> getAddress2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PREF_ADDRESS2);
  }

  static Future<String?> getLong() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PREF_LONG);
  }

  static Future<String?> getFireToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PREF_FIRE_TOKEN);
  }

  static setFireToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_FIRE_TOKEN, token);
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

  static Future<VendorDataModel?> getVendorData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userData = prefs.getString(PREF_USERDATA);
      if (userData != null) {
        return VendorDataModelFromJson(userData);
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

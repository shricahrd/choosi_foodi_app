import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import '../../routes/general_path.dart';
import '../utils/app_constants.dart';
import '../utils/app_preferences.dart';

Future<Response> getRequest(String apiURL) async {

  var url;
  String authKey = "";

  if (IsCustomerApp) {
    url = Uri.parse(GeneralPath.BASE_URI + apiURL);
    authKey = 'authKey';
  }else{
    url = Uri.parse(GeneralPath.BASE_URI_VENDOR + apiURL);
    authKey = 'AuthKey';
  }

  var token = "";
  await AppPreferences.getUserToken().then((userData) => {
    if (userData != null){
        token = userData
      }
  });

  debugPrint('Headers : $authKey ');
  debugPrint('Token : $token ');
  debugPrint('api : $url ');

  Response response = await get(url,headers: {"$authKey": "$token"});

  Map<String, dynamic> mResponse = jsonDecode(response.body);

  debugPrint("Response : $mResponse");
  debugPrint("response.statusCode : ${response.statusCode}");

  if(response.statusCode == 401 ||response.statusCode == 440 ){
     tokenExpire();
  }
  return response;
}

Future<Response> getUserRequest(String apiURL) async {

  var url;
  String authKey = "";

    url = Uri.parse(GeneralPath.BASE_URI + apiURL);
    authKey = 'authKey';

  var token = "";
  await AppPreferences.getUserToken().then((userData) => {
    if (userData != null){
      token = userData
    }
  });

  debugPrint('Headers : $authKey ');
  debugPrint('Token : $token ');
  debugPrint('api : $url ');

  Response response = await get(url,headers: {"$authKey": "$token"});

  Map<String, dynamic> mResponse = jsonDecode(response.body);

  debugPrint("Response : $mResponse");

  Map<String, dynamic> mResponse11 = json.decode(response.body);
  debugPrint("Response11 : $mResponse11");

  if(response.statusCode == 401 ||response.statusCode == 440 ){
    tokenExpire();
  }

  return response;
}

Future<Response> getRequestWithRequest(String apiURL, Map<String, dynamic> params) async {

  var url;
  String authKey = "";

  if (IsCustomerApp) {
    url = Uri.parse(GeneralPath.BASE_URI + apiURL);
    authKey = 'authKey';
  }else{
    url = Uri.parse(GeneralPath.BASE_URI_VENDOR + apiURL);
    authKey = 'AuthKey';
  }

  var token = "";
  await AppPreferences.getUserToken().then((userData) => {
    if (userData != null)
      {
        token = userData
      }
  });

  // debugPrint("API : ${url}");
  final finalUri = url.replace(queryParameters: params);

  debugPrint("Final API : $finalUri");

  Response response = await get(finalUri,headers: {"$authKey": "$token"});

  Map<String, dynamic> mResponse = jsonDecode(response.body);

  debugPrint("Response : $mResponse");
/*
  Map<String, dynamic> mResponse11 = json.decode(response.body);
  debugPrint("Response11 : $mResponse11");*/

  if(response.statusCode == 401 ||response.statusCode == 440 ){
    tokenExpire();
  }

  return response;
}

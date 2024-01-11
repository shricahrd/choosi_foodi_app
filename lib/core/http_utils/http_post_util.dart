import 'dart:convert';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../../routes/general_path.dart';
import '../utils/app_preferences.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';

import 'http_constants.dart';


Future<Response> postRequest(String apiURL, String jsonBody) async {
  var url;

  if (IsCustomerApp) {
    url = Uri.parse(GeneralPath.BASE_URI + apiURL);
  } else {
    url = Uri.parse(GeneralPath.BASE_URI_VENDOR + apiURL);
  }
  var token = "";
  await AppPreferences.getUserToken().then((userData) => {
        if (userData != null) {token = userData}
      });
  Map<String, String> headers = {
    "Content-type": "application/json",
    "authKey": "$token"
  };

  debugPrint("API : $url",);
  // debugPrint("headers : $headers",);

  debugPrint("Request : $jsonBody");

  Response response = await post(url, headers: headers, body: jsonBody);

  Map<String, dynamic> mResponse = jsonDecode(response.body);

  debugPrint("Response : $mResponse");
  debugPrint("statusCode : ${response.statusCode}");

  if(response.statusCode == 401 ||response.statusCode == 440 ){
    tokenExpire();
  }

  return response;
}

Future<Response> postRequestUrl(String apiURL,) async {
  var url;

  if (IsCustomerApp) {
    url = Uri.parse(GeneralPath.BASE_URI + apiURL);
  } else {
    url = Uri.parse(GeneralPath.BASE_URI_VENDOR + apiURL);
  }
  var token = "";
  await AppPreferences.getUserToken().then((userData) => {
    if (userData != null) {token = userData}
  });
  Map<String, String> headers = {
    "Content-type": "application/json",
    "authKey": "$token"
  };

  debugPrint("API : $url");


  Response response = await post(url, headers: headers,);

  Map<String, dynamic> mResponse = jsonDecode(response.body);

  debugPrint("Response : $mResponse");

  if(response.statusCode == 401 ||response.statusCode == 440 ){
    tokenExpire();
  }

  return response;
}

Future<Response> putRequestWithoutToken(String apiURL, String jsonBody) async {
  var url;

  if (IsCustomerApp) {
    url = Uri.parse(GeneralPath.BASE_URI + apiURL);
  } else {
    url = Uri.parse(GeneralPath.BASE_URI_VENDOR + apiURL);
  }

  Map<String, String> headers = {
    "Content-type": "application/json",
  };

  debugPrint("API : $url");
  debugPrint("Headers : $headers");

  debugPrint("Request : $jsonBody");

  Response response = await put(url, headers: headers, body: jsonBody);

  Map<String, dynamic> mResponse = jsonDecode(response.body);

  debugPrint("Response : $mResponse");
  if(response.statusCode == 401 ||response.statusCode == 440 ){
    tokenExpire();
  }
  return response;
}
Future<Response> putRequestUrlwithFormData(String apiURL,Map<String, String> map) async {
  var url;

  if (IsCustomerApp) {
    url = Uri.parse(GeneralPath.BASE_URI + apiURL);
  } else {
    url = Uri.parse(GeneralPath.BASE_URI_VENDOR + apiURL);
  }
  var token = "";
  await AppPreferences.getUserToken().then((userData) => {
    if (userData != null) {token = userData}
  });
  Map<String, String> headers = {
    "Content-type": "application/json",
    "authKey": "$token"
  };

  debugPrint("API : $url");

  // Response response = await put(url, headers: headers,body: map);
  // response

  var request = new http.MultipartRequest("PUT", url);
  request.fields.addAll(map);

  request.headers.addAll(headers);
  // send
  var response = await request.send();

  //Map<String, dynamic> mResponse = jsonDecode(response.body);
  var response1 = await http.Response.fromStream(response);
  debugPrint("Response : $response1");
  if(response1.statusCode == 401 ||response1.statusCode == 440 ){
    tokenExpire();
  }
  // var response1 = await http.Response.fromStream(response);
  return response1;
}
Future<Response> putRequestUrl(String apiURL) async {
  var url;

  if (IsCustomerApp) {
    url = Uri.parse(GeneralPath.BASE_URI + apiURL);
  } else {
    url = Uri.parse(GeneralPath.BASE_URI_VENDOR + apiURL);
  }
  var token = "";
  await AppPreferences.getUserToken().then((userData) => {
    if (userData != null) {token = userData}
  });
  Map<String, String> headers = {
    "Content-type": "application/json",
    "authKey": "$token"
  };

  debugPrint("API : $url");

  Response response = await put(url, headers: headers,);

  Map<String, dynamic> mResponse = jsonDecode(response.body);

  debugPrint("Response : $mResponse");
  if(response.statusCode == 401 ||response.statusCode == 440 ){
    tokenExpire();
  }
  return response;
}

Future<Response> putRequest(String apiURL, String jsonBody) async {
  var url;

  if (IsCustomerApp) {
    url = Uri.parse(GeneralPath.BASE_URI + apiURL);
  } else {
    url = Uri.parse(GeneralPath.BASE_URI_VENDOR + apiURL);
  }
  var token = "";
  await AppPreferences.getUserToken().then((userData) => {
    if (userData != null) {token = userData}
  });
  Map<String, String> headers = {
    "Content-type": "application/json",
    "authKey": "$token"
  };

  debugPrint("API : $url");

  debugPrint("Request : $jsonBody");

  Response response = await put(url, headers: headers, body: jsonBody);

  Map<String, dynamic> mResponse = jsonDecode(response.body);

  debugPrint("Response : $mResponse");
  if(response.statusCode == 401 ||response.statusCode == 440 ){
    tokenExpire();
  }
  return response;
}

Future<Response> postRequestApiWithOneImage(String apiURL, Map<String, String> jsonBody, File filePath, String imageKey, String methodType) async {
  var url;

  if (IsCustomerApp) {
    url = Uri.parse(GeneralPath.BASE_URI + apiURL);
  } else {
    url = Uri.parse(GeneralPath.BASE_URI_VENDOR + apiURL);
  }
  var token = "";
  await AppPreferences.getUserToken().then((userData) => {
    if (userData != null) {token = userData}
  });

  debugPrint('Token: $token');

  Map<String, String> headers = {
    "Content-type": "application/json",
    "authKey": "$token"
  };

  var stream = new http.ByteStream(DelegatingStream.typed(filePath.openRead()));
  // get file length
  var length = await filePath.length(); //imageFile is your image file
  // multipart that takes file
  var multipartFileSign = new http.MultipartFile(imageKey, stream, length,
      filename: basename(filePath.path));

  debugPrint('Url: $url');
  debugPrint('request: $jsonBody');
  var request = new http.MultipartRequest(methodType, url);
  request.fields.addAll(jsonBody);
  request.files.add(multipartFileSign);
  //add headers
  request.headers.addAll(headers);
  // send
  var response = await request.send();
  debugPrint(response.statusCode.toString());
  if(response.statusCode == 401 ||response.statusCode == 440 ){
    tokenExpire();
  }
  var response1 = await http.Response.fromStream(response);
  return response1;
}


Future<Response> postRequestWithOneImage(String apiURL, Map<String, String> jsonBody, File filePath, String imageKey) async {
  var url;

  if (IsCustomerApp) {
    url = Uri.parse(GeneralPath.BASE_URI + apiURL);
  } else {
    url = Uri.parse(GeneralPath.BASE_URI_VENDOR + apiURL);
  }
  var token = "";
  await AppPreferences.getUserToken().then((userData) => {
    if (userData != null) {token = userData}
  });

  debugPrint('Token: $token');

  Map<String, String> headers = {
    "Content-type": "application/json",
    "authKey": "$token"
  };

  var stream = new http.ByteStream(DelegatingStream.typed(filePath.openRead()));
  // get file length
  var length = await filePath.length(); //imageFile is your image file
  // multipart that takes file
  var multipartFileSign = new http.MultipartFile(imageKey, stream, length,
      filename: basename(filePath.path));

  debugPrint('Url: $url');
  debugPrint('request: $jsonBody');
  var request = new http.MultipartRequest("PUT", url);
  request.fields.addAll(jsonBody);
  request.files.add(multipartFileSign);
//add headers
  request.headers.addAll(headers);
  // send
  var response = await request.send();
  debugPrint(response.statusCode.toString());
  if(response.statusCode == 401 ||response.statusCode == 440 ){
    tokenExpire();
  }
  var response1 = await http.Response.fromStream(response);
  return response1;
}

Future<Response> postRequestWithMultipleDocument(String apiURL, Map<String, String> map, List<File> filePath, String imageKey, String methodType) async {
  var url;

  if (IsCustomerApp) {
    url = Uri.parse(GeneralPath.BASE_URI + apiURL);
  } else {
    url = Uri.parse(GeneralPath.BASE_URI_VENDOR + apiURL);
  }

  var token = "";
  await AppPreferences.getUserToken().then((userData) => {
    if (userData != null) {token = userData}
  });

  debugPrint('Token: $token');

  Map<String, String> headers = {
    "Content-type": "application/json",
    "authKey": "$token"
  };
  var request = new http.MultipartRequest(methodType, url);
  var multipartFileSign;
  debugPrint('Url: $url');
  debugPrint('request: $map');
  debugPrint('filePath: ${filePath.length}');
  for (var file in filePath) {
    String fileName = file.path.split("/").last;
    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));

    // get file length
    var length = await file.length(); //imageFile is your image file
    debugPrint('docLen: ${filePath.length}');
    debugPrint('fileName: $fileName');
    debugPrint('ImageKey2: $imageKey');

    // multipart that takes file
    multipartFileSign = new http.MultipartFile(imageKey, stream, length, filename: fileName);
    request.files.add(multipartFileSign);
  }

  request.fields.addAll(map);
//add headers
  request.headers.addAll(headers);
  // send
  var response = await request.send();
  debugPrint(response.statusCode.toString());
  if(response.statusCode == 401 ||response.statusCode == 440 ){
    tokenExpire();
  }
  var response1 = await http.Response.fromStream(response);
  return response1;
}

Future<Response> postRequestWithOneImageWithoutToken(String apiURL, Map<String, String> jsonBody, File filePath, String imageKey) async {
  debugPrint('WithoutToken');
  var url;

  if (IsCustomerApp) {
    url = Uri.parse(GeneralPath.BASE_URI + apiURL);
  } else {
    url = Uri.parse(GeneralPath.BASE_URI_VENDOR + apiURL);
  }

  Map<String, String> headers = {
    "Content-type": "application/json",
  };

  var stream = new http.ByteStream(DelegatingStream.typed(filePath.openRead()));
  // get file length
  var length = await filePath.length(); //imageFile is your image file
  // multipart that takes file
  var multipartFileSign = new http.MultipartFile(imageKey, stream, length,
      filename: basename(filePath.path));

  debugPrint('Url: $url');
  debugPrint('request: $jsonBody');
  var request = new http.MultipartRequest("POST", url);
  request.fields.addAll(jsonBody);
  request.files.add(multipartFileSign);
//add headers
  request.headers.addAll(headers);
  // send
  var response = await request.send();
  debugPrint(response.statusCode.toString());
  if(response.statusCode == 401 ||response.statusCode == 440 ){
    tokenExpire();
  }
  var response1 = await http.Response.fromStream(response);
  return response1;
}


Future<Response> postRequestWithMultipleImage({
      required String apiURL, required Map<String, String> jsonBody, required File imagePath1,required File filePath2,required String imageKey, required String imageKey2,}) async {
  var url;

  if (IsCustomerApp) {
    url = Uri.parse(GeneralPath.BASE_URI + apiURL);
  } else {
    url = Uri.parse(GeneralPath.BASE_URI_VENDOR + apiURL);
  }
  var token = "";
  await AppPreferences.getUserToken().then((userData) => {
    if (userData != null) {token = userData}
  });

  debugPrint('Token: $token');

  debugPrint('url: $url');

  Map<String, String> headers = {
    "Content-type": "application/json",
    "authKey": "$token"
  };

  var stream1 = new http.ByteStream(DelegatingStream.typed(imagePath1.openRead()));
  // get file length
  var length1 = await imagePath1.length(); //imageFile is your image file
  // multipart that takes file
  var multipartFileSign1 = new http.MultipartFile(imageKey, stream1, length1,
      filename: basename(imagePath1.path.split('/')
          .last));

  var stream2 = new http.ByteStream(DelegatingStream.typed(filePath2.openRead()));
  // get file length
  var length2 = await filePath2.length(); //imageFile is your image file
  // multipart that takes file
  var multipartFileSign2 = new http.MultipartFile(imageKey2, stream2, length2,
      filename: basename(filePath2.path.split('/')
          .last));

  debugPrint('Url: $url');
  debugPrint('request: $jsonBody');
  var request = new http.MultipartRequest("PUT", url);
  request.fields.addAll(jsonBody);
  request.files.add(multipartFileSign1);
  request.files.add(multipartFileSign2);
//add headers
  request.headers.addAll(headers);
  // send
  var response = await request.send();
  debugPrint(response.statusCode.toString());
  if(response.statusCode == 401 ||response.statusCode == 440 ){
    tokenExpire();
  }
  var response1 = await http.Response.fromStream(response);
  return response1;
}

Future<Response> postRequestWithMultipleRestImage(String apiURL, Map<String, String> map, List<File> filePath, String imageKey) async {
  debugPrint('WithoutToken');
  var url;

  if (IsCustomerApp) {
    url = Uri.parse(GeneralPath.BASE_URI + apiURL);
  } else {
    url = Uri.parse(GeneralPath.BASE_URI_VENDOR + apiURL);
  }

  Map<String, String> headers = {
    "Content-type": "application/json",
  };
  var request = new http.MultipartRequest("POST", url);
  var multipartFileSign;
  debugPrint('Url: $url');
  debugPrint('request: $map');
  for (var file in filePath) {
    String fileName = file.path.split("/").last;
    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));

    // get file length
    var length = await file.length(); //imageFile is your image file
    debugPrint('docLen: ${filePath.length}');
    debugPrint('fileName: $fileName');
    debugPrint('ImageKey2: $imageKey');

    // multipart that takes file
    multipartFileSign = new http.MultipartFile(imageKey, stream, length, filename: fileName);
    request.files.add(multipartFileSign);
  }

  request.fields.addAll(map);
//add headers
  request.headers.addAll(headers);
  // send
  var response = await request.send();
  debugPrint(response.statusCode.toString());
  if(response.statusCode == 401 ||response.statusCode == 440 ){
    tokenExpire();
  }
  var response1 = await http.Response.fromStream(response);
  return response1;
}


Future<Response> postRequestWithMultipleDocuments({
  required String apiURL, required final email,required final name,required final password,required final mobile, required File imagePath1,required List<File> filePath2,required String imageKey, required String imageKey2,}) async {
  var url;

  if (IsCustomerApp) {
    url = Uri.parse(GeneralPath.BASE_URI + apiURL);
  } else {
    url = Uri.parse(GeneralPath.BASE_URI_VENDOR + apiURL);
  }

  debugPrint('url: $url');

  Map<String, String> headers = {
    "Content-type": "application/json",
  };

  var stream1 = new http.ByteStream(DelegatingStream.typed(imagePath1.openRead()));
  // get file length
  var length1 = await imagePath1.length(); //imageFile is your image file
  // multipart that takes file
  var multipartFileSign1 = new http.MultipartFile(imageKey, stream1, length1,
      filename: basename(imagePath1.path.split('/')
          .last));

  var multipartFileSign2;
  var request = new http.MultipartRequest("PUT", url);
  request.files.add(multipartFileSign1);
  for (var file in filePath2) {
    String fileName = file.path.split("/").last;
    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));

    // get file length
    var length = await file.length(); //imageFile is your image file
    debugPrint('docLen: ${filePath2.length}');
    debugPrint('fileName: $fileName');
    debugPrint('ImageKey2: $imageKey2');

    // multipart that takes file
     multipartFileSign2 = new http.MultipartFile(imageKey2, stream, length, filename: fileName);
    request.files.add(multipartFileSign2);
  }

  debugPrint('Url: $url');

  request.fields[HttpConstants.PARAMS_EMAIL] = email;
  request.fields[HttpConstants.PARAMS_VENDORNAME] = name;
  request.fields[HttpConstants.PARAMS_PASSWORD] = password;
  request.fields[HttpConstants.PARAMS_MOBILE] = mobile;

  debugPrint('email: ${request.fields[HttpConstants.PARAMS_EMAIL]}');

  debugPrint("request:  ${request.fields}");
//add headers
  request.headers.addAll(headers);
  // send
  var response = await request.send();
  debugPrint(response.statusCode.toString());
  var response1 = await http.Response.fromStream(response);
  return response1;
}


Future<Response> postRequestWithMultipleDoc({
  required String apiURL, required Map<String, String> jsonBody, required File imagePath1,required List<File> filePath2,required String imageKey, required String imageKey2,}) async {
  var url;

  if (IsCustomerApp) {
    url = Uri.parse(GeneralPath.BASE_URI + apiURL);
  } else {
    url = Uri.parse(GeneralPath.BASE_URI_VENDOR + apiURL);
  }
  var token = "";
  await AppPreferences.getUserToken().then((userData) => {
    if (userData != null) {token = userData}
  });

  debugPrint('Token: $token');

  debugPrint('url: $url');

  debugPrint('Url: $url');
  debugPrint('request: $jsonBody');
  var request = new http.MultipartRequest("PUT", url);

  Map<String, String> headers = {
    "Content-type": "application/json",
    "authKey": "$token"
  };

  var stream1 = new http.ByteStream(DelegatingStream.typed(imagePath1.openRead()));
  // get file length
  var length1 = await imagePath1.length(); //imageFile is your image file
  // multipart that takes file
  var multipartFileSign1 = new http.MultipartFile(imageKey, stream1, length1,
      filename: basename(imagePath1.path.split('/')
          .last));

  for(int i=0; i<filePath2.length; i++) {
    var stream2 = new http.ByteStream(
        DelegatingStream.typed(filePath2[i].openRead()));
    // get file length
    var length2 = await filePath2[i].length(); //imageFile is your image file
    // multipart that takes file
    var multipartFileSign2 = new http.MultipartFile(imageKey2, stream2, length2,
        filename: basename(filePath2[i].path
            .split('/')
            .last));
    request.files.add(multipartFileSign2);
  }


  request.fields.addAll(jsonBody);
  request.files.add(multipartFileSign1);
//add headers
  request.headers.addAll(headers);
  // send
  var response = await request.send();
  debugPrint(response.statusCode.toString());
  if(response.statusCode == 401 ||response.statusCode == 440 ){
    tokenExpire();
  }
  var response1 = await http.Response.fromStream(response);
  return response1;
}

Future<Response> postRequestWithMultiDoc(String apiURL, List<File> filePath, String imageKey) async {
  var url;

  if (IsCustomerApp) {
    url = Uri.parse(GeneralPath.BASE_URI + apiURL);
  } else {
    url = Uri.parse(GeneralPath.BASE_URI_VENDOR + apiURL);
  }
  var token = "";
  await AppPreferences.getUserToken().then((userData) => {
    if (userData != null) {token = userData}
  });

  debugPrint('Token: $token');

  Map<String, String> headers = {
    "Content-type": "application/json",
    "authKey": "$token"
  };
  debugPrint('Url: $url');
  var multipartFileSign;
  var request = new http.MultipartRequest("PUT", url);

  for(int i=0; i<filePath.length; i++) {
    var stream2 = new http.ByteStream(
        DelegatingStream.typed(filePath[i].openRead()));
    // get file length
    var length2 = await filePath[i].length(); //imageFile is your image file
    // multipart that takes file
    multipartFileSign = new http.MultipartFile(imageKey, stream2, length2,
        filename: basename(filePath[i].path
            .split('/')
            .last));
    request.files.add(multipartFileSign);
  }
  // request.files.add(multipartFileSign1);
//add headers
  request.headers.addAll(headers);
  // send
  var response = await request.send();
  debugPrint(response.statusCode.toString());
  if(response.statusCode == 401 ||response.statusCode == 440 ){
    tokenExpire();
  }
  var response1 = await http.Response.fromStream(response);
  debugPrint('response1: $response1');
  return response1;
}

Future<Response> postRequestWithPic(String apiURL, File filePath, String imageKey) async {
  var url;

  if (IsCustomerApp) {
    url = Uri.parse(GeneralPath.BASE_URI + apiURL);
  } else {
    url = Uri.parse(GeneralPath.BASE_URI_VENDOR + apiURL);
  }
  var token = "";
  await AppPreferences.getUserToken().then((userData) => {
    if (userData != null) {token = userData}
  });

  debugPrint('Token: $token');

  Map<String, String> headers = {
    "Content-type": "application/json",
    "authKey": "$token"
  };

  var stream = new http.ByteStream(DelegatingStream.typed(filePath.openRead()));
  // get file length
  var length = await filePath.length(); //imageFile is your image file
  // multipart that takes file
  var multipartFileSign = new http.MultipartFile(imageKey, stream, length,
      filename: basename(filePath.path));

  debugPrint('Url: $url');
  var request = new http.MultipartRequest("PUT", url);
  request.files.add(multipartFileSign);

  request.headers.addAll(headers);
  // send
  var response = await request.send();
  debugPrint(response.statusCode.toString());
  if(response.statusCode == 401 ||response.statusCode == 440 ){
    tokenExpire();
  }
  var response1 = await http.Response.fromStream(response);
  debugPrint('response1: $response1');
  return response1;
}

Future<Response> deleteRequest(String apiURL) async {
  var url;
  String authKey = "";

  if (IsCustomerApp) {
    url = Uri.parse(GeneralPath.BASE_URI + apiURL);
    authKey = 'authKey';
  } else {
    url = Uri.parse(GeneralPath.BASE_URI_VENDOR + apiURL);
    authKey = 'AuthKey';
  }
  var token = "";
  await AppPreferences.getUserToken().then((userData) => {
    if (userData != null) {token = userData}
  });
  Map<String, String> headers = {
    "Content-type": "application/json",
    "$authKey": "$token"
  };

  debugPrint("API : ${url}");

  Response response = await delete(url, headers: headers,);

  Map<String, dynamic> mResponse = jsonDecode(response.body);

  debugPrint("Response : $mResponse");

  if(response.statusCode == 401 ||response.statusCode == 440 ){
    tokenExpire();
  }

  return response;
}
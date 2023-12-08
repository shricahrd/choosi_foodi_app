import 'dart:convert';

import 'package:choosifoodi/core/http_utils/http_constants.dart';
import 'package:http/http.dart';

Future<Response> postRequest(String apiURL, String jsonBody) async {
  var url = Uri.parse(HttpConstants.BASE_URI + apiURL);

  Map<String, String> headers = {"Content-type": "application/json"};

  print("API : ${url}");

  print("Request : $jsonBody");

  Response response = await post(url, headers: headers, body: jsonBody);

  Map<String, dynamic> mResponse = jsonDecode(response.body);

  print("Response : $mResponse");

  return response;
}

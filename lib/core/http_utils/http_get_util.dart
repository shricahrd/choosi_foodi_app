import 'dart:convert';

import 'package:choosifoodi/core/http_utils/http_constants.dart';
import 'package:http/http.dart';

Future<Response> getRequest(String apiURL) async {
  var url = Uri.parse(HttpConstants.BASE_URI + apiURL);

  print("API : ${url}");

  Response response = await get(url);

  Map<String, dynamic> mResponse = jsonDecode(response.body);

  print("Response : $mResponse");

  Map<String, dynamic> mResponse11 = json.decode(response.body);
  print("Response11 : $mResponse11");

  return response;
}

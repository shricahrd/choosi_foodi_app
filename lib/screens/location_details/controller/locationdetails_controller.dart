import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import '../../../core/http_utils/http_constants.dart';
import '../../../core/http_utils/http_post_util.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_preferences.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../routes/all_routes.dart';
import '../../../routes/general_path.dart';
import '../../cart/model/delete_cart_model.dart';
import '../model/get_custom_location_model.dart';

class LocationDetailsController extends GetxController {
  bool isAddressPosted = true;
  String address = "";
  TextEditingController searchController = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '123456';
  List<dynamic> placesList = [];
  List<Placemark> placemarks = [];
  DeleteCartModel deleteCartModel = DeleteCartModel();
  dynamic cityName, stateName, countryName, addressLine1, locality, postalCode, latitude, longitude;
  bool isEnable = true;
  int addId = 0;

  onChangePlace(){
    if(_sessionToken == ""){
        _sessionToken = uuid.v4();
        update();
    }

    getSuggesion(searchController.text);
  }

  void getSuggesion(String input) async{

    String request = '$baseURLGoogleSearch?input=$input&key=$kGoogleApiKey&sessiontoken=$_sessionToken';
    debugPrint('request: $request');
    var response = await http.get(Uri.parse(request));

    debugPrint('Response: ${response.body.toString()}');
    if(response.statusCode == 200){
        placesList = jsonDecode(response.body.toString()) ['predictions'];
        update();
    }else{
      throw Exception('Failed to load data');
    }
  }

   Future<void> addToSPLocation(List<GetCustomLocationModel> getCustomModelList) async {
    AppPreferences.setLocation(jsonEncode(getCustomModelList));
    debugPrint('getSpList ====> : ${jsonEncode(getCustomModelList.map((data) => data.toMap()).toList())}');
    debugPrint('Total SpLen: ${getCustomModelList.length}');
  }

  Future<void> getAddressFromLatLongDirect({required double lat, required double long, required String mobile, String? name}) async {
    latitude = lat;
    longitude = long;
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark place = placemarks[0];
    addressLine1 = place.street;
    locality = place.subLocality;
    cityName = place.subAdministrativeArea;
    stateName = place.administrativeArea;
    countryName = place.country;
    postalCode = place.postalCode;
    debugPrint('Search Address from latlong ==> Street:  $addressLine1 ,Locality:  $locality, cityName: $cityName, PostalCode: $postalCode,StateName: $stateName,'
        ' Country: $countryName');

    isAddressPosted = !isAddressPosted;
    update();

    final params = jsonEncode({
      HttpConstants.PARAMS_NAME: name,
      HttpConstants.PARAMS_ADDRESSLINE: addressLine1,
      HttpConstants.PARAMS_ADDRESSTYPE: 'OTHER',
      HttpConstants.PARAMS_CITYNAME: cityName,
      HttpConstants.PARAMS_COUNTRYNAME: countryName,
      HttpConstants.PARAMS_LANDMARK: locality,
      HttpConstants.PARAMS_MOBILE: mobile,
      HttpConstants.PARAMS_PINCODE: postalCode,
      HttpConstants.PARAMS_STATENAME: stateName,
      HttpConstants.PARAMS_CORDINATES: [lat, long],
      HttpConstants.PARAMS_ISDEFAULT: true,
    });

    await putRequestWithoutToken(GeneralPath.API_ADD_ADDRESS, params).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        deleteCartModel = DeleteCartModel.fromJson(mResponse);
        if (deleteCartModel.meta?.status == true) {
          debugPrint(deleteCartModel.meta?.msg.toString());
        }else{
          debugPrint(deleteCartModel.meta?.msg.toString());
          showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
        }
      } else {
        showToastMessage(deleteCartModel.meta!.msg!);
      }
      isAddressPosted = true;
      return isAddressPosted;
    });
  }
}
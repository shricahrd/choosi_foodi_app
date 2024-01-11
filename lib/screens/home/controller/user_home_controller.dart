import 'dart:async';
import 'dart:convert';
import 'package:choosifoodi/core/http_utils/http_constants.dart';
import 'package:choosifoodi/core/utils/app_preferences.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import '../../../core/http_utils/http_get_util.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../cart/model/get_cart_model.dart';
import '../../location_details/controller/locationdetails_controller.dart';
import '../../location_details/model/get_custom_location_model.dart';
import '../../order_checkout/controller/order_checkout_controller.dart';
import '../../profile/Controller/profile_controller.dart';
import '../model/get_user_home_model.dart.dart';

class UserHomeController extends GetxController {
  bool isLoaderVisible = false;
  bool isCartVisible = false;
  GetUserHomeModel userHomeModel = GetUserHomeModel();
  GetCartModel getMenuCartModel = GetCartModel();
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  late StreamSubscription<Position> positionStream;
  String address = "", restaurantName = "", price = "",  address1 = "", address2 = "", long = "", lat = "";
  int itemCount = 0;
  int bannerLen = 0;
  List bannerImageList = [];
  List<GetCustomLocationModel> getCustomAddressList = [];
  final LocationDetailsController locationDetailsController =
  Get.put(LocationDetailsController());
  final UserProfileGetController _profileController = Get.put(UserProfileGetController());
  final OrderCheckoutController orderCheckoutController = Get.put(OrderCheckoutController());
  @override
  void onInit() {
    isLoaderVisible = false;
    super.onInit();
  }

  // get permission for location
  checkGps() async {
    debugPrint('Inside gps');
    LocationPermission permission;
    servicestatus = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    debugPrint('service status: $servicestatus');
    debugPrint('permission status: $permission');

    if (servicestatus) {
      debugPrint('service status ===> $servicestatus');
      if (permission == LocationPermission.denied) {
        debugPrint('permission denied');
        permission = await Geolocator.requestPermission();
        permission = await Geolocator.checkPermission();
        debugPrint('permission check: $permission');
        if (permission == LocationPermission.denied) {
          debugPrint('Location permissions are denied');
          haspermission = false;
        } else if (permission == LocationPermission.deniedForever) {
          debugPrint("Location permissions are permanently denied");
          haspermission = false;
        } else if (permission == LocationPermission.whileInUse) {
          haspermission = true;
        } else if (permission == LocationPermission.always) {
          haspermission = true;
        }
      }

      if (permission == LocationPermission.whileInUse) {
        haspermission = true;
      } else if (permission == LocationPermission.always) {
        haspermission = true;
      }

      if (haspermission == true) {
        update();
        getLocation();
      } else {
        update();
      }
    } else {
      if (permission == LocationPermission.denied) {
        showToastMessage('Please Allow Location Permission');
        permission = await Geolocator.requestPermission();
        debugPrint("GPS Service is not enabled, turn on GPS location");
      }
      update();
      return haspermission;
    }
  }

  getLocation() async {
    if(haspermission == true) {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      debugPrint(position.longitude.toString()); //Output: 23.0272782
      debugPrint(position.latitude.toString()); //Output: 72.5247305

      long = position.longitude.toString();
      lat = position.latitude.toString();
      latString = lat;
      longString = long;
      debugPrint('Set Lat: $lat');
      debugPrint('Set Long: $long');
      AppPreferences.setLat(lat);
      AppPreferences.setLong(long);
      getAddressFromLatLong(position);
      callHomeAPI(lat: lat, long: long, isDelivery: 0);
      update();
    }else{
      checkGps();
    }
  }

  callProfile(var lat, var long) async {
    await _profileController.getUserProfile();
    String mobile = _profileController.mobileNumber;
    String name = _profileController.fName + " " + _profileController.lName;
    debugPrint('mobile: $mobile, name: $name');
    await orderCheckoutController.callGetAddressAPI();
    debugPrint('addresslist api===> ${orderCheckoutController.getAddressModel.data?.length}');
    if(orderCheckoutController.getAddressModel.meta?.status == false){
      await locationDetailsController
          .getAddressFromLatLongDirect(
          lat: double.parse(lat),
          long: double.parse(long),
          mobile: mobile
              .toString(),
          name: name);
      orderCheckoutController.callGetAddressAPI();
    }
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    // debugPrint('place: $place');
    address = '${place.street}, ${place.subLocality}';
    // debugPrint('Full Address ==> Street:  ${place.street},SubLocality:  ${place.subLocality}, Locality: ${place.subAdministrativeArea}, PostalCode: ${place.postalCode},StateName: ${place.administrativeArea}, Country: ${place.country}');
    // debugPrint('Address: $address');
    address1 = place.street.toString();
    address2 = place.subLocality.toString() + ", " +  place.locality.toString();
    AppPreferences.setAddress1(address1);
    AppPreferences.setAddress2(address2);

    // debugPrint('Address1 : ${AppPreferences.getAddress1()}, Address3: ${AppPreferences.getAddress2()}');
    // debugPrint('Prefs getCustomAddressList');
    final prefs = await AppPreferences.getLocation();
    // Fetch and decode data
    final data1 = json.decode(prefs.toString());
    if(data1 != null) {
      final item = List<GetCustomLocationModel>.from(
          data1.map((i) => GetCustomLocationModel.fromJson(i)));
      getCustomAddressList = item;
      if (getCustomAddressList.length != 0) {
        debugPrint('GetCartModel list Len: ${getCustomAddressList.length}');
      }
    }else{
      getCustomAddressList.add(GetCustomLocationModel(address1: address1,address2: address2, lat: lat, long: long));
      locationDetailsController.addToSPLocation(getCustomAddressList);
      debugPrint('Added');
    }

    if(getCustomAddressList.length > 2){
      getCustomAddressList.removeLast();
    }else {
      debugPrint('Else getCustomAddressList');
      for(int i=0; i<getCustomAddressList.length; i++){
        if(address1 != getCustomAddressList[i].address1){
          // debugPrint('Not same');
          getCustomAddressList.add(GetCustomLocationModel(address1: address1,address2: address2, lat: lat, long: long));
          locationDetailsController.addToSPLocation(getCustomAddressList);
          // debugPrint('Added');
        }else{
          // debugPrint('same address');
        }
      }
    }
    update();
  }

  Future<void> getAddressFromLatLongDirect({required double lat, required double long}) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        address = '${place.street}, ${place.subLocality}';
        debugPrint('Search Address: $address');
        AppPreferences.setAddress1(place.street.toString());
        AppPreferences.setAddress2(place.subLocality.toString());
        update();
      } else {
        // Handle the case when no address information is found
        debugPrint('No address information found for the given coordinates.');
      }
    } catch (e) {
      // Handle other exceptions that may occur during the geocoding process
      debugPrint('Error during geocoding: $e');
    }
  }

  callHomeAPI({required String lat,required String long, required dynamic isDelivery}) {
    bool delivery = true;
    if(isDelivery == 0){
      delivery = true;
      update();
    }else{
      delivery = false;
      update();
    }

    Map<String, String> queryParams = {
      HttpConstants.PARAMS_LAT: lat,
      HttpConstants.PARAMS_LONG: long,
      HttpConstants.PARAMS_IS_DELIVERY: delivery.toString(),
    };

    debugPrint("QueryParams: $queryParams");

    getRequestWithRequest(GeneralPath.API_HOME, queryParams).then((response) {
      if (response.statusCode == 200) {
        bannerImageList.clear();
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        userHomeModel = GetUserHomeModel.fromJson(mResponse);
        if (userHomeModel.meta?.status == true) {
          debugPrint('status true: ${userHomeModel.meta?.status}');
          if(userHomeModel.data?.banner?.isNotEmpty == true){
          for(int index=0; index < (userHomeModel.data?.banner?.length ?? 0); index++) {
            if (userHomeModel.data?.banner?[index].bannerImg.isNotEmpty == true || userHomeModel.data?.banner != null) {
              // debugPrint('index: $index');
              if (userHomeModel.data?.banner?[index].bannerFor == 'MOBILE') {
                // debugPrint('index mobile : $index');
                bannerImageList.add(
                    userHomeModel.data?.banner?[index].bannerImg.toString());
                // debugPrint('bannerImage: ${bannerImageList[index]}');

              } else {
                //debugPrint('bannerLen else desktop: ${userHomeModel.data?.banner?[index].bannerImg}');
              }
            } else {
              debugPrint('bannerLen null');
            }
          }
          }

          isLoaderVisible = true;
          update();
        }
      } else {
        showToastMessage(userHomeModel.meta?.msg.toString() ?? "");
        isLoaderVisible = false;
        throw Exception('Failed to load data.');
      }
      update();
    });
  }


  Future<void> callGetCartAPI() async {
    await getRequest(GeneralPath.API_GET_CART).then((response) {

      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);

        getMenuCartModel = GetCartModel.fromJson(mResponse);
        if (getMenuCartModel.meta?.status == true) {
          debugPrint('status true: ${getMenuCartModel.meta?.status}');
          debugPrint('Response Data: ${getMenuCartModel.data}');
          itemCount = getMenuCartModel.data!.cartMenu!.length;
          update();
          debugPrint('Total CartLen: $itemCount');
          isCartVisible = true;
          update();
        }else{
          // showToastMessage(getMenuCartModel.meta!.msg.toString());
          itemCount = 0;
          isCartVisible = false;
          update();
        }
      } else {
        // showToastMessage(getMenuCartModel.meta!.msg.toString());
        isCartVisible = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return getMenuCartModel;
    });
  }

  @override
  void dispose() {
    isLoaderVisible = false;
    super.dispose();
  }
}
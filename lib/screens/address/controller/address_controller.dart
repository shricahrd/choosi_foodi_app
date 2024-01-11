import 'dart:convert';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../core/http_utils/http_constants.dart';
import '../../../core/http_utils/http_get_util.dart';
import '../../../core/http_utils/http_post_util.dart';
import '../../../core/utils/app_preferences.dart';
import '../../cart/model/delete_cart_model.dart';
import '../../home/controller/user_home_controller.dart';
import '../model/custom_state_model.dart';
import '../model/get_address_model.dart';
import '../model/get_city_model.dart';
import '../model/get_country_model.dart';
import '../model/get_state_model.dart';

class AddressController extends GetxController {
  bool isLoaderVisible = true;
  bool isStateVisible = false;
  bool isCountryVisible = false;
  bool isCityVisible = false;
  bool isAddressPosted = false;
  bool isAddressDeleted = false;
  bool isAddressChanged = true;
  bool isAddressUpdate = false;
  String emptyAddress = "";
  GetAddressModel getAddressModel = GetAddressModel();
  GetStateModel getStateModel = GetStateModel();
  GetCountryModel getCountryModel = GetCountryModel();
  GetCityModel getCityModel = GetCityModel();
  DeleteCartModel deleteCartModel = DeleteCartModel();
  List<GetCustomStateModel> getCustomStateList = [];
  List<GetCustomCityModel> getCustomCityList = [];
  List<GetCustomCountryModel> getCustomCountryList = [];
  String selectStateName = "Select";
  String selectCityName = "Select";
  bool isCityAvail = false;
  bool isStateAvail = false;
  final UserHomeController userHomeController = Get.put(UserHomeController());
  // bool isCountryAvail = false;
  dynamic cityName;
  // var countryId = "6177e615bd56d215f06c6bac", stateId, cityId;
  // List stateList = [];
  Map<String, dynamic>? paymentIntentData;

  @override
  void onInit() {
    isLoaderVisible = true;
    super.onInit();
  }

  @override
  void dispose() {
    isAddressUpdate = false;
    super.dispose();
  }

  selectDefaultAddress() {
    print('Inside selectDefaultAddress');
    for (int i = 0; i < getAddressModel.data!.length; i++) {
      if (getAddressModel.data?[i].isDefault == false) {
        print('====> ${getAddressModel.data?[i].isDefault}');
        print('No default address found');
        print('AddressId: ${getAddressModel.data![i].addressId}');
        callDefaultAddressAPI(
            addressId: getAddressModel.data![i].addressId.toString());
      } else {
        print('====> ${getAddressModel.data?[i].isDefault}');
        print('default address found');
        print('AddressId: ${getAddressModel.data![i].addressId}');
      }
    }
  }

  Future<void> callGetAddressAPI() async {
    await getRequest(GeneralPath.API_GET_ADDRESS).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        getAddressModel = GetAddressModel.fromJson(mResponse);
        print('Response getAddressModel: ${getAddressModel.toJson()}');
        if (getAddressModel.meta?.status == true) {
          print('status true: ${getAddressModel.meta?.status}');
          print('Response Data: ${getAddressModel.data}');
          update();
        } else {
          // showToastMessage(getAddressModel.meta!.msg.toString());
          if (getAddressModel.data?.length == 0) {
            print('emptyAddress CTL: $emptyAddress');
            AppPreferences.setAddressId(emptyAddress);
            update();
          }
          // checkAddressData();
        }
      } else {
        // checkAddressData();
        showToastMessage(getAddressModel.meta?.msg.toString() ?? "");
        // isLoaderVisible = true;
        // update();
        throw Exception('Failed to load data.');
      }
      isLoaderVisible = false;
      update();
      return getAddressModel;
    });
  }

  Future<void> callDefaultAddressAPI({required String addressId}) async {
    await putRequestUrl(GeneralPath.API_DEFAULT_ADDRESS + addressId).then((
        response) {
      if (response.statusCode == 200) {
        print('Response Data: ${response.body}');
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        deleteCartModel = DeleteCartModel.fromJson(mResponse);
        if (deleteCartModel.meta?.status == true) {
          print('status : ${deleteCartModel.meta?.status}');
          showToastMessage(deleteCartModel.meta!.msg.toString());
          isAddressChanged = false;
          update();
          callGetAddressAPI();
          update();
        } else {
          showToastMessage(deleteCartModel.meta!.msg.toString());
          isAddressChanged = false;
          update();
        }
      } else {
        showToastMessage(deleteCartModel.meta!.msg.toString());
        isAddressChanged = true;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return deleteCartModel;
    });
  }

  Future<void> deleteAddressAPI({required String addressId}) async {
    isAddressDeleted = true;
    update();
    await deleteRequest(GeneralPath.API_DELETE_ADDRESS + addressId,).then((
        response) {
      if (response.statusCode == 200) {
        print('Response Data: ${response.body}');
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        deleteCartModel = DeleteCartModel.fromJson(mResponse);
        if (deleteCartModel.meta?.status == true) {
          // showToastMessage(deleteCartModel.meta!.msg.toString());
          isAddressDeleted = false;
          update();
          if (deleteCartModel.meta?.status == true) {
            for (int i = 0; i < getAddressModel.data!.length; i++) {
              if (getAddressModel.data?[i].isDefault == false) {
                print('Default address Deleted');
                print('emptyAddress : $emptyAddress');
                AppPreferences.setAddressId(emptyAddress);
                update();
              }
            }
          }
          callGetAddressAPI();
          // selectDefaultAddress();
        } else {
          showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
          isAddressDeleted = false;
          update();
        }
      } else {
        showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
        isAddressDeleted = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return deleteCartModel;
    });
  }

  checkAddressData() async {
    isLoaderVisible = true;
    update();
    debugPrint("checkAddressData =======>");
    var lat = await AppPreferences.getLat();
    var long = await AppPreferences.getLong();
    if (lat != null && long != null) {
        isLoaderVisible = true;
        update();
        await userHomeController.callProfile(lat, long);
        isLoaderVisible = true;
        update();
        callGetAddressAPI();
      }
  }


/*  getEditStateData(int index, String stateName, co) async {
     cityName = getAddressModel.data?[index].cityName;

    await callGetStateListAPI(countryId: countryId);
    if(getStateModel.meta?.status == true){
      print('Updated State');
      if (isStateVisible == true) {
        for (int i = 0; i < (getCustomStateList.length); i++) {
          print('state Len: ${getCustomStateList.length}');
          if (getAddressModel.data![index].stateName == getCustomStateList[i].stateName) {
            print('State match');
            selectStateName = getAddressModel.data![index].stateName.toString();
            print('selectStateName: $selectStateName');
            stateId = getAddressModel.data![index].stateId.toString();
            selectCityName = getAddressModel.data![index].cityName.toString();
            print('_selectCityName: $selectCityName');
            isStateAvail = true;
            update();
            // _cityId = getAddressModel.data![index].cityId.toString();
            // isStateNotMatch = true;
            // stateMatch = true;
          }else{
            selectStateName = getCustomStateList[0].stateName.toString();
            selectCityName = getCustomCityList[0].cityName.toString();
            // isStateAvail = true;
            update();
          }
        }
      }

      if(isStateAvail == true){
        await callGetCityListAPI(
            countryId: countryId, stateId: stateId);
      }
    }

  }*/



  Future<void> callCountryListAPI() async {

    await getRequest(GeneralPath.API_COUNTRY_LIST).then((
        response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);

        getCountryModel = GetCountryModel.fromJson(mResponse);

        if (getCountryModel.meta?.status == true) {
          print('status true: ${getCountryModel.meta?.status}');
          print('Response Data: ${getCountryModel.data}');
          print('data size: ${getCountryModel.data?.length}');
          for (int i = 0; i < (getCountryModel.data?.length ?? 0); i++) {
            getCustomCountryList.add(GetCustomCountryModel(
                countryId: getCountryModel.data?[i].countryId,
                countryName: getCountryModel.data?[i].countryName));
          }
          debugPrint('getCustomCountryList len: ${getCustomCountryList.length}');
          isCountryVisible = true;
          update();
        } else {
          showToastMessage(getCountryModel.meta?.msg ?? "");
          isCountryVisible = false;
          update();
        }
      } else {
        showToastMessage(getStateModel.meta?.msg ?? "");
        isCountryVisible = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return getCountryModel;
    });
  }

  Future<void> callGetStateListAPI({required String countryId}) async {
    Map<String, String> queryParams = {
      HttpConstants.PARAMS_COUNTRYID: countryId,
    };

    await getRequestWithRequest(GeneralPath.API_STATE_LIST, queryParams).then((
        response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);

        getStateModel = GetStateModel.fromJson(mResponse);

        if (getStateModel.meta?.status == true) {
          print('status true: ${getStateModel.meta?.status}');
          print('Response Data: ${getStateModel.data}');
          print('data size: ${getStateModel.data?.length}');

          getCustomStateList.clear();
          print('Clear');
          getCustomStateList.add(
              GetCustomStateModel(stateId: 0, stateName: "Select"));
          // print('Cityname: ${getCustomCityList[0].cityName}');

          for (int i = 0; i < (getStateModel.data?.length ?? 0); i++) {
            getCustomStateList.add(GetCustomStateModel(
                stateId: getStateModel.data?[i].stateId,
                stateName: getStateModel.data?[i].stateName));
          }

          if(getCustomStateList.length >1){
            isStateAvail = true;
            print('getCustomStateList length: ${getCustomStateList.length}');
            update();
          }

          isStateVisible = true;
          update();
        } else {
          showToastMessage(getStateModel.meta!.msg.toString());
          isStateVisible = false;
          update();
        }
      } else {
        showToastMessage(getStateModel.meta!.msg.toString());
        isStateVisible = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return getStateModel;
    });
  }

  Future<void> callGetCityListAPI({required String countryId, required String stateId,}) async {

    isCityVisible = false;
    update();

    Map<String, String> queryParams = {
      HttpConstants.PARAMS_COUNTRYID: countryId,
      HttpConstants.PARAMS_STATEID: stateId,
    };

    await getRequestWithRequest(GeneralPath.API_CITY_LIST, queryParams).then((
        response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);

        getCityModel = GetCityModel.fromJson(mResponse);
        if (getCityModel.meta?.status == true) {
          print('status true: ${getCityModel.meta?.status}');
          // print('Response Data: ${getCityModel.data}');

          getCustomCityList.clear();
          print('Clear');
          getCustomCityList.add(
              GetCustomCityModel(cityId: 0, cityName: "Select"));
          print('Cityname: ${getCustomCityList[0].cityName}');

          for (int i = 0; i < (getCityModel.data?.length ?? 0); i++) {
            getCustomCityList.add(GetCustomCityModel(
                cityId: getCityModel.data?[i].cityId,
                cityName: getCityModel.data?[i].cityName));
          }

          if(getCustomCityList.length >1){
            isCityAvail = true;
            print('getCustomCityList length: ${getCustomCityList.length}');
            update();
          }

          /*   var _selectCityName = 'Noida';
          if (getCityModel.meta?.status == true) {
            print('city status: ${getCityModel.meta?.status}');
            for (int i = 0; i < (getCustomCityList.length); i++) {
              print('For Loop i: ${i}');
              // print('search edit city: ${getAddressModel.data?[index].cityName}');
              print('api city : ${getCustomCityList[i].cityName}');
              if(_selectCityName == getCustomCityList[i].cityName) {
                print('Match city:');
                  _selectCityName =
                      getCustomCityList[i].cityName
                          .toString();
                  print('_selectCityName: $_selectCityName');
              }
            }
          }*/
         /* if(isStateAvail == true) {
            for (int j = 0; j < (getCustomCityList.length); j++) {
              print('For Loop i: $j');
              print('search edit city: $cityName');
              print('api city : ${getCustomCityList[j].cityName}');
              if (cityName ==
                  getCustomCityList[j].cityName) {
                print('Match city: $cityName');
                selectCityName =
                    getCustomCityList[j].cityName
                        .toString();
                cityId = getCustomCityList[j].cityId
                    .toString();
                print('_selectCityName: $selectCityName');
                // addressController.isStateVisible = true;
                isCityAvail = true;
                update();
              }
            }
          }*/
          isCityVisible = true;
          update();
        } else {
          getCustomCityList.clear();
          print('Clear');
          getCustomCityList.add(
              GetCustomCityModel(cityId: 0, cityName: "Select"));
          print('Cityname: ${getCustomCityList[0].cityName}');
          showToastMessage(getCityModel.meta?.msg.toString() ?? "");
          isCityVisible = false;
          update();
        }
      } else {
        showToastMessage(getCityModel.meta!.msg.toString());
        isCityVisible = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return getCustomCityList;
    });
  }

  postAddressApi(
      {required String addressLine, required String addressType, required String cityId,
        required String countryId, required String landmark, required String mobile, required String name,
        required String pincode, required String stateID, required String lat, required String long, required bool isDefault}) {
    isAddressPosted = !isAddressPosted;
    update();

    final params = jsonEncode({
      HttpConstants.PARAMS_ADDRESSLINE: addressLine,
      HttpConstants.PARAMS_ADDRESSTYPE: addressType,
      HttpConstants.PARAMS_CITYID: cityId,
      HttpConstants.PARAMS_COUNTRYID: countryId,
      HttpConstants.PARAMS_LANDMARK: landmark,
      HttpConstants.PARAMS_MOBILE: mobile,
      HttpConstants.PARAMS_NAME: name,
      HttpConstants.PARAMS_PINCODE: pincode,
      HttpConstants.PARAMS_STATEID: stateID,
      HttpConstants.PARAMS_CORDINATES: [lat, long],
      HttpConstants.PARAMS_ISDEFAULT: isDefault,
    });

    postRequest(GeneralPath.API_ADD_ADDRESS, params).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        deleteCartModel = DeleteCartModel.fromJson(mResponse);
        if (deleteCartModel.meta?.status == true) {
          showToastMessage(deleteCartModel.meta!.msg.toString());
          Get.back(result: true);
        } else {
          showToastMessage(deleteCartModel.meta!.msg.toString());
        }
        isAddressPosted = !isAddressPosted;
        update();
      } else {
        showToastMessage(deleteCartModel.meta!.msg!);
        isAddressPosted = false;
        update();
      }
    });
  }

  updateAddressApi(
      {required String addressId, required String addressLine, required String addressType, required String cityId,
        required String countryId, required String landmark, required String mobile, required String name,
        required String pincode, required String stateID, required String lat, required String long, required bool isDefault}) async {
    isAddressUpdate = !isAddressUpdate;
    update();
    final params = jsonEncode({
      HttpConstants.PARAMS_ADDRESSID: addressId,
      HttpConstants.PARAMS_ADDRESSLINE: addressLine,
      HttpConstants.PARAMS_ADDRESSTYPE: addressType,
      HttpConstants.PARAMS_CITYID: cityId,
      HttpConstants.PARAMS_COUNTRYID: countryId,
      HttpConstants.PARAMS_LANDMARK: landmark,
      HttpConstants.PARAMS_MOBILE: mobile,
      HttpConstants.PARAMS_NAME: name,
      HttpConstants.PARAMS_PINCODE: pincode,
      HttpConstants.PARAMS_STATEID: stateID,
      HttpConstants.PARAMS_CORDINATES: [lat, long],
      HttpConstants.PARAMS_ISDEFAULT: isDefault,
    });
    await putRequest(GeneralPath.API_UPDATE_ADDRESS, params).then((response) {
      if (response.statusCode == 200) {
        print('Response Data: ${response.body}');
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        deleteCartModel = DeleteCartModel.fromJson(mResponse);
        if (deleteCartModel.meta?.status == true) {
          print('status : ${deleteCartModel.meta?.status}');
          showToastMessage(deleteCartModel.meta!.msg.toString());
          Get.back(result: true);
        } else {
          showToastMessage(deleteCartModel.meta!.msg.toString());
        }
        isAddressUpdate = !isAddressUpdate;
        update();
      } else {
        showToastMessage(deleteCartModel.meta!.msg.toString());
        isAddressUpdate = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      // return isAddressUpdate;
      return deleteCartModel;
    });
  }

  /* Future<void> postCODApi({required final params}) async{

    await postRequest(GeneralPath.API_COD, params).then((response) {
      // isAddressPosted = true;
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        deleteCartModel = DeleteCartModel.fromJson(mResponse);
        if (deleteCartModel.meta?.status == true) {
          showToastMessage(deleteCartModel.meta!.msg.toString());
          print('status in Controller: ${deleteCartModel.meta?.status}');
          isCODPosted = true;
          update();
        }else{
          showToastMessage(deleteCartModel.meta!.msg.toString());
          isCODPosted = false;
          update();
        }
        update();
      } else {
        showToastMessage(deleteCartModel.meta!.msg!);
        isCODPosted = false;
        update();
      }
      update();
      return deleteCartModel;
    });
  }*/

  calculateAmount(String amount) {
    final price = int.parse(amount);
    return price;
  }
}

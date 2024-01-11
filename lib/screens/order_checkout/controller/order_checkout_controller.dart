import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';
import '../../../core/http_utils/http_constants.dart';
import '../../../core/http_utils/http_get_util.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_preferences.dart';
import '../../../routes/general_path.dart';
import '../../address/model/getAddressDetailsModel.dart';
import '../../address/model/get_address_model.dart';
import '../model/get_slot_type_model.dart';

class OrderCheckoutController extends GetxController {
  GetAddressDetailsModel getAddressDetailsModel = GetAddressDetailsModel();
  GetAddressModel getAddressModel = GetAddressModel();
  GetSlotTypeModel getSlotTypeModel = GetSlotTypeModel();
  String defaultAddress = "";
  bool addressFound = false;
  String addressId = "";
  bool isLoaderVisible = true;
  var isTimeAvail;

  Future<void>callAddressDetailsAPI({required String addressId,}) async {
    await getRequest(GeneralPath.API_ADDRESS_DETAILS + addressId).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);

        getAddressDetailsModel = GetAddressDetailsModel.fromJson(mResponse);
        if (getAddressDetailsModel.meta?.status == true) {
          debugPrint('status true: ${getAddressDetailsModel.meta?.status}');
          debugPrint('Response Address Data: ${getAddressDetailsModel.data}');

          var addressline1, landmark, cityName, stateName, pincode;
          debugPrint('addressline1 before ${getAddressDetailsModel.data?.addressLine1}');
          if (getAddressDetailsModel.data?.addressLine1 != null) {
            if (getAddressDetailsModel.data?.addressLine1 != " ") {
              addressline1 = getAddressDetailsModel.data!.addressLine1.toString() + ", ";
              debugPrint('addressline1: $addressline1');
            } else {
              addressline1 = "";
              debugPrint('addressline else : $addressline1');
            }
          } else {
            addressline1 = "";
            debugPrint('addressline1 else : $addressline1');
          }
          if (getAddressDetailsModel.data?.landmark != "") {
            landmark = (getAddressDetailsModel.data?.landmark.toString() ?? "") + ", ";
          }
          if (getAddressDetailsModel.data?.cityName != "") {
            cityName = (getAddressDetailsModel.data?.cityName.toString() ?? "") + ", ";
          }else{
            cityName = "";
          }
          if (getAddressDetailsModel.data?.stateName != "") {
            stateName =
                (getAddressDetailsModel.data?.stateName.toString() ?? "") + ", ";
          }
          if (getAddressDetailsModel.data?.pincode != 0) {
            pincode = (getAddressDetailsModel.data?.pincode.toString() ?? "") + "";
          }

          defaultAddress =
              addressline1 + landmark + cityName + stateName + pincode;
          debugPrint('defaultAddress: $defaultAddress');
          addressFound = true;
          update();
        } else {
          // showToastMessage('No Default address found');
          addressFound = false;
          update();
        }
      } else {
        // showToastMessage(getAddressDetailsModel.meta!.msg.toString());
        addressFound = false;
        update();
        // throw Exception('Failed to load data.');
      }
      update();
      return getAddressDetailsModel;
    });
  }

  Future<void>callGetAddressAPI() async {
    await getRequest(GeneralPath.API_GET_ADDRESS).then((response) {

      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);

        getAddressModel = GetAddressModel.fromJson(mResponse);
        if (getAddressModel.meta?.status == true) {
          debugPrint('status true: ${getAddressModel.meta?.status}');
          debugPrint('Response Data: ${getAddressModel.data}');
          for(int i=0;i<(getAddressModel.data?.length ?? 0); i++){
              if(getAddressModel.data?[i].isDefault == true){
                addressId = getAddressModel.data![i].addressId.toString();
                debugPrint('AddressId api : $addressId');
                AppPreferences.setAddressId(addressId);
                callAddressDetailsAPI(addressId: addressId);
                update();
              }
          }
        }
      } else {
        showToastMessage(getAddressModel.meta!.msg.toString());
        throw Exception('Failed to load data.');
      }
      update();
      return getAddressModel;
    });
  }

  Iterable<TimeOfDay> getTimes(TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;
    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += step.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }

  resetTime(){
    debugPrint('-======> reset TimeAvail');
    for(int j=0; j<(getSlotTypeModel.data?.length ?? 0); j++) {
      if (getSlotTypeModel.data?[j].combineTime.isNotEmpty == true) {
          getSlotTypeModel.data?[j].setAvailTime = false;
          update();
        }
      }
    }

  checkTimeAvail(String compareDate){
    debugPrint('-======> inside checkTimeAvail');
    debugPrint('compareDate: $compareDate');
    for(int j=0; j<(getSlotTypeModel.data?.length ?? 0); j++) {
      dynamic startTime = getSlotTypeModel.data?[j].startTime.replaceAll('.', ':');
      dynamic endTime = getSlotTypeModel.data?[j].endTime.replaceAll('.', ':');
      debugPrint('startTime: $startTime, endTime: $endTime');
      if (getSlotTypeModel.data?[j].combineTime.isNotEmpty == true) {
        if (revFormatter.format(DateTime.now()) == compareDate) {
          isTimeAvail = isValidTimeRange(
            startTime ?? "",
            endTime ?? "",);
          debugPrint('isTimeAvail: $isTimeAvail');
          getSlotTypeModel.data?[j].setAvailTime = isTimeAvail;
        } else {
          debugPrint('Future date');
          isTimeAvail = true;
          getSlotTypeModel.data?[j].setAvailTime = isTimeAvail;
          debugPrint('Future date: ${getSlotTypeModel.data?[j].isAvail}');
        }
      }
      update();
    }
  }

  Future<void> callGetSlotAPI({required String restaurantId,required String date, }) async{
    Map<String, String> queryParams = {
      HttpConstants.PARAMS_RESTID: restaurantId,
      HttpConstants.PARAMS_DATE: date,
    };

    await getRequestWithRequest(GeneralPath.API_SLOT_LIST, queryParams).then((response) {

      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        getSlotTypeModel = GetSlotTypeModel.fromJson(mResponse);
        if (getSlotTypeModel.meta?.status == true) {
          debugPrint('status true: ${getSlotTypeModel.meta?.status}');
          debugPrint('Response GetSlot Data: ${getSlotTypeModel.data}');
          for(int i = 0; i < (getSlotTypeModel.data?.length ?? 0); i++) {
            String start = DateFormat.jm().format(
                DateFormat("hh:mm").parse(getSlotTypeModel.data?[i].startTime.replaceAll('.', ':') ?? ""));
            String end = DateFormat.jm().format(
                DateFormat("hh:mm").parse(getSlotTypeModel.data?[i].endTime.replaceAll('.', ':') ?? ""));
            debugPrint('start: $start, end: $end');

            getSlotTypeModel.data?[i].setCombineTime = start + " - " + end;

          }

          String currDate = revFormatter.format(DateTime.now());
          debugPrint('currDate: $currDate');
          checkTimeAvail(currDate);
        }
        isLoaderVisible = false;
        update();
      } else {
        isLoaderVisible = true;
        update();
        showToastMessage(getSlotTypeModel.meta!.msg.toString());
        throw Exception('Failed to load data.');
      }
      update();
      return getSlotTypeModel;
    });
  }

}

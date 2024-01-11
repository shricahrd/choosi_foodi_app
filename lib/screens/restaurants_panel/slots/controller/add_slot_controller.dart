import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../../../../core/http_utils/http_post_util.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../routes/general_path.dart';
import '../model/custom_add_slot_model.dart';
import '../model/get_slot_details_model.dart';
import '../model/meta_model.dart.dart';

class AddEditHoursController extends GetxController {
  MetaModel metaModel = MetaModel();
  GetSlotDetailsModel getSlotDetailsModel = GetSlotDetailsModel();
  bool isSlotAdded = false;
  bool isLoaderVisible = true;
  List<CustomTimeModel> timeModelList = [];
  List<Map<String, dynamic>> timeList = [];
  List<String> dayList = [
    'Select Day',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  String? selectDay = "Select Day";

  convertTo24HoursList() {
    timeList.clear();
    String startPeriodTime = "AM";
    String endPeriodTime = "AM";

    for (int i = 0; i < timeModelList.length; i++) {
      if (timeModelList[i].startMorning == true) {
        startPeriodTime = "AM";
      } else {
        startPeriodTime = "PM";
      }

      if (timeModelList[i].endMorning == true) {
        endPeriodTime = "AM";
      } else {
        endPeriodTime = "PM";
      }

      String startTime12Hour = timeModelList[i].startHour +
          ":" +
          timeModelList[i].startMinute +
          " " +
          startPeriodTime;
      String convertTo24HoursList = timeModelList[i].endHour +
          ":" +
          timeModelList[i].endMinute +
          " " +
          endPeriodTime;

      // debugPrint('startTime12Hour: $startTime12Hour');
      String startTime24Hour = convertTo24HourFormat(startTime12Hour);
      String endTime24Hour = convertTo24HourFormat(convertTo24HoursList);
      // debugPrint('convertedStartTime: $startTime24Hour');
      // debugPrint('convertedEndTime: $endTime24Hour');
      timeList.add(
        {"startTime": startTime24Hour, "endTime": endTime24Hour},
      );
    }
    // debugPrint('timeList len: ${timeList.length}');
    // debugPrint('timeList len: ${timeList[0].toString()}');
  }

  void addSlotTime() {
    timeModelList.add(
      CustomTimeModel(
          startHour: startHoursList[0],
          startMinute: startMinutesList[0],
          endHour: endHoursList[0],
          endMinute: endHoursList[0],
          startMorning: false,
          endMorning: false),
    );
    isLoaderVisible = false;
  }

  passToLocalList() {
    dynamic apiSHours, apiEHours, apiSMin, apiEMin;
    String selectedStartHour = startHoursList[0];
    String selectedStartMin = startMinutesList[0];
    String selectedEndHour = endHoursList[0];
    String selectedEndMin = endMinutesList[0];
    for (int i = 0; i < (getSlotDetailsModel.data?.time.length ?? 0); i++) {
      int apiStartHours = int.parse(getSlotDetailsModel.data?.time[i].startTime
              .toString()
              .split(".")
              .first ??
          "");
      int apiEndHours = int.parse(getSlotDetailsModel.data?.time[i].endTime
              .toString()
              .split(".")
              .first ??
          "");
      int apiStartMin = int.parse(getSlotDetailsModel.data?.time[i].startTime
              .toString()
              .split(".")
              .last ??
          "");
      int apiEndMin = int.parse(getSlotDetailsModel.data?.time[i].endTime
              .toString()
              .split(".")
              .last ??
          "");
      bool isStartMorning = false, isEndMorning = false;

      debugPrint('apiStartHours: $apiStartHours, apiEndHours: $apiEndHours');
      debugPrint('apiStartMin: $apiStartMin, apiEndMin: $apiEndMin');

      if (apiStartHours >= 12) {
        apiSHours = apiStartHours - 12;
        if (apiSHours == 0) {
          apiSHours = 12;
        }
        isStartMorning = false;
      } else {
        apiSHours = apiStartHours;
        isStartMorning = true;
      }

      if (apiEndHours >= 12) {
        apiEHours = apiEndHours - 12;
        if (apiEHours == 0) {
          apiEHours = 12;
        }
        isEndMorning = false;
      } else {
        apiEHours = apiEndHours;
        isEndMorning = true;
      }

      if (apiSHours.toString().length == 1) {
        apiSHours = "0$apiSHours";
      }

      if (apiEHours.toString().length == 1) {
        apiEHours = "0$apiEHours";
      }

      if (apiStartMin.toString().length == 1) {
        apiSMin = "0$apiStartMin";
      } else {
        apiSMin = apiStartMin;
      }

      if (apiEndMin.toString().length == 1) {
        apiEMin = "0$apiEndMin";
      } else {
        apiEMin = apiEndMin;
      }

      debugPrint(
          'apiSHours: $apiSHours, apiEHours: $apiEHours, apiStartMin: $apiSMin, apiEndmin: $apiEMin');

      for (int a = 0; a < startHoursList.length; a++) {
        if (startHoursList[a] == apiSHours.toString()) {
          selectedStartHour = startHoursList[a];
          debugPrint('fetched startHour: $selectedStartHour');
          break;
        }
      }

      for (int b = 0; b < startMinutesList.length; b++) {
        if (startMinutesList[b] == apiSMin.toString()) {
          selectedStartMin = startMinutesList[b];
          debugPrint('fetched selectedStartMin: $selectedStartMin');
          break;
        }
      }

      for (int c = 0; c < endHoursList.length; c++) {
        if (endHoursList[c] == apiEHours.toString()) {
          selectedEndHour = endHoursList[c];
          debugPrint('fetched selectedEndHour: $selectedEndHour');
          break;
        }
      }

      for (int d = 0; d < endMinutesList.length; d++) {
        if (endMinutesList[d] == apiEMin.toString()) {
          selectedEndMin = endMinutesList[d];
          debugPrint('fetched selectedEndHour: $selectedEndMin');
          break;
        }
      }

      timeModelList.add(
        CustomTimeModel(
            startHour: selectedStartHour,
            startMinute: selectedStartMin,
            endHour: selectedEndHour,
            endMinute: selectedEndMin,
            startMorning: isStartMorning,
            endMorning: isEndMorning),
      );
    }
  }

  // Function to remove startTime and endTime from the list
  void removeSlotTime(int index) {
    if (index >= 0 && index < timeModelList.length) {
      timeModelList.removeAt(index);
    }
  }

  // List<String> hoursList = List.generate(12, (index) => index.toString().padLeft(2, '0'));
  List<String> startHoursList =
      List.generate(12, (index) => (index + 1).toString().padLeft(2, '0'));
  List<String> startMinutesList =
      List.generate(60, (index) => index.toString().padLeft(2, '0'));
  List<String> endHoursList =
      List.generate(12, (index) => (index + 1).toString().padLeft(2, '0'));
  List<String> endMinutesList =
      List.generate(60, (index) => index.toString().padLeft(2, '0'));

  Future<void> addNewSlotApi({
    required final params,
  }) async {
    isSlotAdded = !isSlotAdded;
    update();

    await postRequest(GeneralPath.API_REST_ADD_NEW_SLOT, params)
        .then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        metaModel = MetaModel.fromJson(mResponse);
        if (metaModel.meta?.status == true) {
          showToastMessage(metaModel.meta?.msg ?? "");
          print('status in Controller: ${metaModel.meta?.status}');
        } else {
          showToastMessage(metaModel.meta?.msg ?? "");
        }
        isSlotAdded = !isSlotAdded;
        update();
      } else {
        showToastMessage(metaModel.meta?.msg ?? "");
        isSlotAdded = false;
        update();
      }
      update();
      return metaModel;
    });
  }

  // getSlotDetailsModel

  Future<void> callGetSlotDetails(String slotId) async {
    isLoaderVisible = true;
    await getRequest(GeneralPath.API_REST_SLOT_DETAILS + slotId)
        .then((response) async {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);

        getSlotDetailsModel = GetSlotDetailsModel.fromJson(mResponse);
        if (getSlotDetailsModel.meta?.status == true) {
          debugPrint('status true: ${getSlotDetailsModel.meta?.status}');
          debugPrint('Response Data: ${getSlotDetailsModel.data}');
          // selectDay = getSlotDetailsModel.data?.day.toLowerCase();
          selectDay = getSlotDetailsModel.data?.day.toLowerCase().capitalizeFirst;
          await passToLocalList();
          update();
        } else {
          showToastMessage(getSlotDetailsModel.meta?.msg.toString() ?? "");
        }
      } else {
        showToastMessage(getSlotDetailsModel.meta?.msg.toString() ?? "");
        throw Exception('Failed to load data.');
      }
      isLoaderVisible = false;
      update();
      return getSlotDetailsModel;
    });
  }


  Future<void> editSlotApi({required final params}) async{
    isSlotAdded = !isSlotAdded;
    update();

    await putRequest(GeneralPath.API_REST_NEW_UPDATE_SLOT, params).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        metaModel = MetaModel.fromJson(mResponse);
        if (metaModel.meta?.status == true) {
          showToastMessage(metaModel.meta?.msg ?? "");
          print('status in Controller: ${metaModel.meta?.status}');
        }else{
          showToastMessage(metaModel.meta?.msg ?? "");
        }
        isSlotAdded = !isSlotAdded;
        update();
      } else {
        showToastMessage(metaModel.meta?.msg ?? "");
        isSlotAdded = false;
        update();
      }
      update();
      return metaModel;
    });
  }
}

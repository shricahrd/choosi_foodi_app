
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/http_utils/http_constants.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../../../../core/http_utils/http_post_util.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../routes/general_path.dart';
import '../model/get_new_slot_model.dart';
import '../model/meta_model.dart.dart';

class SlotController extends GetxController{
  GetNewSlotModel getSlotListModel = GetNewSlotModel();

  MetaModel metaModel = MetaModel();
  bool isLoaderVisible = false;
  bool isStatusChanged = false;

  Future<void>getSlotList(bool isLoaderShow, {required String status}) async{

    if (isLoaderShow) {
      isLoaderVisible = !isLoaderVisible;
    }

    Map<String, String> queryParams = {
      HttpConstants.PARAMS_STATUS: status.toString(),
    };

    update();
    await getRequestWithRequest(GeneralPath.API_REST_GET_NEW_SLOT, queryParams).then((response) {
      if (response.statusCode == 200) {
        getSlotListModel = GetNewSlotModel.fromJson(json.decode(response.body));
        if (getSlotListModel.meta?.status == true) {
          print('status true: ${getSlotListModel.meta?.status}');
          print('Response Profile Data: ${getSlotListModel.data}');

          dynamic start, end;
          for(int i=0; i< (getSlotListModel.data?.length ?? 0); i++){
          for(int j=0; j< (getSlotListModel.data?[i].time.length ?? 0); j++) {
            dynamic startDate = getSlotListModel.data?[i].time[j].startTime ?? "";
            dynamic endDate = getSlotListModel.data?[i].time[j].endTime ?? "";
            // debugPrint('startDate: $startDate, endDate: $endDate');
            int startHour = int.parse(startDate.toString().split('.').first);
            int startMin = int.parse(startDate.toString().split('.').last);
            int endHour = int.parse(endDate.toString().split('.').first);
            int endMin = int.parse(endDate.toString().split('.').last);
            // debugPrint('startHour: $startHour, startMin: $startMin, endHour: $endHour, endMin: $endMin');
            start = convertTo12HourFormat(startHour, startMin);
            end = convertTo12HourFormat(endHour, endMin);
            debugPrint('start: $start, end: $end');
            getSlotListModel.data?[i].time[j].setTimeUpdated = "$start to $end";
            }
          }

        }/*else{
          if (getSlotListModel.meta?.msg != "") {
            showToastMessage(getSlotListModel.meta?.msg ?? "");
          }
        }*/
        if (isLoaderShow) {
          isLoaderVisible = !isLoaderVisible;
        }
        update();
      } else {
        if (getSlotListModel.meta?.msg != "") {
          showToastMessage(getSlotListModel.meta?.msg ?? "");
          isLoaderVisible = false;
          update();
        }
      }
      update();
      return getSlotListModel;
    });
  }

  Future<void> callStatusUpdateAPI({required String slotId, required String status, }) async{
    final params = jsonEncode({
      HttpConstants.PARAMS_REST_SLOT_ID: slotId,
      HttpConstants.PARAMS_STATUS: status,
    });
    await putRequest(GeneralPath.API_REST_CHANGE_SLOT_STATUS, params).then((response) {
      if (response.statusCode == 200) {
        print('Response Data: ${response.body}');
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        metaModel = MetaModel.fromJson(mResponse);
        if (metaModel.meta?.status == true) {
          print('status : ${metaModel.meta?.status}');
          showToastMessage(metaModel.meta!.msg.toString());
          isStatusChanged = true;
          update();
          getSlotList(false, status: "");
        }else{
          showToastMessage(metaModel.meta!.msg.toString());
          isStatusChanged = false;
          update();
        }
      } else {
        showToastMessage(metaModel.meta!.msg.toString());
        isStatusChanged = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
    });
  }

}
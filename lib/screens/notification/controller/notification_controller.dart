import 'dart:convert';
import 'package:get/get.dart';
import '../../../core/http_utils/http_get_util.dart';
import '../../../routes/general_path.dart';
import '../model/notification_details_model.dart';
import '../model/notification_list_model.dart.dart';

class NotificationController extends GetxController {
  NotificationModel notificationModel = NotificationModel();
  NotificationDetailsModel notificationDetailsModel =   NotificationDetailsModel();
  bool notificationLoader = false;
  int notificationCount = 0;

  callNotificationAPI(bool isLoaderShow) {
    if (isLoaderShow) {
      notificationLoader = !notificationLoader;
    }
    update();
    getRequest(GeneralPath.API_NOTIFICATION_LIST).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);

        notificationModel = NotificationModel.fromJson(mResponse);
        if (notificationModel.meta?.status == true) {
          print('status true: ${notificationModel.meta?.status}');
          notificationCount = notificationModel.totalUnread;
          print('notificationCount: $notificationCount');
        }
      } else {
        print('notification Msg: ${notificationModel.meta?.msg}');
        // showToastMessage(notificationModel.meta?.msg ?? "");
        throw Exception('Failed to load data.');
      }
      if (isLoaderShow) {
        notificationLoader = !notificationLoader;
      }
      update();
    });
  }

  Future<void> callNotificationDetailsAPI(String id) async {
   await getRequest(GeneralPath.API_NOTIFICATION_DETAILS + id).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);

        notificationDetailsModel = NotificationDetailsModel.fromJson(mResponse);
        if (notificationDetailsModel.meta?.status == true) {
          print('status true: ${notificationDetailsModel.meta?.status}');
          print('Response Notification details Data: ${notificationDetailsModel.data}');
          callNotificationAPI(false);
        }
      } else {
        print('${notificationDetailsModel.meta?.msg ?? ""}');
        // showToastMessage(notificationDetailsModel.meta?.msg ?? "");
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return notificationDetailsModel;
    });
  }
}

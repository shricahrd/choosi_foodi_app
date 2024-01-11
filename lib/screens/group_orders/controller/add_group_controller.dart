import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../core/http_utils/http_post_util.dart';
import '../../../core/utils/app_constants.dart';
import '../../../routes/general_path.dart';
import '../models/get_user_list_model.dart';
import '../models/invite_group_model.dart';

class AddGroupController extends GetxController {
  bool isUserGroupListVisible = false;
  GetUserListModel getUserListModel = GetUserListModel();
  InviteGroupModel inviteGroupModel = InviteGroupModel();
  bool isGroupInvitedVisible = false;
  List<GetUserDataList> foundUsersList = [];

  Future<void> callUserListApi({required final params}) async{

    await postRequest(GeneralPath.API_GROUP_USER_LIST, params).then((response) {

      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        getUserListModel = GetUserListModel.fromJson(mResponse);
        if (getUserListModel.meta?.status == true) {
          showToastMessage(getUserListModel.meta!.msg.toString());
          debugPrint('status in Controller: ${getUserListModel.meta?.status}');
          debugPrint('data: ${getUserListModel.data}');
          foundUsersList = getUserListModel.data!;
          isUserGroupListVisible = true;
          update();
        }else{
          // showToastMessage(getUserListModel.meta!.msg.toString());
          isUserGroupListVisible = false;
          update();
        }
        update();
      } else {
        showToastMessage(getUserListModel.meta?.msg ?? "");
        isUserGroupListVisible = false;
        update();
      }
      update();
      return getUserListModel;
    });
  }

  Future<void> callInviteUserApi({required final params }) async{
    isGroupInvitedVisible = true;
    update();
    await putRequest(GeneralPath.API_GROUP_INVITE, params).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        inviteGroupModel = InviteGroupModel.fromJson(mResponse);
        if (inviteGroupModel.meta?.status == true) {
          showToastMessage(inviteGroupModel.meta?.msg.toString() ?? "");
          debugPrint('status in Controller: ${inviteGroupModel.meta?.status}');
          isGroupInvitedVisible = false;
          update();
        }else{
          showToastMessage(inviteGroupModel.meta?.msg.toString() ?? "");
          isGroupInvitedVisible = false;
          update();
        }
        update();
      } else {
        showToastMessage(inviteGroupModel.meta?.msg ?? "");
        isGroupInvitedVisible = false;
        update();
      }
      update();
      return inviteGroupModel;
    });
  }
}

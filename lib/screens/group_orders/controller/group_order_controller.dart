import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../core/http_utils/http_post_util.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../routes/general_path.dart';
import '../../cart/model/delete_cart_model.dart';
import '../models/add_group_model.dart';

class GroupOrderController extends GetxController {
  bool isAddGroupPosted = false;
  AddGroupModel addGroupModel = AddGroupModel();
  bool isOrderDeleted = false;
  DeleteCartModel deleteCartModel = DeleteCartModel();

  Future<void> callAddGroupApi({required final params}) async{
    isAddGroupPosted = true;
    update();
    await postRequest(GeneralPath.API_CREATE_GROUP, params).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        addGroupModel = AddGroupModel.fromJson(mResponse);
        if (addGroupModel.meta?.status == true) {
          // showToastMessage(addGroupModel.meta?.msg.toString() ?? "");
          debugPrint('status in Controller: ${addGroupModel.meta?.status}');
          isAddGroupPosted = false;
        }else{
          showToastMessage(alreadyExistGroup);
          isAddGroupPosted = false;
        }
      } else {
        showToastMessage(addGroupModel.meta?.msg ?? "");
        isAddGroupPosted = true;
      }
      update();
      return addGroupModel;
    });
  }

  Future<void>deleteGroupAPI({required String groupId}) async{
    isOrderDeleted = true;
    update();
    await deleteRequest(GeneralPath.API_DELETE_GROUP + groupId,).then((response) {

      if (response.statusCode == 200) {
        print('Response Data: ${response.body}');
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        deleteCartModel = DeleteCartModel.fromJson(mResponse);
        if (deleteCartModel.meta?.status == true) {
          print('status : ${deleteCartModel.meta?.status}');
          showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
          isOrderDeleted = false;
          update();
        }else{
          showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
          isOrderDeleted = false;
          update();
        }
      } else {
        showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
        isOrderDeleted = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return deleteCartModel;
    });
  }

}
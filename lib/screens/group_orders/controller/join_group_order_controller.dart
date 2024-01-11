import 'dart:convert';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../core/http_utils/http_get_util.dart';
import '../../../core/http_utils/http_post_util.dart';
import '../../../core/utils/app_constants.dart';
import '../../../routes/general_path.dart';
import '../../cart/model/delete_cart_model.dart';
import '../models/group_details_model.dart';

class JoinGroupOrderController extends GetxController {
  bool isLoaderVisible = false;
  bool isGroupDetailsVisible = false;
  DeleteCartModel deleteCartModel = DeleteCartModel();
  GroupDetailsModel groupDetailsModel = GroupDetailsModel();
  dynamic restId;

  callGroupOrderDetailsAPI({required String groupId, }) {
    isGroupDetailsVisible = !isGroupDetailsVisible;
    update();
    getRequest(GeneralPath.API_GROUP_DETAILS + groupId).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        groupDetailsModel = GroupDetailsModel.fromJson(mResponse);
        if (groupDetailsModel.meta?.status == true) {
          print('status true: ${groupDetailsModel.meta?.status}');
          print('Response Data: ${groupDetailsModel.data}');

          restId = groupDetailsModel.data?.restaurantId ?? "";
          // isGroupDetailsVisible = true;
          // update();
        }else{
          showToastMessage(groupDetailsModel.meta!.msg.toString());
          // isGroupDetailsVisible = false;
          // update();
        }
        isGroupDetailsVisible = !isGroupDetailsVisible;
        update();
      } else {
        showToastMessage(groupDetailsModel.meta!.msg.toString());
        isGroupDetailsVisible = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
    });
  }

  Future<void> callJoinGroupApi({required String groupId }) async{
    isLoaderVisible = true;
    update();
    await putRequestUrl(GeneralPath.API_GROUP_JOIN + groupId).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        deleteCartModel = DeleteCartModel.fromJson(mResponse);
        if (deleteCartModel.meta?.status == true) {
          showToastMessage(deleteCartModel.meta!.msg.toString());
          print('status in Controller: ${deleteCartModel.meta?.status}');
          isLoaderVisible = false;
          update();
        }else{
          showToastMessage(deleteCartModel.meta!.msg.toString());
          isLoaderVisible = false;
          update();
        }
        update();
      } else {
        showToastMessage(deleteCartModel.meta!.msg!);
        isLoaderVisible = false;
        update();
      }
      update();
      return deleteCartModel;
    });
  }

}
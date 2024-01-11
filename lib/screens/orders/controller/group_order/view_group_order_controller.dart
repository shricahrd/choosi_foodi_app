import 'dart:convert';
import 'package:get/get.dart';
import '../../../../core/http_utils/http_constants.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../../../../core/http_utils/http_post_util.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../routes/general_path.dart';
import '../../../cart/model/delete_cart_model.dart';
import '../../model/group_order/view_go_cart_model.dart';

class ViewGroupCartController extends GetxController{
  ViewGoCartModel viewGoCartModel = ViewGoCartModel();
  DeleteCartModel deleteCartModel = DeleteCartModel();
  bool isLoaderVisible = true;
  bool isCartDeleted = false;
  bool isUserDeleted = false;
  bool isOrderDeleted = false;
  bool isAdmin = false;
  dynamic totalAmount;

 /* calculatePrice(int selectedPrice) {
    for (int i = 0; i < viewGoCartModel.data![0].cartMenu!.length; i++) {
       selectedPrice = int.parse(
          viewGoCartModel.data![0].cartMenu![i].selectQuantity.toString()) *
          int.parse(viewGoCartModel.data![0].cartMenu![i].price.toString());
      viewGoCartModel.data![0].cartMenu![i].setPrice = selectedPrice;
      update();
    }
  }*/

  Future<void> callViewGroupOrderAPI({required String groupId, required String userId}) async{
    totalAmount = 0;
    await getRequest(GeneralPath.API_GROUP_CART_VIEW + groupId).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        viewGoCartModel = ViewGoCartModel.fromJson(mResponse);
        if (viewGoCartModel.meta?.status == true) {
          print('status true: ${viewGoCartModel.meta?.status}');
          print('cartMenu Len: ${viewGoCartModel.data![0].cartMenu?.length}');
          for (int k = 0; k < (viewGoCartModel.data?.length ?? 0); k++) {
            for (int i = 0; i < (viewGoCartModel.data?[k].cartMenu?.length ?? 0); i++) {
              int selectedPrice = int.parse(
                  viewGoCartModel.data![k].cartMenu![i].selectQuantity
                      .toString()) *
                  int.parse(
                      viewGoCartModel.data![k].cartMenu![i].price.toString());
              viewGoCartModel.data![k].cartMenu![i].setPrice = selectedPrice;
              // totalAmount = totalAmount + selectedPrice;
              print('CalculatePrice: ${viewGoCartModel.data![k].cartMenu![i]
                  .calclulatePrice}');
              print('Calculate index: $i');
              update();
            }
          }
          totalAmount = viewGoCartModel.total.toString();
          print('totalAmount: $totalAmount');

          print('Compare AdminId =======>');
          for(int i = 0; i<viewGoCartModel.data!.length; i++){
            if(userId == viewGoCartModel.data?[i].adminUserId){
              print('Admin Id Match: ${viewGoCartModel.data?[i].adminUserId}');
              isAdmin = true;
              update();
            }else{
              print('Admin Id Not Match ${viewGoCartModel.data?[i].adminUserId}');
              isAdmin = false;
              update();
            }
          }
          isLoaderVisible = false;
          update();
        }else{
          showToastMessage(viewGoCartModel.meta!.msg.toString());
          isLoaderVisible = false;
          update();
        }
      } else {
        showToastMessage(viewGoCartModel.meta!.msg.toString());
        isLoaderVisible = true;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return viewGoCartModel;
    });
  }

  Future<void> deleteCartAPI({required String cartId,required String groupId,required String userId,})async {
    isCartDeleted = true;
    update();
    final params = jsonEncode({
      HttpConstants.PARAMS_CART_ID: cartId,
      HttpConstants.PARAMS_GROUPID: groupId,
      HttpConstants.PARAMS_USERID: userId,
    });
    await putRequest(
      GeneralPath.API_GROUP_CART_REMOVE, params,).then((response) {
      if (response.statusCode == 200) {
        print('Response Data: ${response.body}');

        Map<String, dynamic> mResponse = jsonDecode(response.body);

        deleteCartModel = DeleteCartModel.fromJson(mResponse);
        if (deleteCartModel.meta?.status == true) {
          print('status : ${deleteCartModel.meta?.status}');
          // showToastMessage(deleteCartModel.meta!.msg.toString());
          // callGetCartAPI();
          isCartDeleted = false;
          update();
        } else {
          showToastMessage(deleteCartModel.meta!.msg.toString());
          isCartDeleted = false;
          update();
        }
      } else {
        showToastMessage(deleteCartModel.meta!.msg.toString());
        isCartDeleted = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return deleteCartModel;
    });
  }

  Future<void> deleteUserAPI({required String groupId,required String userId,}) async {
    isUserDeleted = !isUserDeleted;
    update();
    final params = jsonEncode({
      HttpConstants.PARAMS_GROUPID: groupId,
      HttpConstants.PARAMS_USERID: userId,
    });
    await  putRequest(
      GeneralPath.API_GROUP_CART_REMOVE, params,).then((response) {
      if (response.statusCode == 200) {
        print('Response Data: ${response.body}');

        Map<String, dynamic> mResponse = jsonDecode(response.body);

        deleteCartModel = DeleteCartModel.fromJson(mResponse);
        if (deleteCartModel.meta?.status == true) {
          print('status : ${deleteCartModel.meta?.status}');
          // showToastMessage('User succesffully removed');
          // callGetCartAPI();
          // isUserDeleted = false;
          // update();
        } else {
          showToastMessage(deleteCartModel.meta!.msg.toString());
          // isUserDeleted = false;
          // update();
        }
        isUserDeleted = !isUserDeleted;
        update();
      } else {
        showToastMessage(deleteCartModel.meta!.msg.toString());
        isUserDeleted = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return deleteCartModel;
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
          showToastMessage(deleteCartModel.meta!.msg.toString());
          isOrderDeleted = false;
          update();
        }else{
          showToastMessage(deleteCartModel.meta!.msg.toString());
          isOrderDeleted = false;
          update();
        }
      } else {
        showToastMessage(deleteCartModel.meta!.msg.toString());
        isOrderDeleted = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      return deleteCartModel;
    });
  }
}

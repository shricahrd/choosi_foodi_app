import 'dart:convert';
import 'package:choosifoodi/core/http_utils/http_get_util.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../core/utils/app_constants.dart';
import '../../../routes/general_path.dart';
import '../model/get_coupon_list_model.dart.dart';

class CouponController extends GetxController {
  bool isLoaderVisible = true;
  GetCouponList getCouponList = GetCouponList();

  Future<void> callCouponListAPI() async{

    await getRequest(GeneralPath.API_COUPON_LIST).then((response) {

      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        getCouponList = GetCouponList.fromJson(mResponse);
        if (getCouponList.meta?.status == true) {
          print('status true: ${getCouponList.meta?.status}');
          print('Response Data: ${getCouponList.data}');

        }
      } else {
        showToastMessage(getCouponList.meta!.msg.toString());
        throw Exception('Failed to load data.');
      }
      isLoaderVisible = !isLoaderVisible;
      update();
      return getCouponList;
    });
  }

}
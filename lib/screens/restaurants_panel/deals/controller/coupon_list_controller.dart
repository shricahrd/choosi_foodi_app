import 'dart:convert';
import 'package:get/get.dart';
import '../../../../core/http_utils/http_constants.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../../../../core/http_utils/http_post_util.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../routes/general_path.dart';
import '../../slots/model/meta_model.dart.dart';
import '../model/get_coupon_details_model.dart';
import '../model/get_coupon_list_model.dart';

class CouponListController extends GetxController{

  GetCouponListModel getCouponListModel = GetCouponListModel();
  GetCouponDetailsModel getCouponDetailsModel = GetCouponDetailsModel();
  // GetCouponDetailsModel getCouponDetailsModel = GetCouponDetailsModel();
  MetaModel metaModel = MetaModel();
  bool isLoaderVisible = false;
  bool isLoaderDetailsVisible = true;
  bool isStatusChanged = false;
  String filterStartDate = "", filterExpireDate = "", createdAt = "";
  dynamic couponType;

  String parseTimeIssueDate(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterMonth.format(date);
    filterStartDate = d12;
    print('filterStartDate: $filterStartDate');
    return d12;
  }

  String parseTimeExpireDate(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterMonth.format(date);
    filterExpireDate = d12;
    print('filterExpireDate: $filterExpireDate');
    return d12;
  }

  String parseTimeCreatedDate(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterMonth.format(date);
    createdAt = d12;
    print('filterExpireDate: $filterExpireDate');
    return d12;
  }


  Future<void>getCouponList(bool isLoaderShow,  {required String status, required String search}) async{
    // isLoaderVisible = !isLoaderVisible;

    Map<String, String> queryParams = {
      HttpConstants.PARAMS_STATUS: status,
      HttpConstants.PARAMS_SEARCH: search,
    };

    if (isLoaderShow) {
      isLoaderVisible = !isLoaderVisible;
    }

    update();
    await getRequestWithRequest(GeneralPath.API_REST_VENDOR_COUPON, queryParams).then((response) {
      if (response.statusCode == 200) {
        getCouponListModel = GetCouponListModel.fromJson(json.decode(response.body));
        if (getCouponListModel.meta?.status == true) {
          print('status true: ${getCouponListModel.meta?.status}');
        }/*else{
          if (getCouponListModel.meta!.msg != "") {
            showToastMessage(getCouponListModel.meta?.msg ?? "");
          }
        }*/
        if (isLoaderShow) {
          isLoaderVisible = !isLoaderVisible;
        }
        update();
      } else {
        if (getCouponListModel.meta!.msg != "") {
          showToastMessage(getCouponListModel.meta?.msg ?? "");
          isLoaderVisible = false;
          update();
        }
      }
      update();
      return getCouponListModel;
    });
  }

  Future<void> callStatusUpdateAPI({required String couponId, required String status, }) async{
    // isStatusChanged = true;
    // update();
    final params = jsonEncode({
      HttpConstants.PARAMS_REST_COUPON_ID: couponId,
      HttpConstants.PARAMS_STATUS: status,
    });
    await putRequest(GeneralPath.API_REST_COUPON_STATUS, params).then((response) {
      if (response.statusCode == 200) {
        print('Response Data: ${response.body}');
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        metaModel = MetaModel.fromJson(mResponse);
        if (metaModel.meta?.status == true) {
          print('status : ${metaModel.meta?.status}');
          showToastMessage(metaModel.meta!.msg.toString());
          isStatusChanged = true;
          update();
          getCouponList(false, status: "", search: "");
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

  getCouponDetails(String couponId)  {
     getRequest(GeneralPath.API_REST_COUPON_DETAILS + couponId,).then((response) {
      if (response.statusCode == 200) {
        getCouponDetailsModel = GetCouponDetailsModel.fromJson(json.decode(response.body));
        if (getCouponDetailsModel.meta?.status == true) {
          print('status true: ${getCouponDetailsModel.meta?.status}');
          print('Response Coupon Data: ${getCouponDetailsModel.data}');

          couponType = getSelectedCouponType(getCouponDetailsModel.data?.couponType ?? "",);
          print('couponType: $couponType');
          parseTimeIssueDate(getCouponDetailsModel.data?.issueDate?? 0);
          parseTimeExpireDate(getCouponDetailsModel.data?.expiryDate?? 0);
          parseTimeCreatedDate(getCouponDetailsModel.data?.createdAt?? 0);
        }else{
          if (getCouponDetailsModel.meta!.msg != "") {
            showToastMessage(getCouponDetailsModel.meta?.msg ?? "");
          }
        }

      } else {
        if (getCouponDetailsModel.meta!.msg != "") {
          showToastMessage(getCouponDetailsModel.meta?.msg ?? "");
        }
      }
      isLoaderDetailsVisible = !isLoaderDetailsVisible;
      update();
      // update();
    });
  }

}
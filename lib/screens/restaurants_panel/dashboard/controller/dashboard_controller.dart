import 'dart:convert';
import 'package:get/get.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../routes/general_path.dart';
import '../model/vendor_dashboard_model.dart';

class DashboardController extends GetxController{
  VendorDashboardModel vendorDashboardModel = VendorDashboardModel();
  bool isLoaderVisible = false;

  callGetDashboard() {
    isLoaderVisible= !isLoaderVisible;
    update();

    getRequest(GeneralPath.API_REST_DASHBOARD).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);

        vendorDashboardModel = VendorDashboardModel.fromJson(mResponse);
        if (vendorDashboardModel.meta?.status == true) {
          print('status true: ${vendorDashboardModel.meta?.status}');
          print('Response Data: ${vendorDashboardModel.data}');
        }else{
          showToastMessage(vendorDashboardModel.meta?.msg ?? "");
          isLoaderVisible = false;
          update();
        }
        isLoaderVisible= !isLoaderVisible;
        update();
      }else if(response.statusCode == 401 ||response.statusCode == 440 ){
        return tokenExpire();
      } else {
        showToastMessage(vendorDashboardModel.meta?.msg ?? "");
        isLoaderVisible = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
    });
  }
}
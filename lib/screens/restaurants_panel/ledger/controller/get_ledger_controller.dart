import 'dart:convert';

import 'package:get/get.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../routes/general_path.dart';
import '../model/get_commission_model.dart.dart';
import '../model/get_ledger_model.dart.dart';

class GetLedgerController extends GetxController{
  GetLedgerModel getLedgerModel = GetLedgerModel();
  GetCommissionModel getCommissionModel = GetCommissionModel();
  bool isLoaderVisible = false;

  callGetLedgerAPI() {
    isLoaderVisible = !isLoaderVisible;
    update();

    getRequest(GeneralPath.API_REST_LEDGER).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);

        getLedgerModel = GetLedgerModel.fromJson(mResponse);
        if (getLedgerModel.meta?.status == true) {
          print('status true: ${getLedgerModel.meta?.status}');
        }
        isLoaderVisible = !isLoaderVisible;
        update();
      } else {
        showToastMessage(getLedgerModel.meta?.msg?? "");
        isLoaderVisible = false;
        throw Exception('Failed to load data.');
      }
      update();
    });
  }

  // API_REST_COMMISSION
  Future<void> callGetCommissionApi()async {
    await getRequest(GeneralPath.API_REST_COMMISSION).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);

        getCommissionModel = GetCommissionModel.fromJson(mResponse);
        if (getCommissionModel.meta?.status == true) {
          print('status true: ${getCommissionModel.meta?.status}');
        }else{
          showToastMessage(getCommissionModel.meta?.msg?? "");
        }
      } else {
        showToastMessage(getCommissionModel.meta?.msg?? "");
        throw Exception('Failed to load data.');
      }
      update();
      return getCommissionModel;
    });
  }

}

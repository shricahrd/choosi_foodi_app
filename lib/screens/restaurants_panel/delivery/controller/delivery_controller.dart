import 'dart:convert';
import 'package:get/get.dart';
import '../../../../core/http_utils/http_constants.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../../../../core/http_utils/http_post_util.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../routes/general_path.dart';
import '../../slots/model/meta_model.dart.dart';
import '../model/get_delivery_charge_model.dart';

class DeliveryController extends GetxController{
  MetaModel metaModel = MetaModel();
  bool isDelivered = false;
  bool isLoaderVisible = false;
  GetDeliveryChargeModel getDeliveryChargeModel = GetDeliveryChargeModel();

  Future<void> callGetContactInfoAPI() async {
    isLoaderVisible = !isLoaderVisible;
    update();

    await getRequest(GeneralPath.API_REST_GET_DELIVERY_CHARGE).then((response) {

      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        getDeliveryChargeModel = GetDeliveryChargeModel.fromJson(mResponse);
        if (getDeliveryChargeModel.meta?.status == true) {
          print('status true: ${getDeliveryChargeModel.meta?.status}');
          print('Response contact Data: ${getDeliveryChargeModel.data}');
        }
        isLoaderVisible = false;
        update();
      } else {
        isLoaderVisible = false;
        update();
        showToastMessage(getDeliveryChargeModel.meta?.msg.toString() ?? "");
        throw Exception('Failed to load data.');
      }
      return getDeliveryChargeModel;
    });
  }

  Future<void> addDeliveryApi({required int delCharge, required int minOrderVal,}) async{

    final params = jsonEncode({
      HttpConstants.PARAMS_REST_DELIVERY_CHARGE : delCharge,
      HttpConstants.PARAMS_REST_MIN_ORDER_VAL : minOrderVal,
    });
    // isDelivered = !isDelivered;
    // update();

    await postRequest(GeneralPath.API_REST_ADD_DELIVERY_CHARGE, params).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        metaModel = MetaModel.fromJson(mResponse);
        if (metaModel.meta?.status == true) {
          showToastMessage(metaModel.meta?.msg ?? "");
          print('status in Controller: ${metaModel.meta?.status}');
        }else{
          showToastMessage(metaModel.meta?.msg ?? "");
        }
        // isDelivered = !isDelivered;
        // update();
      } else {
        showToastMessage(metaModel.meta?.msg ?? "");
        isDelivered = false;
        update();
      }
      update();
      return metaModel;
    });
  }

}
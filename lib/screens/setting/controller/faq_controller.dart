import 'dart:convert';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../core/http_utils/http_get_util.dart';
import '../models/faq_list_model.dart';

class FAQController extends GetxController {
  bool isLoaderVisible = true;
  FaqListModel faqListModel = FaqListModel();

  @override
  void onInit() {
    isLoaderVisible = true;
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  callGetFaqListAPI() {
    getRequest(GeneralPath.API_FAQ_LIST).then((response) {

      if (response.statusCode == 200) {
        faqListModel = FaqListModel.fromJson(json.decode(response.body));
        if (faqListModel.meta?.status == true) {
          print('status true: ${faqListModel.meta?.status}');
          print('Response Data: ${faqListModel.data}');
          isLoaderVisible = false;
          update();
        }else{
          isLoaderVisible = false;
          update();
        }
      } else {
        showToastMessage(faqListModel.meta!.msg.toString());
        isLoaderVisible = true;
        update();
        throw Exception('Failed to load data.');
      }
      update();
    });
  }
}

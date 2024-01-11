import 'dart:convert';

import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:choosifoodi/screens/contact_us/model/contact_us.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../core/http_utils/http_constants.dart';
import '../../../core/http_utils/http_get_util.dart';
import '../../../core/http_utils/http_post_util.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../model/contact_info_model.dart';

class ContactUsGetController extends GetxController {
  bool isLoaderVisible = true;
  bool isMessageSend = false;
  ContactInfoModel contactInfoModel = ContactInfoModel();


  @override
  void onInit() {
    isLoaderVisible = true;
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  callGetContactInfoAPI() {
    getRequest(GeneralPath.API_CONTACT_INFO).then((response) {

      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        
        contactInfoModel = ContactInfoModel.fromJson(mResponse);
        if (contactInfoModel.meta?.status == true) {
          print('status true: ${contactInfoModel.meta?.status}');
          print('Response contact Data: ${contactInfoModel.data}');
          isLoaderVisible = false;
          update();
        }
      } else {
        showToastMessage(contactInfoModel.meta!.msg.toString());
        isLoaderVisible = true;
        throw Exception('Failed to load data.');
      }
      update();
    });
  }

  Future<void>postContactUs(
      {required String name,
      required String email,
      required String mobile,
      required String message}) async{
    final params = jsonEncode({
      HttpConstants.PARAMS_NAME: name,
      HttpConstants.PARAMS_EMAIL: email,
      HttpConstants.PARAMS_MOBILE: mobile,
      HttpConstants.PARAMS_MESSAGE: message,
    });

    await postRequest(GeneralPath.API_CONTACT_US, params).then((response) {
      ContactUs userProfile = ContactUs.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        showToastMessage(msgSentTxt);
        isMessageSend = true;
        update();
      } else {
        showToastMessage(userProfile.meta!.msg!);
        isMessageSend = false;
        update();
      }
      update();
    });
  }
}

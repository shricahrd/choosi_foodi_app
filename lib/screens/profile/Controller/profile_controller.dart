import 'dart:convert';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../core/http_utils/http_get_util.dart';
import '../model/user_profile_model.dart';

class UserProfileGetController extends GetxController {
  bool isLoaderVisible = false;
  // String name = "";
  String mobileNumber = "";
  String email = "";
  String totalMenuOrder = "";
  String memberSince = "";
  String totalOrder = "";
  String profile = "";
  String fName = "";
  String lName = "";

  @override
  void onInit() {
    isLoaderVisible = false;
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String parseTimeIssueDate(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterShortMonth.format(date);
    return d12;
  }

  Future<void> getUserProfile() async{
    await getRequest(GeneralPath.API_PROFILE).then((response) {
      isLoaderVisible = true;
      UserProfileModel userProfile =
      UserProfileModel.fromJson(json.decode(response.body));
      if (response.statusCode == 200) {
        fName =  "${userProfile.data?.firstName ?? ""}";
        lName = "${userProfile.data?.lastName ?? ""}";
        mobileNumber = "${userProfile.data?.mobile ?? ""}";
        email = "${userProfile.data?.email}";
        totalMenuOrder = "${userProfile.data?.totalMenuOrder}";

        memberSince = parseTimeIssueDate(userProfile.data?.createdAt ?? 0 );
        debugPrint(memberSince);
       /* int ts = userProfile.data!.createdAt!;
        DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(ts);
        String datetime = tsdate.day.toString() + "/" + tsdate.month.toString() + "/" + tsdate.year.toString();
        debugPrint(datetime);
        memberSince = "$datetime";*/

        profile = userProfile.data?.profilePic ?? "";
        //totalOrder = (userProfile.data?.firstName != null) as String;
        isLoaderVisible = true;
        update();
      } else {
        if (userProfile.meta!.msg != "") {
          showToastMessage(userProfile.meta!.msg!);
          isLoaderVisible = false;
          update();
        }
      }
      update();
      return userProfile;
    });
  }
}

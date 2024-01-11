import 'dart:convert';
import 'dart:io';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/http_utils/http_post_util.dart';
import '../model/user_profile.dart';

class EditUserProfileGetController extends GetxController {
  bool isLoaderVisible = false;
  // String imagePath = "";
  late File imagefile;
  bool loadImage = false;
  UserProfile userProfileModel = UserProfile();
  final picker = ImagePicker();

 /* Future<void>updateUserProfile({required String mobile,required String email }) async{
      
      final params = jsonEncode({
        HttpConstants.PARAMS_EMAIL: email,
        HttpConstants.PARAMS_MOBILE: mobile
      });
      await putRequest(GeneralPath.API_UPDATE_PROFILE, params).then((response) {
        UserProfile userProfile =
        UserProfile.fromJson(json.decode(response.body));
        print("response.statusCode  ${response.statusCode}");
        print("response.body  ${response.body}");
        if (response.statusCode == 200) {
          showToastMessage(userProfile.meta!.msg!);
          isLoaderVisible = false;
          update();
        } else {
          if (userProfile.meta?.msg != "" || userProfile.meta?.msg != null) {
            showToastMessage(userProfile.meta!.msg!);
            isLoaderVisible = true;
            update();
          }
          print("userProfile.meta!.msg   ${userProfile.meta?.msg}");
        }
        update();
        return userProfile;
      });
  }

  // postRequestWithPic

  Future<void>updateUserProfilePic({required String imageKey,}) async{
    print('Imagekey: $imageKey');
      await postRequestWithPic(GeneralPath.API_UPDATE_PROFILE,imagefile, imageKey).then((response) {
        UserProfile userProfile =
        UserProfile.fromJson(json.decode(response.body));
        print("response.statusCode  ${response.statusCode}");
        print("response.body  ${response.body}");
        if (response.statusCode == 200) {
          update();
        } else {
          if (userProfile.meta?.msg != "" || userProfile.meta?.msg != null) {
            showToastMessage(userProfile.meta!.msg!);
            update();
          }
          print("userProfile.meta!.msg   ${userProfile.meta?.msg}");
        }
        update();
        return userProfile;
      });
  }*/

  Future<void> updateProfileApi({required final params, required String imageKey1 }) async{

    isLoaderVisible = !isLoaderVisible;
    update();

    if(loadImage == true){
      await postRequestWithOneImage(GeneralPath.API_UPDATE_PROFILE,params,imagefile,imageKey1).then((response) {
        UserProfile userProfile =
        UserProfile.fromJson(json.decode(response.body));
        print("response.statusCode  ${response.statusCode}");
        print("response.body  ${response.body}");
        if (response.statusCode == 200) {
          showToastMessage(userProfile.meta?.msg?? "");
          // isLoaderVisible = false;
          // update();
          isLoaderVisible = !isLoaderVisible;
          update();
        } else {
          if (userProfile.meta?.msg != "" || userProfile.meta?.msg != null) {
            showToastMessage(userProfile.meta?.msg?? "");
            isLoaderVisible = false;
            update();
          }
          print("userProfile.meta!.msg   ${userProfile.meta?.msg}");
        }
        update();
        return userProfileModel;
      });
    } else {
      await putRequest(GeneralPath.API_UPDATE_PROFILE, params).then((response)  {
        if (response.statusCode == 200) {
          print('Response Data: ${response.body}');
          Map<String, dynamic> mResponse =  jsonDecode(response.body);
          userProfileModel = UserProfile.fromJson(mResponse);
          if (userProfileModel.meta?.status == true) {
            print('status : ${userProfileModel.meta?.status}');
            showToastMessage(userProfileModel.meta?.msg ?? "");
            // isLoaderVisible = false;
            // update();
          }else{
            showToastMessage(userProfileModel.meta?.msg ?? "");
            // isLoaderVisible = false;
            // update();
          }
          isLoaderVisible = !isLoaderVisible;
          update();
        } else {
          showToastMessage(userProfileModel.meta?.msg ?? "");
          isLoaderVisible = false;
          update();
          throw Exception('Failed to load data.');
        }
        update();
        return userProfileModel;
      });
    }
  }

  /// Get from gallery
  getFromGallery() async {
    Get.back();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    if (pickedFile != null) {
      imagefile = File(pickedFile.path);
      debugPrint('imageFile: $imagefile');
      // imagePath = pickedFile.path;
      loadImage = true;
      debugPrint('imageFile: $loadImage');
      update();
    }
  }

  /// Get from Camera
  getFromCamera() async {
    Get.back();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 25,
    );
    if (pickedFile != null) {
      imagefile = File(pickedFile.path);
      debugPrint('imageFile: $imagefile');
      // imagePath = pickedFile.path;
      loadImage = true;
      debugPrint('imageFile: $loadImage');
      update();
    }
  }


}

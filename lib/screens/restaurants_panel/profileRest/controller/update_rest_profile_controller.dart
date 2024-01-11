import 'dart:convert';
import 'dart:io';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/http_utils/http_post_util.dart';
import '../model/update_rest_profile_model.dart';
import 'package:http/http.dart' as http;

class UpdateRestProfileController extends GetxController {
  bool isLoaderVisible = false;
  // String imagePath = "";
  final picker = ImagePicker();
  late File imagefile;
  // late File restImageFile;
  // bool loadRestImage = false;
  bool loadImage = false;
  // bool loadDoc = false;
  UpdateRestProfileModel updateRestProfileModel = UpdateRestProfileModel();
  // List docLists = [];
  // TextEditingController? _fileAttachController = TextEditingController();
  // int currentImageUploadIndex = -1;
  PlatformFile? platformFile;
  final plugin = DeviceInfoPlugin();
  final permissionCamera = Permission.camera;
  final permissionStorage = Permission.storage;

  @override
  void onInit() {
    isLoaderVisible = false;
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> updateProfileApi({required final params,required bool image, required String imageKey1, File? imageFile }) async{

    print('ImageFile: $imageFile');

    if(image){
      await postRequestWithOneImage(GeneralPath.API_VENDOR_EDIT_PROFILE,params,imageFile!,imageKey1).then((response) {
        UpdateRestProfileModel userProfile =
        UpdateRestProfileModel.fromJson(json.decode(response.body));
        print("response.statusCode  ${response.statusCode}");
        print("response.body  ${response.body}");
        if (response.statusCode == 200) {
          showToastMessage(userProfile.meta!.msg!);
          isLoaderVisible = true;
          update();
        } else {
          if (userProfile.meta?.msg != "" || userProfile.meta?.msg != null) {
            showToastMessage(userProfile.meta!.msg!);
            isLoaderVisible = false;
            update();
          }
          print("userProfile.meta!.msg   ${userProfile.meta?.msg}");
        }
        update();
        return updateRestProfileModel;
      });
    } else {
      await putRequest(GeneralPath.API_VENDOR_EDIT_PROFILE, params).then((response)  {
        if (response.statusCode == 200) {
          print('Response Data: ${response.body}');
          Map<String, dynamic> mResponse =  jsonDecode(response.body);
          updateRestProfileModel = UpdateRestProfileModel.fromJson(mResponse);
          if (updateRestProfileModel.meta?.status == true) {
            print('status : ${updateRestProfileModel.meta?.status}');
            showToastMessage(updateRestProfileModel.meta!.msg.toString());
            isLoaderVisible = true;
            update();
          }else{
            showToastMessage(updateRestProfileModel.meta!.msg.toString());
            isLoaderVisible = false;
            update();
          }
        } else {
          showToastMessage(updateRestProfileModel.meta!.msg.toString());
          isLoaderVisible = false;
          update();
          throw Exception('Failed to load data.');
        }
        update();
        // return isMenuUpdateed;
        return updateRestProfileModel;
      });
    }
  }

/*  Future<void> updateProfileImageApi({required String imageKey, required File imageFile }) async{
    print('In Controller');
      await postRequestWithOnlyImage(GeneralPath.API_VENDOR_EDIT_PROFILE,imageFile, imageKey).then((response) {
        UpdateRestProfileModel userProfile =
        UpdateRestProfileModel.fromJson(json.decode(response.body));
        print("response.statusCode  ${response.statusCode}");
        print("response.body  ${response.body}");
        if (response.statusCode == 200) {
          // showToastMessage(userProfile.meta!.msg!);
          isLoaderVisible = true;
          update();
        } else {
          if (userProfile.meta?.msg != "" || userProfile.meta?.msg != null) {
            showToastMessage(userProfile.meta!.msg!);
            isLoaderVisible = false;
            update();
          }
          print("userProfile.meta!.msg   ${userProfile.meta?.msg}");
        }
        update();
        return updateRestProfileModel;
      });
  }*/

  Future<void> updateProfileMultiImageApi({required final params,required bool image, required String imageKey1, required List<File> imageFile }) async{

    print('ImageFile: $imageFile');

    if(image){
      await postRequestWithMultipleDocument(GeneralPath.API_VENDOR_EDIT_PROFILE,params,imageFile,imageKey1, 'PUT').then((response) {
        UpdateRestProfileModel userProfile =
        UpdateRestProfileModel.fromJson(json.decode(response.body));
        print("response.statusCode  ${response.statusCode}");
        print("response.body  ${response.body}");
        if (response.statusCode == 200) {
          showToastMessage(userProfile.meta!.msg!);
          isLoaderVisible = true;
          update();
        } else {
          if (userProfile.meta?.msg != "" || userProfile.meta?.msg != null) {
            showToastMessage(userProfile.meta!.msg!);
            isLoaderVisible = false;
            update();
          }
          print("userProfile.meta!.msg   ${userProfile.meta?.msg}");
        }
        update();
        return updateRestProfileModel;
      });

    } else {
      await putRequest(GeneralPath.API_VENDOR_EDIT_PROFILE, params).then((response)  {
        if (response.statusCode == 200) {
          print('Response Data: ${response.body}');
          Map<String, dynamic> mResponse =  jsonDecode(response.body);
          updateRestProfileModel = UpdateRestProfileModel.fromJson(mResponse);
          if (updateRestProfileModel.meta?.status == true) {
            print('status : ${updateRestProfileModel.meta?.status}');
            showToastMessage(updateRestProfileModel.meta!.msg.toString());
            isLoaderVisible = true;
            update();
          }else{
            showToastMessage(updateRestProfileModel.meta!.msg.toString());
            isLoaderVisible = false;
            update();
          }
        } else {
          showToastMessage(updateRestProfileModel.meta!.msg.toString());
          isLoaderVisible = false;
          update();
          throw Exception('Failed to load data.');
        }
        update();
        // return isMenuUpdateed;
        return updateRestProfileModel;
      });
    }
  }

  Future<void> updateProfileMultiDocApi({required String imageKey, required List<File> imageFile }) async{
    print('In Controller');
    await postRequestWithMultiDoc(GeneralPath.API_VENDOR_EDIT_PROFILE,imageFile, imageKey).then((response) {
      UpdateRestProfileModel userProfile =
      UpdateRestProfileModel.fromJson(json.decode(response.body));
      print("response.statusCode  ${response.statusCode}");
      print("response.body  ${response.body}");
      if (response.statusCode == 200) {
        // showToastMessage(userProfile.meta!.msg!);
        isLoaderVisible = true;
        update();
      } else {
        if (userProfile.meta?.msg != "" || userProfile.meta?.msg != null) {
          showToastMessage(userProfile.meta!.msg!);
          isLoaderVisible = false;
          update();
        }
        print("userProfile.meta!.msg   ${userProfile.meta?.msg}");
      }
      update();
      return updateRestProfileModel;
    });
  }

  /*Future onAttachFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png',],
    );
    platformFile = result!.files.first;
    final kb = platformFile!.size / 1024;
    final mb = kb / 1024;
    final size = (mb >= 1)
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
    print('File size: $size');

    if (result != null) {
      platformFile = result.files.first;
      print("platformFile  ${platformFile.toString()}");
      var pickedPath = result.files.first.path;
      imagefile = File(pickedPath!);
      print("imagefile  $imagefile");
      loadImage = true;
      update();
    } else {
      loadImage = false;
      print('No image selected.');
    }
  }*/

  /// Get from gallery
  getFromGallery(BuildContext context) async {
    Get.back();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    if(pickedFile != null){
      final returnImage = await cropImageWidget(context ,pickedFile.path);
      debugPrint("returnImage value: ${returnImage?.path}");
      if (returnImage != null) {
        imagefile = File(returnImage.path);
        debugPrint('imageFile: $imagefile');
        // imagePath = pickedFile.path;
        loadImage = true;
        debugPrint('imageFile: $loadImage');
        update();
      }else{
        loadImage = false;
        print('No image selected.');
      }
    } else{
      loadImage = false;
      print('No image selected.');
    }
  }

  /// Get from Camera
  getFromCamera(BuildContext context) async {
    Get.back();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 25,
    );
    if(pickedFile != null){
      final returnImage = await cropImageWidget(context ,pickedFile.path);
      debugPrint("returnImage value: ${returnImage?.path}");
      if (returnImage != null) {
        imagefile = File(returnImage.path);
        debugPrint('imageFile: $imagefile');
        // imagePath = pickedFile.path;
        loadImage = true;
        debugPrint('imageFile: $loadImage');
        update();
      }else{
        loadImage = false;
        print('No image selected.');
      }
    } else{
      loadImage = false;
      print('No image selected.');
    }
  }

}

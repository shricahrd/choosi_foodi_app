import 'dart:convert';
import 'dart:io';
import 'package:choosifoodi/core/http_utils/http_post_util.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/http_utils/http_constants.dart';
import '../../profileRest/model/image_upload_model.dart';
import '../model/vendor_singup_model.dart.dart';

class RestaurantSignupController extends GetxController {
  bool isLoaderVisible = true;
  String imagePath = "";
  late File imagefile;
  bool loadImage = false;
  bool loadDoc = false;
  late File docFile;

  List<ImageUpload> customDocFile = [];
  // VendorRegisterationModel vendorRegisterModel = VendorRegisterationModel();
  VendorSignupModel vendorRegisterModel = VendorSignupModel();

  @override
  void onInit() {
    super.onInit();
  }

 /* Future onAttachFile() async {
    PlatformFile? platformFile;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png',],
    );
    platformFile = result!.files.first;
    final kb = platformFile.size / 1024;
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
  }
*/


 /* Future onAttachDocFile() async {
    PlatformFile? platformFile;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['jpg', 'png', 'pdf', 'doc'],
    );
    platformFile = result?.files.first;
    final kb = platformFile!.size / 1024;
    final mb = kb / 1024;
    final size  = (mb>=1)?'${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
    print('File size: $size');
    if (result != null) {
      var pickedPath = result.files.first.path;
      docFile = File(pickedPath!);
      print("docFile  ${docFile.toString()}");
      loadDoc = true;
      update();
    } else {
      loadDoc = false;
      print('No doc selected.');
    }
  }*/

  Future onAttachMultipleDocFile() async {
    print('Inside doc');
    PlatformFile? platformFile;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['jpg', 'png', 'pdf', 'doc'],
    );

    if (result != null) {
      print('Inside file not null');
      // docFile = File(pickedPath!);
      // docFile.add(File(pickedPath!));
      if (customDocFile.length < 5) {
        print('customDocFile Len : ${customDocFile.length}');
        for (int i = 0; i < customDocFile.length; i++) {
          platformFile = result.files[i];
          print('platformFile: $platformFile');
          final kb = platformFile.size / 1024;
          final mb = kb / 1024;
          final size = (mb >= 1) ? '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
          print('File size: $size');
          var pickedPath = result.files[i].path;
          print("pickedPath  ${pickedPath.toString()}");
          File file = File(pickedPath!);
          customDocFile.add(ImageUpload(
              file, pickedPath, true, size));
          print("docFile $i: ${customDocFile[i].localImageFile.toString()}");
        }
        // loadDoc = true;
        update();
      }  else {
        Fluttertoast.showToast(
            msg: "Maximum 5 image file is uploaded",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      loadDoc = false;
      print('No doc selected.');
    }
  }

  Future<void> updateSignupApi({required final email,required final name,required final password,required final mobile,required bool image, required String imagekey1, required String imagekey2, }) async{
    print('Inside Signup api');
    isLoaderVisible = !isLoaderVisible;
    update();
    Map<String, String> params = <String,String>{
      HttpConstants.PARAMS_EMAIL: email,
      HttpConstants.PARAMS_VENDORNAME: name,
      HttpConstants.PARAMS_PASSWORD: password,
      HttpConstants.PARAMS_MOBILE: mobile,
    };
    print('Params: $params');
    if(image){
      if(loadDoc == true) {
        await postRequestWithMultipleImage(
            apiURL: GeneralPath.API_VENDOR_REGISTER,
            jsonBody: params,
            imageKey: imagekey1,
            imageKey2: imagekey2,
            imagePath1: imagefile,
            filePath2: docFile).then((response) {
          if (response.statusCode == 200) {
          vendorRegisterModel = VendorSignupModel.fromJson(json.decode(response.body));
          print("response.statusCode  ${response.statusCode}");
          print("response.body  ${response.body}");
            showToastMessage(vendorRegisterModel.meta?.msg ?? "");
            isLoaderVisible = false;
            update();
          } else {
            if (vendorRegisterModel.meta?.msg != "" ||
                vendorRegisterModel.meta?.msg != null) {
              showToastMessage(vendorRegisterModel.meta?.msg ?? "");
              isLoaderVisible = true;
              update();
            }
            print("vendorRegisterModel.meta!.msg   ${vendorRegisterModel.meta
                ?.msg}");
          }
          update();
          return vendorRegisterModel;
        });
      }else{
        showToastMessage('Please Upload Legal Document');
        isLoaderVisible = true;
        update();
      }
    } else {
      final params = jsonEncode({
        HttpConstants.PARAMS_EMAIL: email,
        HttpConstants.PARAMS_VENDORNAME: name,
        HttpConstants.PARAMS_PASSWORD: password,
        HttpConstants.PARAMS_MOBILE: mobile,
      });
      await putRequest(GeneralPath.API_VENDOR_REGISTER, params).then((response)  {
        if (response.statusCode == 200) {
          print('Response Data: ${response.body}');
          Map<String, dynamic> mResponse =  jsonDecode(response.body);
          vendorRegisterModel = VendorSignupModel.fromJson(mResponse);
          if (vendorRegisterModel.meta?.status == true) {
            print('status : ${vendorRegisterModel.meta?.status}');
            showToastMessage(vendorRegisterModel.meta?.msg ?? "");
            isLoaderVisible = false;
            update();
          }else{
            showToastMessage(vendorRegisterModel.meta?.msg ?? "");
            isLoaderVisible = false;
            update();
          }
        } else {
          showToastMessage(vendorRegisterModel.meta?.msg ?? "");
          isLoaderVisible = true;
          update();
          throw Exception('Failed to load data.');
        }
        update();
        return vendorRegisterModel;
      });
    }
  }

}
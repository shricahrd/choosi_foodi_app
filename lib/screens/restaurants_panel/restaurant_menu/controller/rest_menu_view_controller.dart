import 'dart:convert';
import 'dart:io';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../core/http_utils/http_constants.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../../../../core/http_utils/http_post_util.dart';
import '../../../cart/model/delete_cart_model.dart';
import '../model/add_menu_model.dart';
import '../model/rest_menu_details_model.dart';
import '../model/rest_menu_view_model.dart';

class RestMenuViewController extends GetxController {
  bool isLoaderVisible = true;
  // late RestMenuViewModel restMenuViewModel = RestMenuViewModel();
  late RestMenuDetailsModel restMenuViewModel = RestMenuDetailsModel();

  String createdDate = "";
  bool isChecked = true;
  bool isMenuUpdated = false;
  bool isMenuAdded = false;
  TextEditingController dishNameController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController dishTypeController = new TextEditingController();
  TextEditingController foodTypeController = new TextEditingController();
  TextEditingController caloriesController = new TextEditingController();
  TextEditingController carbsController = new TextEditingController();
  TextEditingController fatController = new TextEditingController();
  TextEditingController proteinController = new TextEditingController();
  String dishVisibilityStart = "";
  String dishVisibilityEnd = "";
  String menuImage = "";
  DeleteCartModel deleteCartModel = DeleteCartModel();
  AddMenuModel addMenuModel = AddMenuModel();
  String imagePath = "";
  late File imagefile;
  bool loadImage = false;
  // String postfix = " Gm";
  PlatformFile? platformFile;
  RxBool isEditable = false.obs;

  @override
  void onInit() {
    isLoaderVisible = true;
    // getMenuDetailsApi();
    super.onInit();
  }

  statusUpdate(){
    isChecked = !isChecked;
    update();
  }

  @override
  void dispose() {
    isLoaderVisible = true;
    super.dispose();
  }

  getMenuDetailsApi(String menuId) {

    Map<String, String> queryParams = {
      HttpConstants.PARAMS_MENUID: menuId,
    };

    getRequestWithRequest(GeneralPath.API_REST_MENU_DETAILS, queryParams).then((response) {
      if (response.statusCode == 200) {
        restMenuViewModel = RestMenuDetailsModel.fromJson(json.decode(response.body));
        if (restMenuViewModel.meta?.status == true) {
          print('status true: ${restMenuViewModel.meta?.status}');
          print('Response Menu view Data: ${restMenuViewModel.data}');
          dishNameController.text = restMenuViewModel.data?.dishName.toString() ?? "";
          priceController.text = restMenuViewModel.data?.price.toString() ?? "";
          dishTypeController.text = restMenuViewModel.data?.dishType.toString() ?? "";
          foodTypeController.text = restMenuViewModel.data?.foodType.toString() ?? "";
          descriptionController.text = restMenuViewModel.data?.description.toString().replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ') ?? "";
          dishVisibilityStart = restMenuViewModel.data?.dishVisibilityStart ?? "";
          dishVisibilityEnd = restMenuViewModel.data?.dishVisibilityEnd ?? "";
          if(restMenuViewModel.data?.menuImg.isNotEmpty == true) {
            menuImage = restMenuViewModel.data?.menuImg.first ?? "";
          }

          caloriesController.text = restMenuViewModel.data?.calories.toString() ?? "";
          carbsController.text = (restMenuViewModel.data?.carbs.toString().replaceAll("gm", "") ?? "");
              // carbsController.text = restMenuViewModel.data!.carbs.toString().replaceAll("gm", "") + postfix;
          fatController.text = restMenuViewModel.data!.fat.toString().replaceAll("gm", "");
          proteinController.text = restMenuViewModel.data!.protein.toString().replaceAll("gm", "");

          isLoaderVisible = false;

          debugPrint('dishVisibilityStart ====>  : ${dishVisibilityStart}');
          print('Calories Controller : ${caloriesController.text}');
          update();
        }else{
          if (restMenuViewModel.meta!.msg != "") {
            showToastMessage(restMenuViewModel.meta?.msg ?? "");
            isLoaderVisible = false;
            update();
          }
        }
      } else {
        if (restMenuViewModel.meta!.msg != "") {
          showToastMessage(restMenuViewModel.meta?.msg ?? "");
          isLoaderVisible = true;
          update();
        }
      }
      update();
    });
  }

  Future<void> updateMenuApi(final params, {required bool isAdd}) async {
    isMenuUpdated = true;
    update();
    await putRequest(GeneralPath.API_REST_UPDATE_MENU, params).then((response)  {
      if (response.statusCode == 200) {
        print('Response Data: ${response.body}');
        Map<String, dynamic> mResponse =  jsonDecode(response.body);
        deleteCartModel = DeleteCartModel.fromJson(mResponse);
        if (deleteCartModel.meta?.status == true) {
          print('status : ${deleteCartModel.meta?.status}');
          if(isAdd == false) {
            showToastMessage(deleteCartModel.meta?.msg ?? "");
          }
          isMenuUpdated = true;
          update();
        }else{
          showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
          isMenuUpdated = false;
          update();
        }
      } else {
        showToastMessage(deleteCartModel.meta?.msg.toString() ?? "");
        isMenuUpdated = false;
        update();
        throw Exception('Failed to load data.');
      }
      update();
      // return isMenuUpdateed;
      return deleteCartModel;
    });
  }

  Future<void> updateImageMenuApi(String menuID, bool image, String imageKey, File? imageFile,
      {required bool isAdd}) async {

    print('ImageData: $imageFile');

    Map<String, String> params = <String,String>{
      HttpConstants.PARAMS_MENUID: menuID,
    };

    isMenuUpdated = true;
    update();
    if(image) {
      await postRequestWithOneImage(
          GeneralPath.API_REST_UPDATE_MENU, params, imageFile!, imageKey).then((response) {
        deleteCartModel =
            DeleteCartModel.fromJson(json.decode(response.body));
        print("response.statusCode  ${response.statusCode}");
        print("response.body  ${response.body}");
        if (response.statusCode == 200) {
          if(isAdd == false) {
            showToastMessage(deleteCartModel.meta?.msg ?? "");
          }
          if (deleteCartModel.meta?.status == true) {
            print('status : ${deleteCartModel.meta?.status}');
            if(isAdd == false) {
              showToastMessage(deleteCartModel.meta?.msg ?? "");
            }
            isMenuUpdated = true;
            update();
          } else {
            if(isAdd == false) {
              showToastMessage(deleteCartModel.meta?.msg ?? "");
            }
            isMenuUpdated = false;
            update();
          }
        } else {
          if (deleteCartModel.meta?.msg != "" ||
              deleteCartModel.meta?.msg != null) {
            showToastMessage(deleteCartModel.meta!.msg!);
            isMenuUpdated = false;
            update();
          }
          print("userProfile.meta!.msg   ${deleteCartModel.meta?.msg}");
        }
        update();
        return deleteCartModel;
      });
    }else{
      print('Please upload a photo first');
      isMenuUpdated = false;
      showToastMessage('Please upload a photo first');
    }
  }

  /*Future onAttechFile() async {
    var pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );

    if (pickedFile != null) {
      imagefile = File(pickedFile.path);
      print("imagefile  ${imagefile.toString()}");
      loadImage = true;
      update();
    } else {
      loadImage = false;
      update();
      print('No image selected.');
    }
  }*/

  Future onAttachFilePicker() async {
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
  }

  Future<void> addMenuApi({required String dishName, required String dishType, required String description,
     String? foodType, required String price, required String dishVisibilityStart, required String dishVisibilityEnd}) async{

    // final params = jsonEncode({
    //   HttpConstants.PARAMS_DISHNAME : dishName,
    //   HttpConstants.PARAMS_DISH_TYPE : dishType,
    //   HttpConstants.PARAMS_DESCIPTION : description,
    //   HttpConstants.PARAMS_FOODTYPE : foodType,
    //   HttpConstants.PARAMS_PRICE : price,
    //   HttpConstants.PARAMS_DISHVISIBLE_START : dishVisibilityStart,
    //   HttpConstants.PARAMS_DISHVISIBLE_END : dishVisibilityEnd,
    // });

    final params = {
      HttpConstants.PARAMS_DISHNAME : dishName,
      HttpConstants.PARAMS_DISH_TYPE : dishType,
      HttpConstants.PARAMS_DESCIPTION : description,
      HttpConstants.PARAMS_PRICE : price,
      HttpConstants.PARAMS_DISHVISIBLE_START : dishVisibilityStart,
      HttpConstants.PARAMS_DISHVISIBLE_END : dishVisibilityEnd,
    };

    if(foodType != "Select"){
      params[HttpConstants.PARAMS_FOODTYPE] = foodType.toString();
    }

    debugPrint('Params: ${jsonEncode(params)}');

    await postRequest(GeneralPath.API_REST_ADD_MENU, jsonEncode(params)).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        addMenuModel = AddMenuModel.fromJson(mResponse);
        if (addMenuModel.meta?.status == true) {
          // showToastMessage(addMenuModel.meta!.msg.toString());
          print('status in Controller: ${addMenuModel.meta?.status}');
          isMenuAdded = true;
        }else{
          showToastMessage(addMenuModel.meta?.msg ?? "");
          isMenuAdded = false;
        }
      } else {
        showToastMessage(addMenuModel.meta?.msg ?? "");
        isMenuAdded = false;
      }
      update();
      return addMenuModel;
    });
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/http_utils/http_constants.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../../../../core/http_utils/http_post_util.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../routes/general_path.dart';
import '../../slots/model/meta_model.dart.dart';
import '../model/category_details_model.dart';
import '../model/category_update_model.dart';

class AddEditCategoryController extends GetxController {
  late File imagefile;
  bool loadImage = false;
  bool isCategoryLoader = false;
  PlatformFile? platformFile;
  dynamic apiImage = "";
  TextEditingController categoryNameController = TextEditingController();
  MetaModel metaModel = MetaModel();
  CategoryDetailsModel categoryDetailsModel = CategoryDetailsModel();
  CategoryUpdateModel categoryUpdateModel = CategoryUpdateModel();
  dynamic createdDate;
  bool isDetailsLoaderVisible = false;

  String parseTimeCreated(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterShortMonth.format(date);
    createdDate = d12;
    print('createdDate: $createdDate');
    return d12;
  }

  // API_REST_CATEGORY
  Future<void> addCategoryApi(String categoryName) async {
    Map<String, String> params = {
      HttpConstants.PARAMS_REST_CATEGORYNAME: categoryName.toString(),
    };

    dynamic methodType = "POST";

    if (loadImage == true) {
      // print('ImageFile: $imagefile');
      print('loadImage: $loadImage');
      isCategoryLoader = !isCategoryLoader;
      update();
      await postRequestApiWithOneImage(
              GeneralPath.API_ADD_REST_CATEGORY,
              params,
              imagefile,
              HttpConstants.PARAMS_REST_CATEGORYIMG,
              methodType)
          .then((response) {
        metaModel = MetaModel.fromJson(json.decode(response.body));
        print("response.statusCode  ${response.statusCode}");
        print("response.body  ${response.body}");
        if (response.statusCode == 200) {
          showToastMessage(metaModel.meta?.msg ?? "");
          if (metaModel.meta?.status == true) {
            print('status : ${metaModel.meta?.status}');
            showToastMessage(metaModel.meta?.msg.toString() ?? "");
          } else {
            showToastMessage(metaModel.meta!.msg.toString());
          }
          isCategoryLoader = !isCategoryLoader;
          update();
        } else {
          showToastMessage(metaModel.meta?.msg ?? "");
          isCategoryLoader = false;
          update();
          print("userProfile.meta!.msg   ${metaModel.meta?.msg}");
        }
        update();
        return metaModel;
      });
    } else {
      showToastMessage('Please Upload Photo');
      isCategoryLoader = false;
      update();
    }
  }

  Future onAttachFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'png',
      ],
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

  Future<void> callGetCategoryDetailsAPI(String categoryId) async {
    await getRequest(GeneralPath.API_REST_CATEGORY_DETAILS + categoryId)
        .then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse = jsonDecode(response.body);
        categoryDetailsModel = CategoryDetailsModel.fromJson(mResponse);
        if (categoryDetailsModel.meta?.status == true) {
          print('status true: ${categoryDetailsModel.meta?.status}');
          print('Response Data: ${categoryDetailsModel.data}');

          categoryNameController.text =
              categoryDetailsModel.data?.categoryName ?? "";
          apiImage = categoryDetailsModel.data?.categoryImg ?? "";

          if (categoryDetailsModel.data?.createdAt == 0) {
            createdDate = "";
          } else {
            parseTimeCreated(int.parse(
                categoryDetailsModel.data?.createdAt.toString() ?? ""));
          }
        }
      } else {
        showToastMessage(categoryDetailsModel.meta!.msg.toString());
        throw Exception('Failed to load data.');
      }
      isDetailsLoaderVisible = !isDetailsLoaderVisible;
      update();
      return categoryDetailsModel;
    });
  }

//  API_UPDATE_CATEGORY
  Future<void> updateCategoryApi(String categoryId, bool isLoadImage) async {
    isCategoryLoader = !isCategoryLoader;
    update();
    print("isLoadImage  ${isLoadImage}");
    if (isLoadImage == true) {
      Map<String, String> params = <String, String>{
        HttpConstants.PARAMS_REST_CATEGORYID: categoryId,
        HttpConstants.PARAMS_REST_CATEGORYNAME: categoryNameController.text,
      };
      await postRequestWithOneImage(
        GeneralPath.API_UPDATE_CATEGORY,
        params,
        imagefile,
        HttpConstants.PARAMS_REST_CATEGORYIMG,
      ).then((response) {
        categoryUpdateModel =
            CategoryUpdateModel.fromJson(json.decode(response.body));
        print("response.statusCode  ${response.statusCode}");
        print("response.body  ${response.body}");
        if (response.statusCode == 200) {
          showToastMessage(categoryUpdateModel.meta?.msg ?? "");
          if (categoryUpdateModel.meta?.status == true) {
            print('status : ${categoryUpdateModel.meta?.status}');
            showToastMessage(categoryUpdateModel.meta?.msg ?? "");
          } else {
            showToastMessage(categoryUpdateModel.meta?.msg ?? "");
          }
          isCategoryLoader = !isCategoryLoader;
          update();
        } else {
          if (categoryUpdateModel.meta?.msg != "" ||
              categoryUpdateModel.meta?.msg != null) {
            showToastMessage(categoryUpdateModel.meta?.msg ?? "");
            isCategoryLoader = false;
            update();
          }
          print("userProfile.meta!.msg   ${categoryUpdateModel.meta?.msg}");
        }
        update();
        return categoryUpdateModel;
      });
    } else {
      print('apiImage: $apiImage');

      // final params1 = jsonEncode({
      //   HttpConstants.PARAMS_REST_CATEGORYID: categoryId,
      //   HttpConstants.PARAMS_REST_CATEGORYNAME: categoryNameController.text.toString(),
      //  // HttpConstants.PARAMS_REST_CATEGORYIMG: apiImage,
      // });

      var map = Map<String, String>();
      map[HttpConstants.PARAMS_REST_CATEGORYID] = categoryId;
      map[HttpConstants.PARAMS_REST_CATEGORYNAME] =
          categoryNameController.text.toString();
      //map[HttpConstants.PARAMS_REST_CATEGORYIMG] = apiImage;

      debugPrint("params params1 $map");
      await putRequestUrlwithFormData(GeneralPath.API_UPDATE_CATEGORY, map)
          .then((response) {
        if (response.statusCode == 200) {
          debugPrint('Response Data: ${response.body}');
          Map<String, dynamic> mResponse = jsonDecode(response.body);
          categoryUpdateModel = CategoryUpdateModel.fromJson(mResponse);
          if (categoryUpdateModel.meta?.status == true) {
            print('status : ${categoryUpdateModel.meta?.status}');
            showToastMessage(categoryUpdateModel.meta?.msg ?? "");
          } else {
            showToastMessage(categoryUpdateModel.meta?.msg ?? "");
          }
          isCategoryLoader = !isCategoryLoader;
          update();
        } else {
          showToastMessage(categoryUpdateModel.meta?.msg ?? "");
          isCategoryLoader = false;
          update();
          throw Exception('Failed to load data.');
        }
        update();
        return categoryUpdateModel;
      });
    }
  }
}

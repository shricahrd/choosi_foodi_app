import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/http_utils/http_constants.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../../../../core/http_utils/http_post_util.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../routes/general_path.dart';
import '../../slots/model/meta_model.dart.dart';
import '../model/get_coupon_details_model.dart';

class AddCouponController extends GetxController {
  MetaModel metaModel = MetaModel();
  GetCouponDetailsModel getCouponDetailsModel = GetCouponDetailsModel();
  bool isCouponLoader = false;
  late File imagefile;
  final picker = ImagePicker();
  bool loadImage = false;
  dynamic apiImage, couponID;
  TextEditingController couponNameCtrl = TextEditingController();
  TextEditingController totalNoCouponCtrl = TextEditingController();
  TextEditingController maxDiscountCtrl = TextEditingController();
  TextEditingController discountCtrl = TextEditingController();

  // TextEditingController showInAppCtrl = TextEditingController();
  TextEditingController minCartCtrl = TextEditingController();
  TextEditingController maxCartCtrl = TextEditingController();
  TextEditingController descCtrl = TextEditingController();
  TextEditingController useCountCtrl = TextEditingController();
  TextEditingController perUseCountCtrl = TextEditingController();
  String filterStartDate = "", filterExpireDate = "";
  var filterMiliIssueDate, filterMiliExpireDate;
  late bool isEditable = true;
  String? selectCouponType = select;
  String? selectCouponVal = "";
  String selectCouponForType = 'ALL';
  String showInApp = 'true';
  String? selectDiscountIn = select;
  late Map<String, String> params;
  ValueNotifier<bool> isRequiredLoader = ValueNotifier<bool>(false);
  final plugin = DeviceInfoPlugin();
  final permissionStorage = Permission.storage;

  /* List couponType = [
    select,
    'Static',
    'Static Cart',
    'Static Period',
    'Static Period Cart',
    'Offer',
    'Offer Cart',
    'Offer Period',
    'Offer Period Cart'
  ];*/

  List couponType = [
    select,
    static,
    staticWithCart,
    staticWithPeriodic,
    staticWithPeriodicCart,
    offer,
    offerWithCart,
    offerWithPeriodic,
    offerWithPeriodicCart,
  ];

/*  List couponForType = [
    select,
    "ALL",
    "NEW",
  ];*/

  List discountInType = [
    select,
    absolute,
    percentage,
  ];

  DateTime selectedIssueDate = DateTime.now();
  DateTime selectedExpireDate = DateTime.now();

  Future<void> selectIssueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedIssueDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedIssueDate) {
      selectedIssueDate = picked;
      filterStartDate = formatterMonth.format(selectedIssueDate);
      filterMiliIssueDate = selectedIssueDate.millisecondsSinceEpoch;
      print('filterMiliIssueDate: $filterMiliIssueDate');
      update();
    }
  }

  Future<void> selectExpireDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedExpireDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedExpireDate) {
      selectedExpireDate = picked;
      filterExpireDate = formatterMonth.format(selectedExpireDate);
      filterMiliExpireDate = selectedExpireDate.millisecondsSinceEpoch;
      print('filterMiliExpireDate: $filterMiliExpireDate');
      update();
    }
  }

  checkReqFields(){
    selectCouponForType = 'ALL';
    showInApp = 'true';
    maxDiscountCtrl.text = "1000";
    totalNoCouponCtrl.text = "100000";
    useCountCtrl.text = "100000";
    maxCartCtrl.text = "100000";

    debugPrint("controller check: $selectCouponType, loadImage: $loadImage, api image: $apiImage");
    debugPrint("couponNameCtrl: ${couponNameCtrl.text}, discountCtrl: ${discountCtrl.text}, maxDiscountCtrl: ${maxDiscountCtrl.text}, "
        "descCtrl: ${descCtrl.text} ");
    if(selectCouponType != select) {
      if(loadImage == true || apiImage != null) {
        if (selectDiscountIn != select) {
          if (couponNameCtrl.text.isNotEmpty &&
              discountCtrl.text.isNotEmpty &&
              maxDiscountCtrl.text.isNotEmpty &&
              descCtrl.text.isNotEmpty) {
            isRequiredLoader.value = true;
            return true;
          } else {
            showToastMessage(reqAllFieldMsg);
            isRequiredLoader.value = false;
            return false;
          }
        } else {
          showToastMessage(selDiscountMsg);
          isRequiredLoader.value = false;
          return false;
        }
      }else{
        showToastMessage(uploadPicMsg);
        isRequiredLoader.value = false;
        return false;
      }
    }else{
      showToastMessage(select_coupon_type);
      isRequiredLoader.value = false;
      return false;
    }
  }

  selectCouponList(String val, bool isEdit) {
    maxDiscountCtrl.text = "1000";
    totalNoCouponCtrl.text = "100000";
    useCountCtrl.text = "100000";
    maxCartCtrl.text = "100000";

    if (selectCouponType == static) {
      selectCouponVal = "STATIC";
      print('selectCouponVal: $selectCouponVal');
      params = <String, String>{
        HttpConstants.PARAMS_REST_COUPON_TYPE: selectCouponVal.toString(),
        HttpConstants.PARAMS_REST_COUPON_NAME: couponNameCtrl.text,
        HttpConstants.PARAMS_REST_DISCOUNT_IN: selectDiscountIn.toString(),
        HttpConstants.PARAMS_REST_DISCOUNT: discountCtrl.text,
        HttpConstants.PARAMS_REST_MAX_DISCOUNT: maxDiscountCtrl.text,
        HttpConstants.PARAMS_REST_DESC: descCtrl.text,
        HttpConstants.PARAMS_REST_SHOWINAPP: showInApp,
        HttpConstants.PARAMS_REST_COUPONFOR: selectCouponForType.toString(),
        HttpConstants.PARAMS_REST_USECOUNT: useCountCtrl.text,
        HttpConstants.PARAMS_REST_PERUSECOUNT: perUseCountCtrl.text,
      };
      if (isEdit == true) {
        params[HttpConstants.PARAMS_REST_COUPON_ID] = couponID;
        print('Params: $params');
        addCouponApi(params, true);
      } else {
        print('Params: $params');
        addCouponApi(params, false);
      }
      update();
    } else if (selectCouponType == staticWithCart) {
      selectCouponVal = "STATIC_CART";
      print('selectCouponVal: $selectCouponVal');
      params = <String, String>{
        HttpConstants.PARAMS_REST_COUPON_TYPE: selectCouponVal.toString(),
        HttpConstants.PARAMS_REST_COUPON_NAME: couponNameCtrl.text,
        HttpConstants.PARAMS_REST_DISCOUNT_IN: selectDiscountIn.toString(),
        HttpConstants.PARAMS_REST_DISCOUNT: discountCtrl.text,
        HttpConstants.PARAMS_REST_MAX_DISCOUNT: maxDiscountCtrl.text,
        HttpConstants.PARAMS_REST_DESC: descCtrl.text,
        HttpConstants.PARAMS_REST_SHOWINAPP: showInApp,
        HttpConstants.PARAMS_REST_COUPONFOR: selectCouponForType.toString(),
        HttpConstants.PARAMS_REST_USECOUNT: useCountCtrl.text,
        HttpConstants.PARAMS_REST_PERUSECOUNT: perUseCountCtrl.text,
        HttpConstants.PARAMS_REST_MIN_CART_AMT: minCartCtrl.text,
        HttpConstants.PARAMS_REST_MAX_CART_AMT: maxCartCtrl.text,
      };
      if (isEdit == true) {
        params[HttpConstants.PARAMS_REST_COUPON_ID] = couponID;
      }
      if (isEdit == true) {
        params[HttpConstants.PARAMS_REST_COUPON_ID] = couponID;
        print('Params: $params');
        addCouponApi(params, true);
      } else {
        print('Params: $params');
        addCouponApi(params, false);
      }
      update();
    } else if (selectCouponType == staticWithPeriodic) {
      selectCouponVal = "STATIC_PERIOD";
      print('selectCouponVal: $selectCouponVal');
      params = <String, String>{
        HttpConstants.PARAMS_REST_COUPON_TYPE: selectCouponVal.toString(),
        HttpConstants.PARAMS_REST_COUPON_NAME: couponNameCtrl.text,
        HttpConstants.PARAMS_REST_DISCOUNT_IN: selectDiscountIn.toString(),
        HttpConstants.PARAMS_REST_DISCOUNT: discountCtrl.text,
        HttpConstants.PARAMS_REST_MAX_DISCOUNT: maxDiscountCtrl.text,
        HttpConstants.PARAMS_REST_DESC: descCtrl.text,
        HttpConstants.PARAMS_REST_SHOWINAPP: showInApp,
        HttpConstants.PARAMS_REST_COUPONFOR: selectCouponForType.toString(),
        HttpConstants.PARAMS_REST_USECOUNT: useCountCtrl.text,
        HttpConstants.PARAMS_REST_PERUSECOUNT: perUseCountCtrl.text,
        HttpConstants.PARAMS_REST_ISSUE_DATE:
        filterMiliIssueDate.toString(),
        HttpConstants.PARAMS_REST_EXPIRY_DATE:
        filterMiliExpireDate.toString(),
      };
      if (isEdit == true) {
        params[HttpConstants.PARAMS_REST_COUPON_ID] = couponID;
      }
      if (isEdit == true) {
        params[HttpConstants.PARAMS_REST_COUPON_ID] = couponID;
        print('Params: $params');
        addCouponApi(params, true);
      } else {
        print('Params: $params');
        addCouponApi(params, false);
      }
      update();
    } else if (selectCouponType == staticWithPeriodicCart) {
      selectCouponVal = "STATIC_PERIOD_CART";
      print('selectCouponVal: $selectCouponVal');
      params = <String, String>{
        HttpConstants.PARAMS_REST_COUPON_TYPE: selectCouponVal.toString(),
        HttpConstants.PARAMS_REST_COUPON_NAME: couponNameCtrl.text,
        HttpConstants.PARAMS_REST_DISCOUNT_IN: selectDiscountIn.toString(),
        HttpConstants.PARAMS_REST_DISCOUNT: discountCtrl.text,
        HttpConstants.PARAMS_REST_MAX_DISCOUNT: maxDiscountCtrl.text,
        HttpConstants.PARAMS_REST_DESC: descCtrl.text,
        HttpConstants.PARAMS_REST_SHOWINAPP: showInApp,
        HttpConstants.PARAMS_REST_COUPONFOR: selectCouponForType.toString(),
        HttpConstants.PARAMS_REST_MIN_CART_AMT: minCartCtrl.text,
        HttpConstants.PARAMS_REST_MAX_CART_AMT: maxCartCtrl.text,
        HttpConstants.PARAMS_REST_USECOUNT: useCountCtrl.text,
        HttpConstants.PARAMS_REST_PERUSECOUNT: perUseCountCtrl.text,
        HttpConstants.PARAMS_REST_ISSUE_DATE:
        filterMiliIssueDate.toString(),
        HttpConstants.PARAMS_REST_EXPIRY_DATE:
        filterMiliExpireDate.toString(),
      };
      if (isEdit == true) {
        params[HttpConstants.PARAMS_REST_COUPON_ID] = couponID;
      }
      if (isEdit == true) {
        params[HttpConstants.PARAMS_REST_COUPON_ID] = couponID;
        print('Params: $params');
        addCouponApi(params, true);
      } else {
        print('Params: $params');
        addCouponApi(params, false);
      }
      update();
    } else if (selectCouponType == offer) {
      selectCouponVal = "OFFER";
      print('selectCouponVal: $selectCouponVal');
      params = <String, String>{
        HttpConstants.PARAMS_REST_COUPON_TYPE: selectCouponVal.toString(),
        HttpConstants.PARAMS_REST_COUPON_NAME: couponNameCtrl.text,
        HttpConstants.PARAMS_REST_DISCOUNT_IN: selectDiscountIn.toString(),
        HttpConstants.PARAMS_REST_DISCOUNT: discountCtrl.text,
        HttpConstants.PARAMS_REST_MAX_DISCOUNT: maxDiscountCtrl.text,
        HttpConstants.PARAMS_REST_DESC: descCtrl.text,
        HttpConstants.PARAMS_REST_SHOWINAPP: showInApp,
        HttpConstants.PARAMS_REST_COUPONFOR: selectCouponForType.toString(),
        HttpConstants.PARAMS_REST_TOTAL_COUPON: totalNoCouponCtrl.text,
      };
      if (isEdit == true) {
        params[HttpConstants.PARAMS_REST_COUPON_ID] = couponID;
      }
      print('Params: $params');
      if (isEdit == true) {
        params[HttpConstants.PARAMS_REST_COUPON_ID] = couponID;
        print('Params: $params');
        addCouponApi(params, true);
      } else {
        print('Params: $params');
        addCouponApi(params, false);
      }
      update();
    } else if (selectCouponType == offerWithCart) {
      selectCouponVal = "OFFER_CART";
      print('selectCouponVal: $selectCouponVal');
      params = <String, String>{
        HttpConstants.PARAMS_REST_COUPON_TYPE: selectCouponVal.toString(),
        HttpConstants.PARAMS_REST_COUPON_NAME: couponNameCtrl.text,
        HttpConstants.PARAMS_REST_DISCOUNT_IN: selectDiscountIn.toString(),
        HttpConstants.PARAMS_REST_DISCOUNT: discountCtrl.text,
        HttpConstants.PARAMS_REST_MAX_DISCOUNT: maxDiscountCtrl.text,
        HttpConstants.PARAMS_REST_DESC: descCtrl.text,
        HttpConstants.PARAMS_REST_SHOWINAPP: showInApp,
        HttpConstants.PARAMS_REST_COUPONFOR: selectCouponForType.toString(),
        HttpConstants.PARAMS_REST_TOTAL_COUPON: totalNoCouponCtrl.text,
        HttpConstants.PARAMS_REST_MIN_CART_AMT: minCartCtrl.text,
        HttpConstants.PARAMS_REST_MAX_CART_AMT: maxCartCtrl.text,
      };
      if (isEdit == true) {
        params[HttpConstants.PARAMS_REST_COUPON_ID] = couponID;
      }
      if (isEdit == true) {
        params[HttpConstants.PARAMS_REST_COUPON_ID] = couponID;
        print('Params: $params');
        addCouponApi(params, true);
      } else {
        print('Params: $params');
        addCouponApi(params, false);
      }
      update();
    } else if (selectCouponType == offerWithPeriodic) {
      selectCouponVal = "OFFER_PERIOD";
      print('selectCouponVal: $selectCouponVal');
      params = <String, String>{
        HttpConstants.PARAMS_REST_COUPON_TYPE: selectCouponVal.toString(),
        HttpConstants.PARAMS_REST_COUPON_NAME: couponNameCtrl.text,
        HttpConstants.PARAMS_REST_DISCOUNT_IN: selectDiscountIn.toString(),
        HttpConstants.PARAMS_REST_DISCOUNT: discountCtrl.text,
        HttpConstants.PARAMS_REST_MAX_DISCOUNT: maxDiscountCtrl.text,
        HttpConstants.PARAMS_REST_DESC: descCtrl.text,
        HttpConstants.PARAMS_REST_SHOWINAPP: showInApp,
        HttpConstants.PARAMS_REST_COUPONFOR: selectCouponForType.toString(),
        HttpConstants.PARAMS_REST_TOTAL_COUPON: totalNoCouponCtrl.text,
        HttpConstants.PARAMS_REST_ISSUE_DATE:
        filterMiliIssueDate.toString(),
        HttpConstants.PARAMS_REST_EXPIRY_DATE:
        filterMiliExpireDate.toString(),
      };
      if (isEdit == true) {
        params[HttpConstants.PARAMS_REST_COUPON_ID] = couponID;
      }
      if (isEdit == true) {
        params[HttpConstants.PARAMS_REST_COUPON_ID] = couponID;
        print('Params: $params');
        addCouponApi(params, true);
      } else {
        print('Params: $params');
        addCouponApi(params, false);
      }
      update();
    } else if (selectCouponType == offerWithPeriodicCart) {
      selectCouponVal = "OFFER_PERIOD_CART";
      print('selectCouponVal: $selectCouponVal');
      params = <String, String>{
        HttpConstants.PARAMS_REST_COUPON_TYPE: selectCouponVal.toString(),
        HttpConstants.PARAMS_REST_COUPON_NAME: couponNameCtrl.text,
        HttpConstants.PARAMS_REST_DISCOUNT_IN: selectDiscountIn.toString(),
        HttpConstants.PARAMS_REST_DISCOUNT: discountCtrl.text,
        HttpConstants.PARAMS_REST_MAX_DISCOUNT: maxDiscountCtrl.text,
        HttpConstants.PARAMS_REST_DESC: descCtrl.text,
        HttpConstants.PARAMS_REST_SHOWINAPP: showInApp,
        HttpConstants.PARAMS_REST_COUPONFOR: selectCouponForType.toString(),
        HttpConstants.PARAMS_REST_TOTAL_COUPON: totalNoCouponCtrl.text,
        HttpConstants.PARAMS_REST_MIN_CART_AMT: minCartCtrl.text,
        HttpConstants.PARAMS_REST_MAX_CART_AMT: maxCartCtrl.text,
        HttpConstants.PARAMS_REST_ISSUE_DATE:
        filterMiliIssueDate.toString(),
        HttpConstants.PARAMS_REST_EXPIRY_DATE:
        filterMiliExpireDate.toString(),
      };
      if (isEdit == true) {
        params[HttpConstants.PARAMS_REST_COUPON_ID] = couponID;
      }
      if (isEdit == true) {
        params[HttpConstants.PARAMS_REST_COUPON_ID] = couponID;
        print('Params: $params');
        addCouponApi(params, true);
      } else {
        print('Params: $params');
        addCouponApi(params, false);
      }
      update();
    }
  }

  getFromGallery(BuildContext context) async {
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
        checkReqFields();
        update();
      }else{
        loadImage = false;
        debugPrint('No image selected.');
      }
    } else{
      loadImage = false;
      debugPrint('No image selected.');
    }
  }

  // postRequestApiWithOneImage
  Future<void> addCouponApi(final params, bool isEdit) async {
    print('In addCouponApi');
    // print('ImageData: $imagefile');

    dynamic methodType = "POST";
    dynamic url = GeneralPath.API_REST_ADD_COUPON;
    if (isEdit == true) {
      methodType = "PUT";
      url = GeneralPath.API_REST_UPDATE_COUPON;
    } else {
      methodType = "POST";
      url = GeneralPath.API_REST_ADD_COUPON;
    }

    // print('ImageFile: $imagefile');
    print('loadImage: $loadImage');

    if (loadImage == false && isEdit == true && apiImage != "") {
      print('IsEdit');
      isCouponLoader = !isCouponLoader;
      update();

      final paramsFinal = jsonEncode(params);

      await putRequest(url, paramsFinal).then((response) {
        metaModel = MetaModel.fromJson(json.decode(response.body));
        print("response.statusCode  ${response.statusCode}");
        print("response.body  ${response.body}");
        if (response.statusCode == 200) {
          showToastMessage(metaModel.meta?.msg ?? "");
          if (metaModel.meta?.status == true) {
            print('status : ${metaModel.meta?.status}');
            showToastMessage(metaModel.meta?.msg.toString() ?? "");
            // isCouponLoader = true;
            // update();
          } else {
            showToastMessage(metaModel.meta!.msg.toString());
            // isCouponLoader = false;
            // update();
          }
          isCouponLoader = !isCouponLoader;
          update();
        } else {
          showToastMessage(metaModel.meta?.msg ?? "");
          isCouponLoader = false;
          update();
          print("userProfile.meta!.msg   ${metaModel.meta?.msg}");
        }
        update();
        return metaModel;
      });
    } else {
      isCouponLoader = !isCouponLoader;
      update();
      await postRequestApiWithOneImage(url, params, imagefile,
              HttpConstants.PARAMS_REST_COUPONIMG, methodType)
          .then((response) {
        metaModel = MetaModel.fromJson(json.decode(response.body));
        print("response.statusCode  ${response.statusCode}");
        print("response.body  ${response.body}");
        if (response.statusCode == 200) {
          showToastMessage(metaModel.meta?.msg ?? "");
          if (metaModel.meta?.status == true) {
            print('status : ${metaModel.meta?.status}');
            showToastMessage(metaModel.meta?.msg.toString() ?? "");

            // isCouponLoader = true;
            // update();
          } else {
            showToastMessage(metaModel.meta!.msg.toString());
            // isCouponLoader = false;
            // update();
          }
          isCouponLoader = !isCouponLoader;
          update();
        } else {
          showToastMessage(metaModel.meta?.msg ?? "");
          isCouponLoader = false;
          update();
          print("userProfile.meta!.msg   ${metaModel.meta?.msg}");
        }
        update();
        return metaModel;
      });
    }
  }

  String parseTimeIssueDate(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterMonth.format(date);
    filterStartDate = d12;
    print('filterStartDate: $filterStartDate');
    return d12;
  }

  String parseTimeExpireDate(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterMonth.format(date);
    filterExpireDate = d12;
    print('filterExpireDate: $filterExpireDate');
    return d12;
  }

/*
  getSelectedCouponType(String val){
    if(val == 'STATIC'){
      selectCouponType = 'Static';
    }else  if(val == 'STATIC_CART'){
      selectCouponType = 'Static Cart';
    }else  if(val == 'STATIC_PERIOD'){
      selectCouponType = 'Static Period';
    }else  if(val == 'STATIC_PERIOD_CART'){
      selectCouponType = 'Static Period Cart';
    }else  if(val == 'OFFER'){
      selectCouponType = 'Offer';
    }else  if(val == 'OFFER_CART'){
      selectCouponType = 'Offer Cart';
    }else  if(val == 'OFFER_PERIOD'){
      selectCouponType = 'Offer Period';
    }else if(val == 'OFFER_PERIOD_CART'){
      selectCouponType = 'Offer Period Cart';
    }
    update();
  }
*/

  getCouponDetails(String couponId) {
    // getShowInAppList.add(GetShowInAppModel(name: 'Yes', value: true));
    // getShowInAppList.add(GetShowInAppModel(name: 'No', value: false));
    getRequest(
      GeneralPath.API_REST_COUPON_DETAILS + couponId,
    ).then((response) {
      if (response.statusCode == 200) {
        getCouponDetailsModel =
            GetCouponDetailsModel.fromJson(json.decode(response.body));
        if (getCouponDetailsModel.meta?.status == true) {
          print('status true: ${getCouponDetailsModel.meta?.status}');
          print('Response Coupon Data: ${getCouponDetailsModel.data}');

          selectCouponType = getSelectedCouponType(
              getCouponDetailsModel.data?.couponType ?? "");
          selectCouponForType = getCouponDetailsModel.data?.couponFor ?? "";
          selectDiscountIn = getCouponDetailsModel.data?.discountIn;
          couponID = couponId;
          couponNameCtrl.text =
              getCouponDetailsModel.data?.couponName.toString() ?? '';
          discountCtrl.text =
              getCouponDetailsModel.data?.discount.toString() ?? '';
          maxDiscountCtrl.text =
              getCouponDetailsModel.data?.maxDiscount.toString() ?? '';
          maxCartCtrl.text =
              getCouponDetailsModel.data?.maxCartAmount.toString() ?? '';
          minCartCtrl.text =
              getCouponDetailsModel.data?.minCartAmount.toString() ?? '';
          descCtrl.text = getCouponDetailsModel.data?.description
                  .toString()
                  .replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ') ??
              "";
          useCountCtrl.text =
              getCouponDetailsModel.data?.useCount.toString() ?? '';
          perUseCountCtrl.text =
              getCouponDetailsModel.data?.perUserUseCount.toString() ?? '';
          totalNoCouponCtrl.text =
              getCouponDetailsModel.data?.totalCoupon.toString() ?? '';
          parseTimeIssueDate(getCouponDetailsModel.data?.issueDate ?? 0);
          parseTimeExpireDate(getCouponDetailsModel.data?.expiryDate ?? 0);
          apiImage = getCouponDetailsModel.data?.couponImg.toString() ?? '';
          print('apiImage: $apiImage');
          update();
        } else {
          if (getCouponDetailsModel.meta!.msg != "") {
            showToastMessage(getCouponDetailsModel.meta?.msg ?? "");
          }
        }
      } else {
        if (getCouponDetailsModel.meta!.msg != "") {
          showToastMessage(getCouponDetailsModel.meta?.msg ?? "");
        }
      }
      // update();
    });
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/routes/general_path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/http_utils/http_get_util.dart';
import '../../../../core/utils/app_color_utils.dart';
import '../../../../core/utils/app_preferences.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../model/category_model.dart';
import '../model/vendor_profile_model.dart';
import 'package:http/http.dart' as http;

class VendorProfileGetController extends GetxController {
  bool isLoaderVisible = false;
  bool isCategoryLoaded = false;
  late VendorProfileModel vendorProfileModel = VendorProfileModel();
  late CategoryModel categoryModel = CategoryModel();
  String createdDate = "";
  TextEditingController accHolderNameCtr = new TextEditingController();
  TextEditingController bankNameCtr = new TextEditingController();
  TextEditingController accNoCtr = new TextEditingController();
  TextEditingController branchNameCtr = new TextEditingController();
  TextEditingController routingNoCtr = new TextEditingController();
  TextEditingController ownerNameCtr = new TextEditingController();
  TextEditingController ownerNoCtr = new TextEditingController();
  TextEditingController ownerEmailCtr = new TextEditingController();
  TextEditingController restNameCtr = new TextEditingController();
  TextEditingController restAddressCtr = new TextEditingController();
  TextEditingController restNoCtr = new TextEditingController();
  TextEditingController restDeliveryTimeCtr = new TextEditingController();
  TextEditingController restManagerNoCtr = new TextEditingController();
  TextEditingController restManagerNameCtr = new TextEditingController();
  // TextEditingController restManagerEmailCtr = new TextEditingController();
  TextEditingController restEmailCtr = new TextEditingController();
  String openingTime = "";
  String closingTime = "";
  bool isPickup = true;
  bool isDelivery = true;
  final picker = ImagePicker();

  // late File restImageFile;
  List<File> restFileList = [];
  bool loadRestImage = false;
  PlatformFile? platformFile;

  ////Call Google location api
  late LocationPermission permission;
  late Position position;
  String  long = "", lat = "", cordinates = '';
  var uuid = Uuid();
  String _sessionToken = '123456';
  List<dynamic> placesList = [];
  bool servicestatus = false;
  bool haspermission = false;
  String alertMessage = "";
  Color alertColor = Color(0xFFFF9110);

  @override
  void onInit() {
    isLoaderVisible = false;
    super.onInit();
  }

  @override
  void dispose() {
    isLoaderVisible = false;
    super.dispose();
  }

  ///Google Api methods
  checkGps() async {
    print('Inside gps');
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if(servicestatus){
      print('service status ===> $servicestatus');
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ) {
        print('request permission');
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ) {
          print('Location permissions are denied');

        }else if(permission == LocationPermission.deniedForever ){
          print("Location permissions are permanently denied");
        }else{
          haspermission = true;
        }
      }else{
        haspermission = true;
      }

      if(haspermission){
        update();
        //refresh the UI
        getLocation();
      }else{
        update();
      }
    }else{
      showToastMessage('Please Allow Location Permission');
      permission = await Geolocator.requestPermission();
      print("GPS Service is not enabled, turn on GPS location");
    }
    update();
    return haspermission;
    //refresh the UI
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 23.0272782
    print(position.latitude); //Output: 72.5247305

    long = position.longitude.toString();
    lat = position.latitude.toString();
    latString = lat;
    longString = long;
    print('Set Lat: $lat');
    print('Set Long: $long');
    AppPreferences.setLat(lat);
    AppPreferences.setLong(long);
    cordinates = lat + "," + long;
    print('cordinates: $cordinates');
    update();
  }


  onChangePlace(){
    if(_sessionToken == ""){
      _sessionToken = uuid.v4();
      update();
    }

    getSuggesion(restAddressCtr.text);
  }

  void getSuggesion(String input) async{

    String request = '$baseURLGoogleSearch?input=$input&key=$kGoogleApiKey&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));

    print('Response: ${response.body.toString()}');
    if(response.statusCode == 200){
      placesList = jsonDecode(response.body.toString()) ['predictions'];
      update();
    }else{
      throw Exception('Failed to load data');
    }
  }


  String parseTimeStampReport(int value) {
    var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
    var d12 = formatterMonth.format(date);
    createdDate = d12;
    update();
    return d12;
  }

  checkNullSafety(){

    openingTime = vendorProfileModel.data?.restaurant?.timings?.openingTime ?? "";
    closingTime = vendorProfileModel.data?.restaurant?.timings?.closingTime ?? "";
    print('openingTime: $openingTime, closingTime: $closingTime ');
    isPickup = vendorProfileModel.data?.restaurant?.isPickup ?? false;
    isDelivery = vendorProfileModel.data?.restaurant?.isDelivery ?? false;
    print('isPickup: $isPickup, isDelivery: $isDelivery ');

    if(vendorProfileModel.data?.createdAt == 0){
      createdDate = "";
    }else {
      parseTimeStampReport(
          int.parse(vendorProfileModel.data?.createdAt.toString() ?? ""));
    }

      if(vendorProfileModel.data?.restaurant?.bankInformation?.holderName?.isNotEmpty == true) {
        if (vendorProfileModel.data?.restaurant?.bankInformation?.holderName == "false") {
          accHolderNameCtr.text = "";
        } else {
          accHolderNameCtr.text = vendorProfileModel.data?.restaurant?.bankInformation?.holderName.toString() ?? "";
        }
    }


      if(vendorProfileModel.data?.restaurant?.bankInformation?.bankName?.isNotEmpty == true) {
        if (vendorProfileModel.data?.restaurant?.bankInformation?.bankName == "false") {
          bankNameCtr.text = "";
        } else {
          bankNameCtr.text = vendorProfileModel.data?.restaurant?.bankInformation?.bankName.toString() ?? "";
        }
      }

      if(vendorProfileModel.data?.restaurant?.bankInformation?.accountNumber?.isNotEmpty == true) {
        if (vendorProfileModel.data?.restaurant?.bankInformation?.accountNumber == "false") {
          accNoCtr.text = "";
        } else {
          accNoCtr.text = vendorProfileModel.data?.restaurant?.bankInformation?.accountNumber.toString() ?? "";
        }
    }

      if(vendorProfileModel.data?.restaurant?.bankInformation?.branchName?.isNotEmpty == true) {
        if (vendorProfileModel.data?.restaurant?.bankInformation?.branchName == "false") {
          branchNameCtr.text = "";
        } else {
          branchNameCtr.text = vendorProfileModel.data?.restaurant?.bankInformation?.branchName.toString() ?? "";
        }
      }

    if(vendorProfileModel.data?.restaurant?.bankInformation?.routingNumber?.isNotEmpty == true) {
        if (vendorProfileModel.data?.restaurant?.bankInformation?.routingNumber == "false") {
          routingNoCtr.text = "";
        } else {
          routingNoCtr.text = vendorProfileModel.data?.restaurant?.bankInformation?.routingNumber.toString() ?? "";
        }
    }

    /*ownerNameCtr.text = vendorProfileModel.data?.vendorName.toString() ?? "";
    ownerNoCtr.text = vendorProfileModel.data?.mobile.toString() ?? "";
    ownerEmailCtr.text = vendorProfileModel.data?.email.toString() ?? "";*/

    if (vendorProfileModel.data?.vendorName?.isNotEmpty == true) {
        ownerNameCtr.text = vendorProfileModel.data?.vendorName.toString() ?? "";
        print('ownerName: ${restNameCtr.text}');
    }

    if(vendorProfileModel.data?.vendorName?.isNotEmpty == true) {
        restEmailCtr.text = vendorProfileModel.data?.restaurant?.email.toString() ?? "";
    }

      if (vendorProfileModel.data!.mobile?.isNotEmpty == true) {
        ownerNoCtr.text = vendorProfileModel.data?.mobile.toString() ?? "";
        print('owner Mobile: ${ownerNoCtr.text}');
      } else {
        ownerNoCtr.text = "";
      }

      if (vendorProfileModel.data!.email?.isNotEmpty == true) {
        ownerEmailCtr.text = vendorProfileModel.data?.email.toString() ?? "";
        print('owner email: ${ownerEmailCtr.text}');
      } else {
        ownerEmailCtr.text = "";
      }

      if(vendorProfileModel.data?.restaurant?.managerMobile?.isNotEmpty == true){
        restManagerNoCtr.text = vendorProfileModel.data?.restaurant?.managerMobile.toString() ?? "";
        print('restManagerNoCtr: ${restManagerNoCtr.text}');
      }else{
        restManagerNoCtr.text = "";
       }

      if(vendorProfileModel.data?.restaurant?.managerName?.isNotEmpty == true){
        restManagerNameCtr.text = vendorProfileModel.data?.restaurant?.managerName.toString() ?? "";
        print('restManagerNameCtr: ${restManagerNameCtr.text}');
      }else{
        restManagerNameCtr.text = "";
       }

     if(vendorProfileModel.data?.restaurant?.restaurantName?.isNotEmpty == true) {
        restNameCtr.text = vendorProfileModel.data?.restaurant?.restaurantName.toString() ?? "";
        print('RestaurantName: ${restNameCtr.text}');
      } else {
        restNameCtr.text = "";
      }

      if (vendorProfileModel.data?.restaurant?.restaurantAddress?.isNotEmpty == true) {
      restAddressCtr.text = vendorProfileModel.data?.restaurant?.restaurantAddress.toString() ?? "";
      }else{
        restAddressCtr.text = "";
      }

    if(vendorProfileModel.data?.restaurant?.deliveryTime != null){
      restDeliveryTimeCtr.text = vendorProfileModel.data!.restaurant!.deliveryTime.toString();
      }else{
      restDeliveryTimeCtr.text = "";
    }

    if(vendorProfileModel.data?.restaurant?.restaurantNumber != null){
      restNoCtr.text = vendorProfileModel.data?.restaurant?.restaurantNumber.toString() ?? "";
      }else{
      restNoCtr.text = "";
    }

    // restDeliveryTimeCtr.text = vendorProfileModel.data?.restaurant?.deliveryTime.toString() ?? "";
  }

  checkAlertMessageData(){
    alertMessage = "";
    if(vendorProfileModel.data?.restaurant?.isProfileComplete == true){
      alertColor = Color(GREEN);
      alertMessage = "Please complete your profile to start receiving the orders from the Customers.";
    }
    if(vendorProfileModel.data?.restaurant?.isProfileComplete == true && vendorProfileModel.data?.restaurant?.state =='APPROVED' && vendorProfileModel.data?.restaurant?.status =="ACTIVE"){
      alertColor = Color(GREEN);
      alertMessage = "Your profile has been activated and will be visible to the customers.";
    }
    if(vendorProfileModel.data?.restaurant?.isProfileComplete == true && vendorProfileModel.data?.restaurant?.state =='APPROVED' && vendorProfileModel.data?.restaurant?.status =="DEACTIVE" ){
      alertColor = Color(ORANGE);
      alertMessage = "Your profile has been approved but it is inactive.";
    }
    if(vendorProfileModel.data?.restaurant?.isProfileComplete == true  && vendorProfileModel.data?.restaurant?.state =='PENDING'){
      alertColor = Color(ORANGE);
      alertMessage = "Your profile in under review. Please wait till the profile is activated.";
    }
    if(vendorProfileModel.data?.restaurant?.isProfileComplete == true  && vendorProfileModel.data?.restaurant?.state =='REJECTED'){
      alertColor = Color(RED);
      alertMessage = "Your profile approval is rejected by the admin.";
    }
    /*else {
      alertColor = Color(ORANGE);
      alertMessage = "";
    }*/
    update();
  }

  getUserProfile() {
    getRequest(GeneralPath.API_VENDOR_PROFILE).then((response) {
      if (response.statusCode == 200) {
        vendorProfileModel = VendorProfileModel.fromJson(json.decode(response.body));
        if (vendorProfileModel.meta?.status == true) {
          debugPrint('status true: ${vendorProfileModel.meta?.status}');
          debugPrint('Response Profile Data: ${vendorProfileModel.data}');
          debugPrint('restaurant id: ${vendorProfileModel.data?.id}');
          checkNullSafety();
          checkAlertMessageData();
          isLoaderVisible = true;
          update();
        }else{
          if (vendorProfileModel.meta?.msg != "") {
            showToastMessage(vendorProfileModel.meta?.msg ?? "");
            isLoaderVisible = false;
            update();
          }
        }
      } else {
        if (vendorProfileModel.meta?.msg != "") {
          showToastMessage(vendorProfileModel.meta?.msg ?? "");
          isLoaderVisible = false;
          update();
        }
      }
      update();
    });
  }

   Future<void>getCategory() async{
    await getRequest(GeneralPath.API_REST_TREE).then((response) {
      if (response.statusCode == 200) {
        categoryModel = CategoryModel.fromJson(json.decode(response.body));
        if (categoryModel.meta?.status == true) {
          print('status true: ${categoryModel.meta?.status}');
          print('Response Profile Data: ${categoryModel.data}');
          isCategoryLoaded = true;
          update();
        }else{
          if (categoryModel.meta!.msg != "") {
            showToastMessage(categoryModel.meta!.msg!);
            isCategoryLoaded = false;
            update();
          }
        }
      } else {
        if (categoryModel.meta!.msg != "") {
          showToastMessage(categoryModel.meta!.msg!);
          isCategoryLoaded = false;
          update();
        }
      }
      update();
      return categoryModel;
    });
  }

  Future<void> onAttachMultipleRestaurantFile() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 25, maxHeight: 1000, maxWidth: 1000);
        List<XFile> xfilePick = pickedFile;

        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            restFileList.add(File(xfilePick[i].path));
          }

          loadRestImage = true;
          debugPrint('Selected images: $loadRestImage');
          update();
        } else {
          loadRestImage = false;
          debugPrint('No Image selected.');
        }
    // Process selectedImages as needed
  }

/*  Future onAttachMultipleRestaurantFile() async {
    List<PlatformFile> platformFile = [];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['jpg', 'png'],
    );

    if (result != null) {
      debugPrint('Result not null');
      platformFile = result.files;
      debugPrint('platformFile len: ${platformFile.length}');
      for(int i=0; i<platformFile.length; i++){
        final kb = platformFile[i].size / 1024;
        final mb = kb / 1024;
        final size  = (mb>=1)?'${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
        debugPrint('File size: $size');

        var pickedPath = result.files[i].path;
        restFileList.add(File(pickedPath!));
        update();
        debugPrint("restFileList Len ${restFileList.length}");
        debugPrint("restFileList path ${restFileList[i].path}");
      }
      loadRestImage = true;
      update();
    } else {
      loadRestImage = false;
      debugPrint('No Image selected.');
    }
  }*/


}

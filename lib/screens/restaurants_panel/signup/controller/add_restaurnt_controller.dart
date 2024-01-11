import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/http_utils/http_post_util.dart';
import '../../../../core/utils/app_color_utils.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_preferences.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../routes/general_path.dart';
import '../model/add_restaurant_model.dart.dart';
import 'package:http/http.dart' as http;
import '../model/vendor_singup_model.dart.dart';

class VendorAddRestaurantController extends GetxController {
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String  long = "", lat = "", cordinates = '';
  var uuid = Uuid();
  String _sessionToken = '123456';
  List<dynamic> placesList = [];
  AddRestaurantModel addRestaurantModel = AddRestaurantModel();
  bool isAddRestaurant = false;
  late File restImageFile = File('');
  List<File> restFileList = [];
  bool loadRestImage = false;
  PlatformFile? platformFile;
  TextEditingController ownerNameCtr = new TextEditingController();
  TextEditingController ownerNoCtr = new TextEditingController();
  TextEditingController restNameCtr = new TextEditingController();
  TextEditingController restAddressCtr = new TextEditingController();
  TextEditingController accHolderNameCtr = new TextEditingController();
  TextEditingController bankNameCtr = new TextEditingController();
  TextEditingController accNoCtr = new TextEditingController();
  TextEditingController branchNameCtr = new TextEditingController();
  TextEditingController routingNoCtr = new TextEditingController();
  TextEditingController restDeliveryTimeCtr = TextEditingController();
  TextEditingController restEmailCtr = TextEditingController();

  //owner tab
  TextEditingController ownerController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController cPwdController = new TextEditingController();
  final picker = ImagePicker();
  final permissionCamera = Permission.camera;
  final permissionStorage = Permission.storage;

  ///// For Owner info
  bool isLoaderVisible = false;
  String imagePath = "";
  late File imagefile;
  bool loadImage = false;
  bool loadDoc = false;
  bool loadMultiDoc = false;
  late File docFile;
  List<File> docFileList = [];
  VendorSignupModel vendorRegisterModel = VendorSignupModel();
  final plugin = DeviceInfoPlugin();

  /*Future onAttachFile() async {
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

  onAttachMultipleDocFile(bool isOwner) async {
    if (Platform.isAndroid) {
      final android = await plugin.androidInfo;
      var status = (android.version.sdkInt < 33
          ? await Permission.storage.status
          : PermissionStatus.granted);

      if (android.version.sdkInt < 33) {
        status = await permissionStorage.request();
      }

      if (status.isGranted) {
        if(isOwner == true) {
          openMultipleDocument();
        }else{
          onAttachMultipleRestaurantFile();
        }
      } else if (status.isPermanentlyDenied) {
        showToastMessage(cameraPermissionTxt, bgColor: Color(RED));
        Future.delayed(const Duration(
            seconds: 3), () async {
          await openAppSettings();
        });
      } else {
        showToastMessage(cameraPermissionTxt, bgColor: Color(RED));
        // Permission denied
        debugPrint('Camera permission denied.');
      }
    }else{
      if(isOwner == true) {
        openMultipleDocument();
      }else{
        onAttachMultipleRestaurantFile();
      }
    }
  }

  openMultipleDocument() async {
    List<PlatformFile> platformFile = [];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['jpg', 'png', 'pdf', 'doc'],
    );

    if (result != null) {
      print('Result not null');
      platformFile = result.files;
      print('platformFile len: ${platformFile.length}');
      for(int i=0; i<platformFile.length; i++){
        // platformFile.add(result.files[i]);
        final kb = platformFile[i].size / 1024;
        final mb = kb / 1024;
        final size  = (mb>=1)?'${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
        print('File size: $size');

        var pickedPath = result.files[i].path;
        docFileList.add(File(pickedPath!));
        update();
        print("docFile Len ${docFileList.length}");
        print("docFile path ${docFileList[i].path}");
      }
      loadMultiDoc = true;
      update();
    } else {
      loadMultiDoc = false;
      print('No doc selected.');
    }
  }

  Future onAttachMultipleRestaurantFile() async {

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

   /*
    List<PlatformFile> platformFile = [];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['jpg', 'png'],
    );

    if (result != null) {
      print('Result not null');
      platformFile = result.files;
      print('platformFile len: ${platformFile.length}');
      for(int i=0; i<platformFile.length; i++){
        final kb = platformFile[i].size / 1024;
        final mb = kb / 1024;
        final size  = (mb>=1)?'${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} KB';
        print('File size: $size');

        var pickedPath = result.files[i].path;
        restFileList.add(File(pickedPath!));
        update();
        print("restFileList Len ${restFileList.length}");
        print("restFileList path ${restFileList[i].path}");
      }
      loadRestImage = true;
      update();
    } else {
      loadRestImage = false;
      print('No Image selected.');
    }*/
  }

  Future<void> updateSignupApi({required final email,required final name,required final password,required final mobile,required bool image, required String imagekey1, required String imagekey2, }) async{
    print('Inside Signup api');
    isLoaderVisible = !isLoaderVisible;
    debugPrint('isLoaderVisible: $isLoaderVisible');
    update();
  /*  Map<String, String> params = <String,String>{
      HttpConstants.PARAMS_EMAIL: email,
      HttpConstants.PARAMS_VENDORNAME: name,
      HttpConstants.PARAMS_PASSWORD: password,
      HttpConstants.PARAMS_MOBILE: mobile,
    };
    print('Params: $params');*/
      if(loadMultiDoc == true) {
        await postRequestWithMultipleDocuments(
            apiURL: GeneralPath.API_VENDOR_REGISTER,
            email: email,
            mobile: mobile,
            name: name,
            password: password,
            imageKey: imagekey1,
            imageKey2: imagekey2,
            imagePath1: imagefile,
            filePath2: docFileList).then((response) {
          if (response.statusCode == 200) {
            vendorRegisterModel = VendorSignupModel.fromJson(json.decode(response.body));
            print("response.statusCode  ${response.statusCode}");
            print("response.body  ${response.body}");
            showToastMessage(vendorRegisterModel.meta?.msg ?? "");
            // isLoaderVisible = false;
            // update();
          } else {
            if (vendorRegisterModel.meta?.msg != "" ||
                vendorRegisterModel.meta?.msg != null) {
              showToastMessage(vendorRegisterModel.meta?.msg ?? "");
              // isLoaderVisible = true;
              // update();
              print("vendorRegisterModel.meta!.msg   ${vendorRegisterModel.meta?.msg}");
            }
          }
          isLoaderVisible = !isLoaderVisible;
          debugPrint('isLoaderVisible: $isLoaderVisible');
          update();
          return vendorRegisterModel;
        });
      }else{
        showToastMessage('Please Upload Legal Document');
        isLoaderVisible = false;
        debugPrint('isLoaderVisible: $isLoaderVisible');
        update();
      }
  }

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
      loadRestImage = true;
      var pickedPath = result.files.first.path;
      restImageFile = File(pickedPath!);
      print("file  $restImageFile");
      update();
    } else {
      loadRestImage = false;
      print('No image selected.');
    }
  }


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

  Future<void> updateAddRestaurantApi({required final params, required String imageKey1, File? imageFile }) async{

      await postRequestWithOneImageWithoutToken(GeneralPath.API_REST_ADD_RESTAURANTDETAILS,params,imageFile!,imageKey1).then((response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> mResponse =  jsonDecode(response.body);
          addRestaurantModel = AddRestaurantModel.fromJson(mResponse);
          print("response.statusCode  ${response.statusCode}");
          print("response.body  ${response.body}");
          if (addRestaurantModel.meta?.status == true) {
            print('status : ${addRestaurantModel.meta?.status}');
            showToastMessage(addRestaurantModel.meta?.msg ?? "");
          }else{
            showToastMessage(addRestaurantModel.meta?.msg ?? "");
          }
        } else {
          showToastMessage(addRestaurantModel.meta?.msg ?? "");
          isAddRestaurant = false;
          update();
          print("addRestaurantModel.meta!.msg   ${addRestaurantModel.meta?.msg}");
        }
        update();
        return addRestaurantModel;
      });
  }

  Future<void> addRestaurantApi({required final params, required String imageKey1, required List<File> imageFile }) async{

    await postRequestWithMultipleRestImage(GeneralPath.API_REST_ADD_RESTAURANTDETAILS,params,imageFile,imageKey1).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mResponse =  jsonDecode(response.body);
        addRestaurantModel = AddRestaurantModel.fromJson(mResponse);
        print("response.statusCode  ${response.statusCode}");
        print("response.body  ${response.body}");
        if (addRestaurantModel.meta?.status == true) {
          print('status : ${addRestaurantModel.meta?.status}');
          showToastMessage(addRestaurantModel.meta?.msg ?? "");
        }else{
          showToastMessage(addRestaurantModel.meta?.msg ?? "");
        }
      } else {
        showToastMessage(addRestaurantModel.meta?.msg ?? "");
        isAddRestaurant = false;
        update();
        print("addRestaurantModel.meta!.msg   ${addRestaurantModel.meta?.msg}");
      }
      update();
      return addRestaurantModel;
    });
  }
}
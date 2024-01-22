import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../routes/all_routes.dart';
import 'app_preferences.dart';
import 'app_strings_constants.dart';

const IsCustomerApp = false;

/*
* Show Toast Message
* */
void showToastMessage(String toastMsg, {ToastGravity toastGravity = ToastGravity.BOTTOM, Color bgColor = Colors.white} ) {
  Fluttertoast.showToast(
      msg: toastMsg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: toastGravity,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor,
      textColor: Colors.black,
      fontSize: 16.0);
}

void showSnackBar(String msg){
  Get.snackbar(
    appTitle,
    msg,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.orange,
    borderRadius: 20,
    margin: EdgeInsets.all(15),
    colorText: Colors.white,
    duration: Duration(seconds: 4),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}

/*
* Custom App loader
* */
Widget appLoader({required Widget widget, required bool isLoading}) {
  return Stack(
    children: [
      widget,
      isLoading
          ? Positioned(
              left: 1,
              right: 1,
              top: 1,
              bottom: 1,
              child: Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: Color(ORANGE),
                ),
              ),
            )
          : Container(),
    ],
  );
}

var formatter = new DateFormat('dd-MM-yyyy');
var revFormatter = new DateFormat('yyyy-MM-dd');
var formatterMonth = new DateFormat('MMMM dd, yyyy');
var formatterMonthWithTime = new DateFormat('MMMM dd, yyyy, h:mma');
var formatterShortMonth = new DateFormat('MMM d, yyyy');
var formatterShortMonthWithTime = new DateFormat('MMM d, yyyy, h:mma');
var formatterShortMonthTime = new DateFormat('MMM d, h:mma');
var formatterMDY = new DateFormat('MM/dd/yyyy');
var formatterDMY = new DateFormat('dd-MM-yy');
var formatterDDMMYY = new DateFormat('dd/MM/yy');
var formatterHM = new DateFormat('hh:mm a');
var formatterDate = new DateFormat('dd MMMM, yyyy');
var formatterDMonth = new DateFormat('dd, MMMM yyyy');
var formatterDMYHM = new DateFormat('EEEE, MMM d, h:mma');
var formatterDateTime = new DateFormat('dd-MM-yy, h:mma');
// var time24Hours = new DateFormat("HH:mm:ss");
var time24Hours = new DateFormat("h:mma");
var formatterDay = new DateFormat('EEEE');

bool isValidTimeRange(String start, String end,) {

  TimeOfDay startTime = TimeOfDay(hour:int.parse(start.split(":")[0]),minute: int.parse(start.split(":")[1]));
  TimeOfDay endTime = TimeOfDay(hour:int.parse(end.split(":")[0]),minute: int.parse(end.split(":")[1]));
  TimeOfDay now = TimeOfDay.now();
  print("now: $now, startTime: $startTime , endTime :- $endTime");

  // if((now.hour >= startTime.hour && now.hour <= endTime.hour)){
  // if((now.hour >= startTime.hour && now.minute >= startTime.minute) && (now.hour <= endTime.hour && now.minute <= endTime.minute) ){
  if(((now.hour > startTime.hour) || (now.hour == startTime.hour && now.minute >= startTime.minute))
      && ((now.hour < endTime.hour) ||  (now.hour == endTime.hour && now.minute <= endTime.minute))){
    print("inside true in first if");
    return true;
  }else{
    print("inside else");
    if(now.hour <= startTime.hour){
      print("inside second if");
      return true;
    }else{
      print("else inside else false");
      return false;
    }
  }
}

bool isRestaurantOpen(String start, String end) {

  TimeOfDay startTime = TimeOfDay(hour:int.parse(start.split(":")[0]),minute: int.parse(start.split(":")[1]));
  TimeOfDay endTime = TimeOfDay(hour:int.parse(end.split(":")[0]),minute: int.parse(end.split(":")[1]));
  TimeOfDay now = TimeOfDay.now();

  if(((now.hour > startTime.hour) || (now.hour == startTime.hour && now.minute >= startTime.minute))
      && ((now.hour < endTime.hour) || (now.hour == endTime.hour && now.minute <= endTime.minute))){
    return true;
  }else{
    return false;
  }
}

tokenExpire(){
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth.instance.signOut();
  _googleSignIn.signOut();
  AppPreferences.clearPreferenceData();
  Get.offAllNamed(AllRoutes.start);
}

signOut() {
  FirebaseAuth.instance.signOut();
  AppPreferences.clearPreferenceData();
  Get.offAllNamed(AllRoutes.start);
}

/*getSelectedCouponType(String val){
  if(val == 'STATIC'){
    return 'Static';
  }else  if(val == 'STATIC_CART'){
    return 'Static Cart';
  }else  if(val == 'STATIC_PERIOD'){
    return'Static Period';
  }else  if(val == 'STATIC_PERIOD_CART'){
    return 'Static Period Cart';
  }else  if(val == 'OFFER'){
    return 'Offer';
  }else  if(val == 'OFFER_CART'){
    return 'Offer Cart';
  }else  if(val == 'OFFER_PERIOD'){
    return 'Offer Period';
  }else if(val == 'OFFER_PERIOD_CART'){
    return 'Offer Period Cart';
  }
}*/

getSelectedCouponType(String val){
  if(val == 'STATIC'){
    return static;
  }else  if(val == 'STATIC_CART'){
    return staticWithCart;
  }else  if(val == 'STATIC_PERIOD'){
    return staticWithPeriodic;
  }else  if(val == 'STATIC_PERIOD_CART'){
    return staticWithPeriodicCart;
  }else  if(val == 'OFFER'){
    return offer;
  }else  if(val == 'OFFER_CART'){
    return offerWithCart;
  }else  if(val == 'OFFER_PERIOD'){
    return offerWithPeriodic;
  }else if(val == 'OFFER_PERIOD_CART'){
    return offerWithPeriodicCart;
  }
}

getOrderStatus(int val){
  if(val == 1){
    return orderReceive;
  }else  if(val == 2){
    return beingPrepare;
  }else  if(val == 3){
    return 'Cooked';
  }else  if(val == 4){
    return 'Packed';
  }else  if(val == 5){
    return 'Shipped';
  }else  if(val == 6){
    return 'Completed';
  }else  if(val == 7){
    return canceled;
  }
}

getOrderId(dynamic val){
  if(val == orderReceive){
    return 1;
  }else  if(val == beingPrepare){
    return 2;
  }else  if(val == outforDelivery || val == readyPickup){
    return 5;
  }else  if(val == delivered){
    return 6;
  }else  if(val == picked){
    return 8;
  }else  if(val == canceled){
    return 7;
  }
}

getOrderByName({required int val, required String isDelivery}){
  if(val == 1){
    return orderReceive;
  }else  if(val == 2){
    return beingPrepare;
  }else  if(val == 5){
    if(isDelivery == "DELIVERY") {
      return outforDelivery;
    }else{
      return readyPickup;
    }
  }else  if(val == 6 || val == 7){
    if(isDelivery == "DELIVERY") {
      return delivered;
    }else{
      return picked;
    }
  }
}

String time24to12Format(String startingTime,) {
  startingTime.replaceAll('.', ':');
  int startingHour = int.parse(startingTime.split(":").first);
  int startingMinute = int.parse(startingTime.split(":").last.split(" ").first);
  String send = "";
  if (startingHour > 12) {
    var temp = startingHour - 12;
    send = "$temp:${startingMinute.toString().length == 1 ? "0" + startingMinute.toString() : startingMinute.toString()} " + "PM";
  } else {
    send =
        "$startingHour:${startingMinute.toString().length == 1 ? "0" + startingMinute.toString() : startingMinute.toString()}  " +
            "AM";
  }
  return send;
}

String convertTo12HourFormat(int hour, int min) {
  String period = '';
  int convertedHour = hour;
  dynamic data, minute;
  if (hour >= 0 && hour <= 11) {
    period = 'AM';
    if (hour == 0) {
      convertedHour = 12;
    }
  } else {
    period = 'PM';
    if (hour > 12) {
      convertedHour = hour - 12;
    } else if (hour == 24) {
      convertedHour = 12;
    }
  }

  if(min.toString().length == 1){
    minute = "0$min";
  }else{
    minute = min;
  }

  if(convertedHour.toString().length == 1){
    data = "0$convertedHour:$minute $period";
    // debugPrint('data: $data');
  }else{
    data = "$convertedHour:$minute $period";
    // debugPrint('data: $data');
  }

  // return '$convertedHour:$min $period';
  return data;
}

// Function to convert 12-hour format with AM/PM to 24-hour format
String convertTo24HourFormat(String time12Hour) {
  String period = time12Hour.substring(time12Hour.length - 2); // Extract AM/PM
  String time = time12Hour.substring(0, time12Hour.length - 2); // Extract time without AM/PM

  int hour = int.parse(time.split(":")[0]); // Extract hour
  int minute = int.parse(time.split(":")[1]); // Extract minute

  if (period == "PM" && hour != 12) {
    hour += 12; // Convert to 24-hour format if PM and not already 12 PM
  } else if (period == "AM" && hour == 12) {
    hour = 0; // Convert to 24-hour format if AM and 12 AM
  }

  String hourString = hour.toString().padLeft(2, '0'); // Convert hour to string with leading zero if necessary
  String minuteString = minute.toString().padLeft(2, '0'); // Convert minute to string with leading zero if necessary

  return '$hourString.$minuteString';
}


Future<XFile?> cropImageWidget(BuildContext context ,String imagePath) async {
  final croppedFile = await ImageCropper().cropImage(
    sourcePath: imagePath,
    compressFormat: ImageCompressFormat.jpg,
    compressQuality: 70,
    aspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9),
    uiSettings: [
      AndroidUiSettings(
          toolbarTitle: cropTitleTxt,
          toolbarColor: Color(ORANGE),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true),
      IOSUiSettings(
        title: cropTitleTxt,
        aspectRatioLockEnabled: true,
      ),
    ],
  );

  if (croppedFile != null) {
    // Convert the File to XFile
    return XFile(croppedFile.path);
  }

  return null; // Return null if cropping failed or was canceled
}

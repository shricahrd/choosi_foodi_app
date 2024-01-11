import 'dart:io';
import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/app_preferences.dart';
import '../../../../../core/utils/app_strings_constants.dart';
import '../../../../../core/widgets/widget_button.dart';
import '../../controller/add_restaurnt_controller.dart';

class RestaurantSignupInfo extends StatefulWidget {
  Function moveToBankTab;

  RestaurantSignupInfo({Key? key, required this.moveToBankTab})
      : super(key: key);

  @override
  State<RestaurantSignupInfo> createState() => _RestaurantInfoState();
}

class _RestaurantInfoState extends State<RestaurantSignupInfo> {
  final VendorAddRestaurantController vendorAddRestaurantController =
      Get.put(VendorAddRestaurantController());
  String address1 = "", address2 = "";
  String searchLocation = "";
  bool isAddressAvail = false;
  dynamic restAdd;
  late File imagefile;

  @override
  void initState() {
    vendorAddRestaurantController.restAddressCtr.addListener(() {
      vendorAddRestaurantController.onChangePlace();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // SizedBox(height: 20,),
            Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child:
                    GetBuilder<VendorAddRestaurantController>(builder: (logic) {

                   bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(logic.restEmailCtr.text);

                  return Container(
                    padding: EdgeInsets.all(25),
                    width: double.infinity,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        customTextInputField(
                          logic.restNameCtr,
                          "Restaurant Name",
                          TextInputType.text,
                          TextInputAction.next,
                          true
                        ),
                        Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(DIVIDERCOLOR)),
                        SizedBox(
                          height: 10,
                        ),
                         customTextInputField(
                          logic.restEmailCtr,
                          "Restaurant Email", TextInputType.emailAddress,
                          TextInputAction.next,
                        ),
                        Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(DIVIDERCOLOR)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                          decoration: BoxDecoration(
                            color: Color(WHITE),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5)),
                          ),
                          padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                          child: TextFormField(
                            controller: logic.restAddressCtr,
                            textAlign: TextAlign.start,
                            textInputAction: TextInputAction.next,
                            textCapitalization:
                                TextCapitalization.sentences,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: restAddressTxt,
                              labelStyle: TextStyle(
                                color: Color(HINTCOLOR),
                                fontSize: logic.restAddressCtr.text.isEmpty ?14 : 18,
                                fontFamily: FontRoboto,
                                fontWeight: RobotoRegular,
                              ),
                            ),
                            style: TextStyle(
                              color: Color(BLACKINPUT),
                              fontSize: 18,
                              fontFamily: FontPoppins,
                              fontWeight: RobotoMedium,
                            ),
                            onChanged: (value) {
                              setState(() {
                                if(logic.restAddressCtr.text.isEmpty){
                                  isAddressAvail = false;
                                }
                                  searchLocation = value;
                                  debugPrint('SearchLocation: $value');
                                  if (searchLocation.isNotEmpty && restAdd != logic.restAddressCtr.text) {
                                      isAddressAvail = true;
                                  }
                              });
                            },
                          ),
                        ),
                        Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(DIVIDERCOLOR)),
                        isAddressAvail == true
                            ? Container(
                                width: double.infinity,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: Color(WHITE),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(15, 10, 0, 0),
                                        width: double.infinity,
                                        child: ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: logic.placesList.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () async {
                                                List<Location> locations =
                                                    await locationFromAddress(
                                                        logic.placesList[index]
                                                            ['description']);
                                                debugPrint(
                                                    'Location====> ${locations[0].toJson()}');
                                                debugPrint(
                                                    'Location lat====> ${locations[0].latitude}');

                                                // await Geocoder.google(your_API_Key).findAddressesFromCoordinates(coordinates);

                                                logic.lat = locations[0]
                                                    .latitude
                                                    .toString();
                                                logic.long = locations[0]
                                                    .longitude
                                                    .toString();
                                                debugPrint(
                                                    'Search latitude: ${logic.lat}');
                                                debugPrint(
                                                    'Search longitude: ${logic.long}');
                                                AppPreferences.setLat(
                                                    logic.lat);
                                                AppPreferences.setLong(
                                                    logic.long);
                                                logic.cordinates = logic.lat +
                                                    "," +
                                                    logic.long;
                                                debugPrint(
                                                    'cordinates: ${logic.cordinates}');

                                                address1 = logic
                                                            .placesList[index][
                                                        'structured_formatting']
                                                    ['main_text'];
                                                debugPrint('Address1: $address1');
                                                address2 = logic
                                                            .placesList[index][
                                                        'structured_formatting']
                                                    ['secondary_text'];
                                                debugPrint('Address2 : $address2');
                                                setState(() {
                                                  isAddressAvail = false;
                                                  debugPrint('OnTap isAddressAvail: $isAddressAvail');
                                                  logic.restAddressCtr.text =
                                                      address1 +
                                                          ", " +
                                                          address2;
                                                  restAdd = logic.restAddressCtr.text;
                                                  debugPrint('OnTap address: ${logic.restAddressCtr.text}');
                                                });
                                              },
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        ic_location_pin,
                                                        width: 25,
                                                        height: 25,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            logic.placesList[index]
                                                                            [
                                                                            'structured_formatting']
                                                                        [
                                                                        'main_text'] ==
                                                                    null
                                                                ? Text("")
                                                                : WidgetText
                                                                    .widgetRobotoRegularText(
                                                                    logic
                                                                        .placesList[
                                                                            index]
                                                                            [
                                                                            'structured_formatting']
                                                                            [
                                                                            'main_text']
                                                                        .toString(),
                                                                    Color(
                                                                        BLACK),
                                                                    16,
                                                                  ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            logic.placesList[index]
                                                                            [
                                                                            'structured_formatting']
                                                                        [
                                                                        'secondary_text'] ==
                                                                    null
                                                                ? Text("")
                                                                : WidgetText
                                                                    .widgetRobotoRegularText(
                                                                    logic
                                                                        .placesList[
                                                                            index]
                                                                            [
                                                                            'structured_formatting']
                                                                            [
                                                                            'secondary_text']
                                                                        .toString(),
                                                                    Color(
                                                                        DARKGREY),
                                                                    16,
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Divider(
                                                      height: 1,
                                                      thickness: 1,
                                                      color:
                                                          Color(DIVIDERCOLOR)),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 10,
                        ),
                        customTextInputField(
                          logic.ownerNameCtr,
                          "Manager Name",
                          TextInputType.text,
                          TextInputAction.next, true
                        ),
                        Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(DIVIDERCOLOR)),
                        SizedBox(
                          height: 10,
                        ),
                        customTextInputField(
                          logic.ownerNoCtr,
                          "Manager Number",
                          TextInputType.number,
                          TextInputAction.next,
                          false, true
                        ),
                        Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(DIVIDERCOLOR)),
                        SizedBox(
                          height: 10,
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 10, 20, 2),
                              child:
                              // WidgetText.widgetRegularText(
                              //   'Restaurant Images',
                              //   align: TextAlign.end,
                              // ),
                              WidgetText.widgetPoppinsRegularText(
                                restImages,
                                Color(GREYLABELPOPINS),
                                14,
                              ),
                            ),
                            Container(
                                height: 100,
                                width: double.infinity,
                                margin: EdgeInsets.fromLTRB(0, 20, 20, 2),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: logic.restFileList.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.file(
                                                    logic.restFileList[index],
                                                    width: 90,
                                                    height: 75,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ));
                                          }),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      DottedBorder(
                                        color: Color(DARKGREY),
                                        borderType: BorderType.RRect,
                                        radius: Radius.circular(10),
                                        dashPattern: [4, 4],
                                        strokeWidth: 1,
                                        padding: EdgeInsets.all(5),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              logic.onAttachMultipleDocFile(false);
                                            });
                                          },
                                          child: Container(
                                            height: 80,
                                            width: 90,
                                            child: Image.asset(
                                              ic_plus_icon,
                                              height: 5,
                                              width: 5,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        customTextInputField(
                          logic.restDeliveryTimeCtr,
                          "Average Delivery Time in Mins",
                          TextInputType.number,
                          TextInputAction.done,
                          false, true
                        ),
                        Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(DIVIDERCOLOR)),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: WidgetButton.widgetDefaultButton("Next", () async {
                            if(logic.ownerNoCtr.text.length == 10 || logic.ownerNoCtr.text.length == 11) {
                              widget.moveToBankTab();
                            }else{
                              showToastMessage("Entered mobile number must be 10 to 11 digit");
                            }
                          }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Color(WHITE),
                    ),
                  );
                })),
          ],
        ),
      ),
    );
  }

  Widget customTextInputField(
      TextEditingController editingController,
      String lableText,
      TextInputType? keyboardType,
      TextInputAction? textInputAction,
      [bool name = false, bool isDigit = false]) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
      decoration: BoxDecoration(
        color: Color(WHITE),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
      child: TextFormField(
        controller: editingController,
        textAlign: TextAlign.start,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        textCapitalization: TextCapitalization.sentences,
        inputFormatters: name ?  [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")), ] :
        isDigit ? [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ] : [],
        decoration: InputDecoration(
          labelText: lableText,
          labelStyle: TextStyle(
            color: Color(HINTCOLOR),
            fontSize: editingController.text.isEmpty ? 14 : 18,
            fontFamily: FontRoboto,
            fontWeight: RobotoRegular,
          ),
          border: InputBorder.none,
        ),
        onChanged: (val) {
          setState(() {});
        },
        style: TextStyle(
          color: Color(BLACKINPUT),
          fontSize: 18,
          fontFamily: FontPoppins,
          fontWeight: RobotoMedium,
        ),
      ),
    );
  }
}

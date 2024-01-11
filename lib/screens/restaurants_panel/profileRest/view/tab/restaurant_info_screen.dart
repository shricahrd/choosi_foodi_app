import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/http_utils/http_constants.dart';
import '../../../../../core/utils/app_color_utils.dart';
import '../../../../../core/utils/app_font_utils.dart';
import '../../../../../core/utils/app_images_utils.dart';
import '../../../../../core/utils/app_preferences.dart';
import '../../../../../core/utils/app_strings_constants.dart';
import '../../../../../core/utils/networkManager.dart';
import '../../../../../core/widgets/widget_card.dart';
import '../../../../../core/widgets/widget_text.dart';
import '../../controller/profile_rest_controller.dart';
import '../../controller/update_rest_profile_controller.dart';
import '../../model/vendor_profile_model.dart';

class RestaurantInfo extends StatefulWidget {
  Function moveToBankTab;

  RestaurantInfo({Key? key, required this.moveToBankTab}) : super(key: key);

  @override
  State<RestaurantInfo> createState() => _RestaurantInfoState();
}

class _RestaurantInfoState extends State<RestaurantInfo> {
  final VendorProfileGetController vendorProfileGetController =
      Get.put(VendorProfileGetController());
  final UpdateRestProfileController updateRestProfileController =
      Get.put(UpdateRestProfileController());
  VendorProfileModel vendorProfileModel = VendorProfileModel();
  TextEditingController restDeliveryTimeCtr = TextEditingController();
  bool isAddressAvail = false;
  String searchLocation = "";
  String address1 = "", address2 = "";
  dynamic restAdd;
  dynamic _startDate = "", _endDate = "";
  List timingList = [];

  @override
  void initState() {
    // vendorProfileGetController.loadRestImage = true;
    print('RestName: ${vendorProfileGetController.restNameCtr.text}');
    print('time: ${vendorProfileGetController.restDeliveryTimeCtr.text}');
    vendorProfileGetController.restAddressCtr.addListener(() {
      vendorProfileGetController.onChangePlace();
    });
    print(
        'restManagerNoCtr ====> ${vendorProfileGetController.restManagerNoCtr.text}');
    _startDate = vendorProfileGetController.openingTime;
    _endDate = vendorProfileGetController.closingTime;
    getAvailableTimeCheck();
    super.initState();
  }

  getAvailableTimeCheck() {
    var dayStringFromAPI = vendorProfileGetController
        .vendorProfileModel.data?.restaurant?.timings?.day;
    var dayArrayFromAPI = dayStringFromAPI?.split(",");
    for (int j = 0; j < availableOpeningDay.length; j++) {
      for (int i = 0; i < (dayArrayFromAPI?.length ?? 0); i++) {
        if (dayArrayFromAPI?[i] == availableOpeningDay[j]['name']) {
          setState(() {
            availableOpeningDay[j]["isChecked"] = true;
          });
        }
      }
    }
    print('available opening time len : ${availableOpeningDay.length}');
  }

  clearAvailableTimeCheck() {
    for (int j = 0; j < availableOpeningDay.length; j++) {
      setState(() {
        availableOpeningDay[j]["isChecked"] = false;
      });
    }
  }

  List<Map> availableOpeningDay = [
    {"name": "SUNDAY", "isChecked": false},
    {"name": "MONDAY", "isChecked": false},
    {"name": "TUESDAY", "isChecked": false},
    {
      "name": "WEDNESDAY",
      "isChecked": false,
    },
    {"name": "THURSDAY", "isChecked": false},
    {"name": "FRIDAY", "isChecked": false},
    {"name": "SATURDAY", "isChecked": false},
  ];

  Future<void> displayTimeDialogStart() async {
    final TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      setState(() {
        vendorProfileGetController.openingTime = time.format(context);
        var convertDate = DateFormat("h:mm")
            .parse(vendorProfileGetController.openingTime.toString());
        _startDate = DateFormat().add_Hm().format(convertDate);
        print('cDate: $_startDate');
      });
    }
  }

  Future<void> displayTimeDialogEnd() async {
    final TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    print('time: $time');
    if (time != null) {
      setState(() {
        vendorProfileGetController.closingTime = time.format(context);
        var convertDate1 =
            DateFormat("h:mm").parse(vendorProfileGetController.closingTime);
        _endDate = DateFormat().add_Hm().format(convertDate1);
        print('endDate: $_endDate');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : GetBuilder<VendorProfileGetController>(builder: (logic) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        padding: EdgeInsets.all(25),
                        width: double.infinity,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            customTextInputField(logic.restNameCtr, restName,
                                TextInputType.text, TextInputAction.next, true),
                            Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(DIVIDERCOLOR)),
                            SizedBox(
                              height: 10,
                            ),
                            customTextInputField(
                                logic.restNoCtr,
                                restNo,
                                TextInputType.number,
                                TextInputAction.next,
                                false,
                                true),
                            Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(DIVIDERCOLOR)),
                            SizedBox(
                              height: 10,
                            ),
                            customTextInputField(
                              logic.restEmailCtr,
                              restEmail,
                              TextInputType.emailAddress,
                              TextInputAction.next,
                            ),
                            Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(DIVIDERCOLOR)),
                            SizedBox(
                              height: 10,
                            ),
                            // restEmailCtr
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
                                    fontSize: 18,
                                    fontFamily: FontRoboto,
                                    fontWeight: RobotoRegular,
                                  ),
                                ),
                                style: TextStyle(
                                  color: Color(BLACK),
                                  fontSize: logic.restAddressCtr.text.isEmpty ?14 : 18,
                                  fontFamily: FontPoppins,
                                  fontWeight: RobotoMedium,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    if (logic.restAddressCtr.text.isEmpty) {
                                      isAddressAvail = false;
                                    }
                                    searchLocation = value;
                                    print('SearchLocation: $value');
                                    if (searchLocation.isNotEmpty &&
                                        restAdd != logic.restAddressCtr.text) {
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
                                            // decoration: BoxDecoration(
                                            //   color: Color(WHITE),
                                            // ),
                                            padding: EdgeInsets.fromLTRB(
                                                15, 10, 0, 0),
                                            width: double.infinity,
                                            child: ListView.builder(
                                              physics: BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  logic.placesList.length,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () async {
                                                    List<Location> locations =
                                                        await locationFromAddress(
                                                            logic.placesList[
                                                                    index][
                                                                'description']);
                                                    print(
                                                        'Location====> ${locations[0].toJson()}');
                                                    print(
                                                        'Location lat====> ${locations[0].latitude}');

                                                    // await Geocoder.google(your_API_Key).findAddressesFromCoordinates(coordinates);

                                                    logic.lat = locations[0]
                                                        .latitude
                                                        .toString();
                                                    logic.long = locations[0]
                                                        .longitude
                                                        .toString();
                                                    print(
                                                        'Search latitude: ${logic.lat}');
                                                    print(
                                                        'Search longitude: ${logic.long}');
                                                    AppPreferences.setLat(
                                                        logic.lat);
                                                    AppPreferences.setLong(
                                                        logic.long);
                                                    logic.cordinates =
                                                        logic.lat +
                                                            "," +
                                                            logic.long;
                                                    print(
                                                        'cordinates: ${logic.cordinates}');

                                                    address1 = logic.placesList[
                                                                index][
                                                            'structured_formatting']
                                                        ['main_text'];
                                                    print(
                                                        'Address1: $address1');
                                                    address2 = logic.placesList[
                                                                index][
                                                            'structured_formatting']
                                                        ['secondary_text'];
                                                    print(
                                                        'Address2 : $address2');
                                                    setState(() {
                                                      isAddressAvail = false;
                                                      logic.restAddressCtr
                                                              .text =
                                                          address1 +
                                                              ", " +
                                                              address2;
                                                      restAdd = logic
                                                          .restAddressCtr.text;
                                                      print(
                                                          'OnTap address: ${logic.restAddressCtr.text}');
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
                                                                logic.placesList[index]['structured_formatting']
                                                                            [
                                                                            'main_text'] ==
                                                                        null
                                                                    ? Text("")
                                                                    : WidgetText
                                                                        .widgetRobotoRegularText(
                                                                        logic
                                                                            .placesList[index]['structured_formatting']['main_text']
                                                                            .toString(),
                                                                        Color(
                                                                            BLACK),
                                                                        16,
                                                                      ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                logic.placesList[index]['structured_formatting']
                                                                            [
                                                                            'secondary_text'] ==
                                                                        null
                                                                    ? Text("")
                                                                    : WidgetText
                                                                        .widgetRobotoRegularText(
                                                                        logic
                                                                            .placesList[index]['structured_formatting']['secondary_text']
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
                                                          color: Color(
                                                              DIVIDERCOLOR)),
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
                                logic.restManagerNameCtr,
                                managerName,
                                TextInputType.text,
                                TextInputAction.next,
                                true),
                            Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(DIVIDERCOLOR)),
                            SizedBox(
                              height: 10,
                            ),
                            customTextInputField(
                                logic.restManagerNoCtr,
                                managerNo,
                                TextInputType.number,
                                TextInputAction.next,
                                false,
                                true),
                            Divider(
                                height: 1,
                                thickness: 1,
                                color: Color(DIVIDERCOLOR)),
                            SizedBox(
                              height: 10,
                            ),

                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child: WidgetText.widgetPoppinsRegularText(
                                    "Pickup",
                                    Color(GREYLABELPOPINS),
                                    14,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  alignment: Alignment.topRight,
                                  child: FlutterSwitch(
                                    padding: 2.0,
                                    toggleSize: 20,
                                    height: 25,
                                    activeColor: Color(GREEN),
                                    // activeText: 'ON',
                                    activeTextColor: Color(WHITE),
                                    showOnOff: true,
                                    value: vendorProfileGetController.isPickup,
                                    onToggle: (value) {
                                      setState(() {
                                        vendorProfileGetController.isPickup =
                                            !vendorProfileGetController
                                                .isPickup;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child:
                                      // WidgetText.widgetPoppinsText('Delivery')
                                      WidgetText.widgetPoppinsRegularText(
                                    "Delivery",
                                    Color(GREYLABELPOPINS),
                                    14,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  child: FlutterSwitch(
                                    padding: 2.0,
                                    toggleSize: 20,
                                    height: 25,
                                    activeColor: Color(GREEN),
                                    // activeText: 'ON',
                                    activeTextColor: Color(WHITE),
                                    showOnOff: true,
                                    value:
                                        vendorProfileGetController.isDelivery,
                                    onToggle: (value) {
                                      setState(() {
                                        vendorProfileGetController.isDelivery =
                                            !vendorProfileGetController
                                                .isDelivery;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child:
                                  // WidgetText.widgetPoppinsText('Days of Operation',)
                                  WidgetText.widgetPoppinsRegularText(
                                "Days of Operation",
                                Color(GREYLABELPOPINS),
                                14,
                              ),
                            ),

                            Column(
                                children: availableOpeningDay.map((type) {
                              return CheckboxListTile(
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  value: type["isChecked"],
                                  title: Text(
                                    type["name"],
                                    style: TextStyle(
                                      color: Color(BLACK),
                                      fontSize: 16,
                                      fontFamily: FontPoppins,
                                      fontWeight: RobotoMedium,
                                    ),
                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      type["isChecked"] = newValue;
                                    });
                                  });
                            }).toList()),

                            _timeFieldWidget(
                                vendorProfileGetController.openingTime,
                                vendorProfileGetController.closingTime),
                            SizedBox(
                              height: 10,
                            ),
                            customTextInputField(
                                logic.restDeliveryTimeCtr,
                                "Average Delivery Time in Mins",
                                TextInputType.number,
                                TextInputAction.done,
                                false,
                                true,
                                true),
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
                                    // WidgetText.widgetPoppinsText(restImages)
                                    WidgetText.widgetPoppinsRegularText(
                                      restImages,
                                      Color(GREYLABELPOPINS),
                                      14,
                                    ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 20, 20, 2),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Container(
                                            height: 80,
                                            child: logic.loadRestImage == true
                                                ? ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: logic
                                                        .restFileList.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          child: InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                logic
                                                                    .onAttachMultipleRestaurantFile();
                                                              });
                                                            },
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child: Image.file(
                                                                logic.restFileList[
                                                                    index],
                                                                width: 75,
                                                                height: 75,
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                          ));
                                                    })
                                                : logic
                                                                .vendorProfileModel
                                                                .data
                                                                ?.restaurant
                                                                ?.restaurantImg
                                                                ?.isEmpty ==
                                                            true &&
                                                        logic.loadRestImage ==
                                                            false
                                                    ? DottedBorder(
                                                        color: Color(DARKGREY),
                                                        borderType:
                                                            BorderType.RRect,
                                                        radius:
                                                            Radius.circular(10),
                                                        dashPattern: [4, 4],
                                                        strokeWidth: 1,
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              logic
                                                                  .onAttachMultipleRestaurantFile();
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 75,
                                                            height: 75,
                                                            child: Image.asset(
                                                              ic_upload_icon,
                                                              height: 55,
                                                              width: 70,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            BouncingScrollPhysics(),
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: logic
                                                            .vendorProfileModel
                                                            .data
                                                            ?.restaurant
                                                            ?.restaurantImg
                                                            ?.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  logic.onAttachMultipleRestaurantFile();
                                                                });
                                                              },
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    new BorderRadius
                                                                            .circular(
                                                                        10.0),
                                                                child:
                                                                Container(
                                                                  height: 75,width: 75,
                                                                  child: imageFromNetworkCache(logic
                                                                      .vendorProfileModel
                                                                      .data!
                                                                      .restaurant!
                                                                      .restaurantImg![index],
                                                                      height: 75),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        })),
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
                                                logic.onAttachMultipleRestaurantFile();
                                              });
                                            },
                                            child: Container(
                                              width: 65,
                                              height: 65,
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
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                updateRestProfileController.isLoaderVisible ==
                                        false
                                    ? InkWell(
                                        onTap: () async {
                                          List selectedList = [];
                                          dynamic selectedOpeningTime = "";
                                          // print('availableOpeningDay data: $availableOpeningDay');
                                          for (int i = 0;
                                              i < availableOpeningDay.length;
                                              i++) {
                                            print('INDEX: $i');
                                            if (availableOpeningDay[i]
                                                    ["isChecked"] ==
                                                true) {
                                              selectedList.add(
                                                  availableOpeningDay[i]
                                                      ["name"]);
                                            }
                                          }

                                          for (int i = 0;
                                              i < selectedList.length;
                                              i++) {
                                            print('INDEX: $i');
                                            if (i == 0) {
                                              selectedOpeningTime =
                                                  selectedList[i];
                                            } else {
                                              selectedOpeningTime +=
                                                  "," + selectedList[i];
                                            }
                                          }

                                          print(
                                              'selectedOpeningTime: $selectedOpeningTime');
                                          print(
                                              'isPickup: ${vendorProfileGetController.isPickup}');
                                          print(
                                              'isDelivery: ${vendorProfileGetController.isDelivery}');
                                          print(
                                              'startDate: $_startDate, endDate: $_endDate');

                                          if (logic.loadRestImage == false) {
                                            final params = jsonEncode({
                                              HttpConstants.PARAMS_REST_NAME:
                                                  logic.restNameCtr.text,
                                              HttpConstants.PARAMS_REST_ADDRESS:
                                                  logic.restAddressCtr.text,
                                              HttpConstants.PARAMS_REST_EMAIL:
                                                  logic.restEmailCtr.text,
                                              HttpConstants.PARAMS_REST_NUMBER:
                                                  logic.restNoCtr.text,
                                              HttpConstants
                                                      .PARAMS_REST_MANAGER_MOBILE:
                                                  logic.restManagerNoCtr.text,
                                              HttpConstants
                                                      .PARAMS_REST_DELIVERYTIME:
                                                  logic.restDeliveryTimeCtr.text
                                                      .toString(),
                                              HttpConstants.PARAMS_VENDORNAME:
                                                  logic.ownerNameCtr.text,
                                              HttpConstants.PARAMS_OPENINGTIME:
                                                  _startDate,
                                              HttpConstants.PARAMS_CLOSINGTIME:
                                                  _endDate,
                                              HttpConstants.PARAMS_DAY:
                                                  selectedOpeningTime,
                                              HttpConstants.PARAMS_ISPICKUP:
                                                  vendorProfileGetController
                                                      .isPickup,
                                              HttpConstants.PARAMS_ISDELIVERY:
                                                  vendorProfileGetController
                                                      .isDelivery,
                                            });

                                            print('Params: ${params}');
                                            setState(() {
                                              updateRestProfileController
                                                  .isLoaderVisible = true;
                                            });
                                            await updateRestProfileController
                                                .updateProfileApi(
                                              params: params,
                                              image: logic.loadRestImage,
                                              imageKey1: HttpConstants
                                                  .PARAMS_RESTAURANTIMG,
                                            );
                                            if (updateRestProfileController
                                                    .isLoaderVisible ==
                                                true) {
                                              setState(() {
                                                updateRestProfileController
                                                    .isLoaderVisible = false;
                                                widget.moveToBankTab();
                                              });
                                            }
                                          } else {
                                            // managerMobile
                                            Map<String, String> params =
                                                <String, String>{
                                              HttpConstants.PARAMS_REST_NAME:
                                                  logic.restNameCtr.text,
                                              HttpConstants.PARAMS_REST_ADDRESS:
                                                  logic.restAddressCtr.text,
                                              HttpConstants.PARAMS_REST_EMAIL:
                                                  logic.restEmailCtr.text,
                                              HttpConstants.PARAMS_REST_NUMBER:
                                                  logic.restNoCtr.text,
                                              HttpConstants
                                                      .PARAMS_REST_MANAGER_MOBILE:
                                                  logic.restManagerNoCtr.text,
                                              HttpConstants
                                                      .PARAMS_REST_DELIVERYTIME:
                                                  logic.restDeliveryTimeCtr.text
                                                      .toString(),
                                              HttpConstants.PARAMS_VENDORNAME:
                                                  logic.ownerNameCtr.text,
                                              HttpConstants.PARAMS_OPENINGTIME:
                                                  _startDate,
                                              HttpConstants.PARAMS_CLOSINGTIME:
                                                  _endDate,
                                              HttpConstants.PARAMS_DAY:
                                                  selectedOpeningTime,
                                              HttpConstants.PARAMS_ISPICKUP: vendorProfileGetController.isPickup.toString(),
                                              HttpConstants.PARAMS_ISDELIVERY: vendorProfileGetController.isDelivery.toString(),
                                            };
                                            debugPrint('map Params: $params');

                                            setState(() {
                                              updateRestProfileController
                                                  .isLoaderVisible = true;
                                            });
                                            await updateRestProfileController
                                                .updateProfileMultiImageApi(
                                                    params: params,
                                                    image: logic.loadRestImage,
                                                    imageKey1: HttpConstants
                                                        .PARAMS_RESTAURANTIMG,
                                                    imageFile:
                                                        logic.restFileList);
                                            if (updateRestProfileController
                                                    .isLoaderVisible ==
                                                true) {
                                              setState(() {
                                                updateRestProfileController
                                                    .isLoaderVisible = false;
                                                widget.moveToBankTab();
                                              });
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: 120,
                                          padding:
                                              EdgeInsets.fromLTRB(0, 10, 0, 10),
                                          decoration: BoxDecoration(
                                            color: Color(ORANGE),
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7)),
                                          ),
                                          alignment: Alignment.center,
                                          child: WidgetText
                                              .widgetPoppinsMediumText(
                                            "Submit",
                                            Color(WHITE),
                                            14,
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(
                                          color: Color(ORANGE),
                                        ),
                                      ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _startDate = "00:00";
                                      _endDate = "00:00";
                                      vendorProfileGetController.openingTime = "00:00";
                                      vendorProfileGetController.closingTime = "00:00";
                                      logic.restNameCtr.clear();
                                      logic.restAddressCtr.clear();
                                      logic.restEmailCtr.clear();
                                      logic.restManagerNameCtr.clear();
                                      logic.restDeliveryTimeCtr.clear();
                                      logic.restNoCtr.clear();
                                      logic.ownerNameCtr.clear();
                                      logic.restManagerNoCtr.clear();
                                      logic.restFileList.clear();
                                      logic.vendorProfileModel.data?.restaurant
                                          ?.restaurantImg
                                          ?.clear();
                                      logic.loadRestImage = false;
                                      clearAvailableTimeCheck();
                                      vendorProfileGetController.isPickup =
                                          false;
                                      vendorProfileGetController.isDelivery =
                                          false;
                                    });
                                  },
                                  child: Container(
                                    width: 120,
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    decoration: BoxDecoration(
                                      color: Color(WHITE),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                          color: Color(ORANGE), width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                    ),
                                    alignment: Alignment.center,
                                    child: WidgetText.widgetPoppinsMediumText(
                                      "Reset",
                                      Color(ORANGE),
                                      14,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Color(WHITE),
                        ),
                      ),
                    ),
                  ],
                );
              });
      })),
    );
  }

  Widget _timeFieldWidget(String title, String title2) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 15),
                  child:
                  // WidgetText.widgetPoppinsText(open),
                  WidgetText.widgetPoppinsRegularText(
                    open,
                    Color(GREYLABELPOPINS),
                    14,
                  ),
                ),
                InkWell(
                  onTap: () {
                    displayTimeDialogStart();
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        WidgetText.widgetPoppinsMediumText(
                          title,
                          Color(BLACK),
                          16,
                        ),
                        Image.asset(
                          ic_timer_icon,
                          height: 20,
                          width: 20,
                          color: Color(BLACK),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 25),
                  child:
                  WidgetText.widgetPoppinsRegularText(
                    close,
                    Color(GREYLABELPOPINS),
                    14,
                  ),
                ),
                InkWell(
                  onTap: () {
                    displayTimeDialogEnd();
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        WidgetText.widgetPoppinsMediumText(
                          title2,
                          Color(BLACK),
                          16,
                        ),
                        Image.asset(
                          ic_timer_icon,
                          height: 20,
                          width: 20,
                          color: Color(BLACK),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customTextInputField(
      TextEditingController editingController,
      String labelText,
      TextInputType? keyboardType,
      TextInputAction? textInputAction,
      [bool name = false,
      bool isMobile = false,
      bool isMin = false]) {
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
        inputFormatters: name
            ? [
                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
              ]
            : isMobile
                ? [
                    FilteringTextInputFormatter.digitsOnly,
                    isMin
                        ? LengthLimitingTextInputFormatter(2)
                        : LengthLimitingTextInputFormatter(11),
                  ]
                : [],
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          labelStyle: TextStyle(
            color: Color(HINTCOLOR),
            fontSize: editingController.text.isEmpty ? 14 : 18,
            fontFamily: FontPoppins,
            fontWeight: PoppinsRegular,
          ),
        ),
        onChanged: (val) {
          setState(() {});
        },
        style: TextStyle(
          color: Color(BLACK),
          fontSize: 16,
          fontFamily: FontPoppins,
          fontWeight: RobotoMedium,
        ),
      ),
    );
  }
}

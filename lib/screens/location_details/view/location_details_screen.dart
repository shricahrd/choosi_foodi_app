import 'dart:convert';
import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/routes/all_routes.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../core/utils/app_preferences.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../../home/controller/user_home_controller.dart';
import '../controller/locationdetails_controller.dart';
import '../model/get_custom_location_model.dart';
import '../model/location_details_model.dart';

class LocationDetailsScreen extends StatefulWidget {
  final bool isFromSignup;
  final String? mobile;

  const LocationDetailsScreen({Key? key, required this.isFromSignup, this.mobile})
      : super(key: key);

  @override
  _LocationDetailsScreenState createState() =>
      _LocationDetailsScreenState(isFromSignup);
}

class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
  String searchLocation = "";
  bool isFromSignup = false;

  _LocationDetailsScreenState(bool isFromSignup) {
    this.isFromSignup = isFromSignup;
  }

  final LocationDetailsController locationDetailsController =
      Get.put(LocationDetailsController());
  final UserHomeController userHomeController = Get.put(UserHomeController());
  List<LocationDetailsModel> locationDetailsList = [];
  String long = "", lat = "";
  String address1 = "", address2 = "";
  bool isDefault = false;
  List<GetCustomLocationModel> getCustomAddressList = [];


  @override
  void initState() {
    locationDetailsController.searchController.clear();
    print('isFromSignup: $isFromSignup');
    // calculateList();
    getAddressData();
    // _getLocationModel();
    locationDetailsController.searchController.addListener(() {
      locationDetailsController.onChangePlace();
    });
    super.initState();
  }

  calculateList(){
    for(int i=0; i<locationDetailsList.length; i++){
        print('locationDetailsList: ${locationDetailsList[i].address1} && address2: ${locationDetailsList[i].address2}');
        print('Total Len: ${locationDetailsList.length}');
      }
  }

  @override
  void dispose() {
    super.dispose();
    locationDetailsController.addId = 0;
  }

  getAddressData() async {
    // getCustomAddressList.clear();
    // locationDetailsController.addToSPLocation(getCustomAddressList);
    final prefs = await AppPreferences.getLocation();
    // Fetch and decode data
    final data1 = json.decode(prefs.toString());
    if(data1 != null) {
      final item = List<GetCustomLocationModel>.from(
          data1.map((i) => GetCustomLocationModel.fromJson(i)));
      print('item before reverse ====> : ${jsonEncode(item.map((data) => data.toMap()).toList())}');
      getCustomAddressList = item.reversed.toList();
      print('after reverse ====> : ${jsonEncode(getCustomAddressList.map((data) => data.toMap()).toList())}');
      if (getCustomAddressList.length != 0) {
        print('GetCartModel list Len: ${getCustomAddressList.length}');
        if(getCustomAddressList.length > 3){
          getCustomAddressList.removeLast();
          print('Added');
        }
      }
    }

    address1 = (await AppPreferences.getAddress1())!;
    address2 = (await AppPreferences.getAddress2())!;
    print('address1: $address1, address2: $address2');
    setState(() {});
  }

/*  _getLocationModel() async {
    print('In Prefs');
    var locationDetailsPrefsList;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    locationDetailsPrefsList = sharedPreferences.getStringList(PREF_LOCATIONLIST);
    print('locationDetailsPrefsList Len: ${locationDetailsPrefsList.length}');
    print('locationDetailsPrefsList: ${locationDetailsPrefsList[0]}');
    if(locationDetailsPrefsList != null) {
      List<String> locationDecoded = [];
      locationDecoded.add(locationDetailsPrefsList.toString());
      print('Location Len: ${locationDecoded.length}');
      var add1, add2;
      for (int i = 0; i < locationDecoded.length; i++) {
        // address1 = jsonEncode(locationDecoded[i]['address1'].toString());
        if(locationDecoded[i].contains('address1')){
          add1 = locationDecoded[i];
          print('Address1 ====> $add1');
        }
        if(locationDecoded[i].contains('address2')){
          add2 = locationDecoded[i];
          print('Address2 ====> $add2');
        }

        print('Location: ${locationDecoded[i]}');
        // locationDetailsList.add(LocationDetailsModel(address1: locationDecoded[i][a], address2: address2));
      }
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : GetBuilder<LocationDetailsController>(builder: (logic) {
                return
                  appLoader(widget:
                  Column(
                  children: [
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(WHITE),
                      ),
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                         /* isFromSignup
                              ? InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Image.asset(
                                    ic_right_side_arrow,
                                    width: 18,
                                    height: 18,
                                  ),
                                )
                              : Container(),
                          isFromSignup
                              ? SizedBox(
                                  width: 15,
                                )
                              : Container(),*/
                          WidgetText.widgetRobotoMediumText(
                            "Location Details",
                            Color(BLACK),
                            20,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 70,
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(WHITE),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            ic_search,
                            width: 22,
                            height: 22,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: logic.searchController,
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Color(LIGHTHINTCOLOR),
                                  fontSize: 16,
                                  fontFamily: FontRoboto,
                                  fontWeight: RobotoRegular,
                                ),
                                hintText: "Enter New Address",
                              ),
                              style: TextStyle(
                                color: Color(BLACK),
                                fontSize: 16,
                                fontFamily: FontRoboto,
                                fontWeight: RobotoMedium,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  searchLocation = value;
                                  print('SearchLocation: $value');
                                  // controller.text = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(WHITE),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(WHITE),
                                ),
                                padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                width: double.infinity,
                                child: !isFromSignup &&
                                        searchLocation.isEmpty
                                    ? Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (isFromSignup == false) {
                                                  setState(() {
                                                    userHomeController.isLoaderVisible = false;
                                                  });
                                                  userHomeController.checkGps();
                                                  Get.back();
                                                } else {
                                                    Get.offAllNamed(AllRoutes.login);
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 5, 5, 10),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      ic_location_pin,
                                                      width: 25,
                                                      height: 25,
                                                    ),
                                                    WidgetText.widgetRobotoRegularText(
                                                      useCurrentLocation,
                                                      Color(ORANGE),
                                                      16,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 5, 5, 10),
                                              child: Divider(
                                                  height: 1,
                                                  thickness: 3,
                                                  color: Color(DIVIDERCOLOR)),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            // address1 == "" ? Container() :
                                            getCustomAddressList.length == 0 ? Container() :
                                            WidgetText.widgetRobotoRegularText(
                                              usePreviousLocation,
                                              Color(BLACK),
                                              16,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            // address1 == "" ? Container() :
                                            getCustomAddressList.length == 0 ? Container() :
                                            Expanded(
                                              child: ListView.builder(
                                                  // reverse: true,
                                                  shrinkWrap: true,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  itemCount: getCustomAddressList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return
                                                      Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            //set ontap lat, long
                                                            lat = getCustomAddressList[index].lat;
                                                            long = getCustomAddressList[index].long;
                                                            print('Search latitude: $lat');
                                                            print('Search longitude: $long');
                                                            AppPreferences.setLat(lat);
                                                            AppPreferences.setLong(long);
                                                            Get.back();
                                                          },
                                                          child: Row(
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
                                                                width: 3,
                                                              ),
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    WidgetText
                                                                        .widgetRobotoRegularText(
                                                                      // address1.toString(),
                                                                      getCustomAddressList[index].address1.toString(),
                                                                      Color(
                                                                          DARKGREY),
                                                                      16,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    WidgetText
                                                                        .widgetRobotoRegularText(
                                                                      // address2.toString(),
                                                                      getCustomAddressList[index].address2.toString(),
                                                                      Color(
                                                                          DARKGREY),
                                                                      16,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
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
                                                    );
                                                  }),
                                            ),
                                          ],
                                        ),
                                      )
                                    : ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: logic.placesList.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () async {
                                              isDefault = true;
                                              List<Location> locations =
                                                  await locationFromAddress(
                                                      logic.placesList[index]
                                                          ['description']);
                                              print('Location====> ${locations[0].toJson()}');
                                              print('Location lat====> ${locations[0].latitude}');

                                              // await Geocoder.google(your_API_Key).findAddressesFromCoordinates(coordinates);

                                              lat = locations[0]
                                                  .latitude
                                                  .toString();
                                              long = locations[0]
                                                  .longitude
                                                  .toString();
                                              print('Search latitude: $lat');
                                              print('Search longitude: $long');
                                              AppPreferences.setLat(lat);
                                              AppPreferences.setLong(long);

                                              address1 = logic.placesList[index]
                                                      ['structured_formatting']
                                                  ['main_text'];
                                              print('Address1: $address1');
                                              address2 = logic.placesList[index]
                                                      ['structured_formatting']
                                                  ['secondary_text'];
                                              print('Address2 : $address2');
                                              AppPreferences.setAddress1(address1);
                                              AppPreferences.setAddress2(address2);


                                              //Add location list
                                              if(getCustomAddressList.length > 2){
                                                getCustomAddressList.removeLast();
                                                getCustomAddressList.add(GetCustomLocationModel(address1: address1,address2: address2, lat: lat, long: long));
                                                logic.addToSPLocation(getCustomAddressList);
                                                print('Added');
                                              }else {
                                                for(int i=0; i<getCustomAddressList.length; i++){
                                                  if(address1 != getCustomAddressList[i].address1){
                                                    print('Not same');
                                                    getCustomAddressList.add(GetCustomLocationModel(address1: address1,address2: address2, lat: lat, long: long));
                                                    locationDetailsController.addToSPLocation(getCustomAddressList);
                                                    print('Added');
                                                  }else{
                                                    print('same address');
                                                  }
                                                }
                                              }

                                              if (isFromSignup == false) {
                                                // userHomeController.getLocation();
                                                Navigator.of(context)
                                                    .pop(isDefault);
                                              } else {
                                                print('Get Location on listview');
                                                if(logic.isEnable == true) {
                                                  setState(() {
                                                    logic.isEnable = false;
                                                    debugPrint('isEnable: ${logic.isEnable}');
                                                  });
                                                  await logic
                                                      .getAddressFromLatLongDirect(
                                                    lat: double.parse(lat),
                                                    long: double.parse(long),
                                                    mobile: widget.mobile
                                                        .toString(),);
                                                  if (logic.deleteCartModel.meta
                                                      ?.status == true) {
                                                    debugPrint(logic
                                                        .deleteCartModel.meta
                                                        ?.msg.toString());
                                                    Get.offAllNamed(
                                                        AllRoutes.login);
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 6), () {
                                                          if(mounted) {
                                                            setState(() {
                                                              logic.isEnable =
                                                              true;
                                                              debugPrint(
                                                                  'isEnable: ${logic
                                                                      .isEnable}');
                                                            });
                                                          }
                                                    });
                                                  }
                                                }
                                              }
                                            },
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
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
                                                          logic.placesList[index]['structured_formatting']['main_text'] == null
                                                              ? Text("")
                                                              : WidgetText
                                                                  .widgetRobotoRegularText(
                                                                  logic
                                                                      .placesList[index]['structured_formatting']['main_text']
                                                                      .toString(),
                                                                  Color(BLACK),
                                                                  16,
                                                                ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          logic.placesList[index]
                                                          ['structured_formatting']['secondary_text'] == null
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
                                                    color: Color(DIVIDERCOLOR)),
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
                            Container(
                                margin: EdgeInsets.fromLTRB(40, 0, 40, 40),
                                child: WidgetButton.widgetDefaultButton("Next",
                                    () async {
                                  if (logic.placesList.length > 0) {
                                    if (logic.placesList[0]
                                    ['structured_formatting']['main_text'] != null &&
                                        logic.placesList[0]['structured_formatting']['secondary_text'] != null) {
                                      List<Location> locations =
                                          await locationFromAddress(logic
                                              .placesList[0]['description']);
                                      lat = locations[0].latitude.toString();
                                      long = locations[0].longitude.toString();
                                      print('Search latitude: $lat');
                                      print('Search longitude: $long');
                                      AppPreferences.setLat(lat);
                                      AppPreferences.setLong(long);
                                      address1 = logic.placesList[0]
                                              ['structured_formatting']
                                              ['main_text']
                                          .toString();
                                      print('Address1: $address1');
                                      address2 = logic.placesList[0]
                                              ['structured_formatting']
                                              ['secondary_text']
                                          .toString();
                                      print('Address2 : $address2');
                                      AppPreferences.setAddress1(address1);
                                      AppPreferences.setAddress2(address2);
                                      if (isFromSignup == false) {
                                        Navigator.of(context).pop(isDefault);
                                      } else {
                                        print('Get Location on listview');
                                        if(logic.isEnable == true) {
                                          setState(() {
                                            logic.isEnable = false;
                                            debugPrint('isEnable: ${logic.isEnable}');
                                          });
                                          await logic
                                              .getAddressFromLatLongDirect(
                                            lat: double.parse(lat),
                                            long: double.parse(long),
                                            mobile: widget.mobile.toString(),);

                                        if (logic.deleteCartModel.meta?.status == true) {
                                          debugPrint(logic.deleteCartModel.meta?.msg.toString());
                                          Get.offAllNamed(AllRoutes.login);
                                          Future.delayed(const Duration(seconds: 2), () {
                                            setState(() {
                                              logic.isEnable = true;
                                              debugPrint('isEnable: ${logic.isEnable}');
                                            });
                                          });
                                        }
                                        }
                                      }
                                    }
                                  } else {
                                    if (isFromSignup == false) {
                                      Navigator.of(context).pop(isDefault);
                                    } else {
                                      print('Get Location on listview');
                                      if(logic.isEnable == true) {
                                        setState(() {
                                          logic.isEnable = false;
                                          debugPrint('isEnable: ${logic.isEnable}');
                                        });
                                        await logic.getAddressFromLatLongDirect(
                                          lat: double.parse(lat),
                                          long: double.parse(long),
                                          mobile: widget.mobile.toString(),);

                                        if (logic.deleteCartModel.meta
                                            ?.status == true) {
                                          debugPrint(
                                              logic.deleteCartModel.meta?.msg
                                                  .toString());
                                          Get.offAllNamed(AllRoutes.login);
                                          Future.delayed(
                                              const Duration(seconds: 2), () {
                                            setState(() {
                                              logic.isEnable = true;
                                              debugPrint('isEnable: ${logic
                                                  .isEnable}');
                                            });
                                          });
                                        }
                                      }
                                    }
                                  }
                                })),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                  isLoading: !logic.isEnable);
              });
      })),
    );
  }
}

import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/restaurants_panel/profileRest/view/profile_tab_screen.dart';
import 'package:choosifoodi/screens/restaurants_panel/profileRest/view/review_rest_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../../../../core/utils/networkManager.dart';
import '../../../../core/widgets/widget_button.dart';
import '../../../../core/widgets/widget_card.dart';
import '../../../../core/widgets/widget_webview.dart';
import '../controller/profile_rest_controller.dart';

class ProfileRestScreen extends StatefulWidget {
  final bool isFromHome;

  ProfileRestScreen({
    required this.isFromHome,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState(isFromHome);
}

class _ProfileScreenState extends State<ProfileRestScreen> {
  final VendorProfileGetController vendorProfileGetController =
      Get.put(VendorProfileGetController());

// create an instance
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());

  bool isFromHome = false;

  _ProfileScreenState(bool isFromHome) {
    this.isFromHome = isFromHome;
  }

  @override
  void initState() {
    if (_networkManager.connectionType != 0) {
      print('Connection Type: ${_networkManager.connectionType}');
      vendorProfileGetController.getUserProfile();
      vendorProfileGetController.checkGps();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(WHITE),
        body: SafeArea(child: Center(
            child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
          return networkManager.connectionType == 0
              ? Text(check_internet)
              : GetBuilder<VendorProfileGetController>(builder: (logic) {
                  dynamic foodTypeData;
                  for (int i = 0;
                      i <
                          (vendorProfileGetController.vendorProfileModel.data
                                  ?.restaurant?.foodTypes?.length ??
                              0);
                      i++) {
                    if (i == 0) {
                      foodTypeData = vendorProfileGetController
                              .vendorProfileModel
                              .data
                              ?.restaurant
                              ?.foodTypes?[i] ??
                          "";
                    } else {
                      foodTypeData += ", " +
                          (vendorProfileGetController.vendorProfileModel.data
                                  ?.restaurant?.foodTypes?[i] ??
                              "");
                    }
                  }

                  // print('foodTypeData out: $foodTypeData');

                  return logic.isLoaderVisible == true
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isFromHome
                                      ? Container(
                                          height: 20,
                                        )
                                      : InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: Image.asset(
                                            ic_back,
                                            width: 18,
                                            height: 18,
                                          ),
                                        ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: WidgetText.widgetPoppinsRegularText(
                                      "My Profile",
                                      Color(BLACK),
                                      16,
                                    ),
                                  ),
                                  PopupMenuButton(
                                    color: logic.alertColor,
                                    icon: Icon(Icons.notifications_rounded,
                                        color: logic.alertColor, size: 30),
                                    onSelected: (value) {
                                      // your logic
                                    },
                                    itemBuilder: (BuildContext bc) {
                                      return [
                                        PopupMenuItem(
                                          child: Text(
                                            logic.alertMessage,
                                            style:
                                                TextStyle(color: Color(WHITE)),
                                          ),
                                          value: logic.alertMessage,
                                        ),
                                      ];
                                    },
                                  ),
                                  // Icon(Icons.notifications_rounded, color: Color(ORANGE),),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: logic.vendorProfileModel.data?.vendorImg ==
                                          null ||
                                      logic.vendorProfileModel.data!.vendorImg!
                                          .isEmpty
                                  ? CircleAvatar(
                                      radius: 50,
                                      child: ClipRRect(
                                        borderRadius:
                                            new BorderRadius.circular(100.0),
                                        child: Image.asset(
                                          ic_no_image,
                                          height: 110,
                                          width: 110,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 50,
                                      child: ClipRRect(
                                        borderRadius:
                                            new BorderRadius.circular(100.0),
                                        child:
                                        Container(
                                          height: 110,
                                          width: 110,
                                          child: imageFromNetworkCache(logic.vendorProfileModel.data?.vendorImg?.first.toString() ?? "",
                                              height: 110),
                                        ),
                                      ),
                                    ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Divider(
                              color: Color(LIGHTDIVIDERCOLOR),
                              height: 2,
                              thickness: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WidgetText.widgetPoppinsRegularText(
                                    // "Profile Information",
                                    logic.vendorProfileModel.data?.restaurant
                                            ?.restaurantName
                                            .toString() ??
                                        "Profile Information",
                                    Color(BLACK),
                                    20,
                                  ),
                                  InkWell(
                                    onTap: onClickEditProfile,
                                    child: Image.asset(
                                      ic_edit,
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                ],
                              ),
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
                                    logic.vendorProfileModel.data?.restaurant
                                                    ?.restaurantNumber
                                                    .toString()
                                                    .isEmpty ==
                                                true ||
                                            logic
                                                    .vendorProfileModel
                                                    .data
                                                    ?.restaurant
                                                    ?.restaurantNumber ==
                                                null
                                        ? _profileFieldWidget(restName, "")
                                        : _profileFieldWidget(
                                            restNo,
                                            logic
                                                    .vendorProfileModel
                                                    .data
                                                    ?.restaurant
                                                    ?.restaurantNumber
                                                    .toString() ??
                                                ""),
                                    Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    _profileFieldWidget(
                                        managerName,
                                        logic.vendorProfileModel.data
                                                ?.restaurant?.managerName ??
                                            ""),
                                    Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    _profileFieldWidget(
                                        managerNo,
                                        logic.vendorProfileModel.data
                                                ?.restaurant?.managerMobile ??
                                            ""),
                                    // logic.restManagerNoCtr.text ?? ""),
                                    Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    _profileFieldWidget(
                                        email,
                                        logic.vendorProfileModel.data?.email ??
                                            ""),
                                    Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    _profileFieldWidget(
                                        rating,
                                        logic.vendorProfileModel.data
                                                ?.restaurant?.ratings
                                                .toString() ??
                                            ""),
                                    Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    logic.createdDate == ""
                                        ? _profileFieldWidget("Created", "")
                                        : _profileFieldWidget(
                                            "Created", logic.createdDate),
                                    Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    _profileFieldWidget(
                                        profileStatus,
                                        logic.vendorProfileModel.data?.status ??
                                            ""),
                                    Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    _profileFieldWidget(
                                        owner,
                                        logic.vendorProfileModel.data
                                                ?.vendorName ??
                                            ""),
                                    Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    _profileFieldWidget(
                                        ownerContactNumber,
                                        logic.vendorProfileModel.data?.mobile ??
                                            ""),
                                    Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    _profileFieldWidget(
                                        dietrySpec, foodTypeData ?? ""),
                                    Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    _profileFieldWidget(
                                        restId,
                                        logic.vendorProfileModel.data?.id ??
                                            ""),
                                    Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    _profileFieldWidget(
                                        "Restaurant Address",
                                        logic
                                                .vendorProfileModel
                                                .data!
                                                .restaurant
                                                ?.restaurantAddress ??
                                            ""),
                                    Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),

                                    SizedBox(
                                      height: 10,
                                    ),
                                    _profileFieldWidget(
                                        bank,
                                        logic
                                                .vendorProfileModel
                                                .data
                                                ?.restaurant
                                                ?.bankInformation
                                                ?.bankName ??
                                            ""),
                                    Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    _profileFieldWidget(
                                        bankBranch,
                                        logic
                                                .vendorProfileModel
                                                .data
                                                ?.restaurant
                                                ?.bankInformation
                                                ?.branchName ??
                                            ""),
                                    Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    _profileFieldWidget(
                                        accountHolder,
                                        logic
                                                .vendorProfileModel
                                                .data
                                                ?.restaurant
                                                ?.bankInformation
                                                ?.holderName ??
                                            ""),
                                    Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    _profileFieldWidget(
                                        accountNumber,
                                        logic
                                                .vendorProfileModel
                                                .data
                                                ?.restaurant
                                                ?.bankInformation
                                                ?.accountNumber ??
                                            ""),
                                    Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    _profileFieldWidget(
                                        routingNumber,
                                        logic
                                                .vendorProfileModel
                                                .data
                                                ?.restaurant
                                                ?.bankInformation
                                                ?.routingNumber ??
                                            ""),
                                    Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10, 20, 10, 15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              WidgetText.widgetPoppinsText(
                                                  "Ratings"),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              RatingStars(
                                                value: double.parse(logic
                                                        .vendorProfileModel
                                                        .data
                                                        ?.restaurant
                                                        ?.ratings
                                                        .toString() ??
                                                    ""),
                                                onValueChanged: (v) {},
                                                starBuilder: (index, color) =>
                                                    Icon(
                                                  Icons.star_rounded,
                                                  color: color,
                                                ),
                                                maxValueVisibility: false,
                                                valueLabelVisibility: false,
                                                starCount: 5,
                                                starSpacing: 2,
                                                starSize: 20,
                                                starColor: Color(0xffFFD633),
                                                starOffColor: Color(0xffC1C1C1),
                                              ),
                                            ],
                                          ),

                                          Container(
                                            width: MediaQuery.of(context).size.width / 2.5,
                                            child: WidgetButton.widgetOrangeButton("View Reviews", () {
                                                Get.to(()=> ReviewRestScreen(totalRating: double.parse(logic
                                                    .vendorProfileModel
                                                    .data
                                                    ?.restaurant
                                                    ?.ratings
                                                    .toString() ??
                                                    ""),totalReview: logic.vendorProfileModel.reviewCount,));
                                            }, fontSize: 16.0, buttonSize: 30.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                        height: 1,
                                        thickness: 1,
                                        color: Color(DIVIDERCOLOR)),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    // logic.vendorProfileModel.data!.restaurant!.restaurantDocument!.isEmpty ? Container() :
                                    logic.vendorProfileModel.data == null ||
                                            logic.vendorProfileModel.data
                                                    ?.vendorDocument?.isEmpty ==
                                                true
                                        ? Container()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: WidgetText
                                                    .widgetPoppinsText(
                                                        legalDocs),
                                              ),
                                              Container(
                                                height: 100,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: logic
                                                        .vendorProfileModel
                                                        .data
                                                        ?.vendorDocument
                                                        ?.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Container(
                                                        margin: EdgeInsets.only(
                                                            left: 20),
                                                        child: InkWell(
                                                          onTap: () {
                                                            if (logic
                                                                        .vendorProfileModel
                                                                        .data
                                                                        ?.vendorDocument?[
                                                                    index] !=
                                                                null) {
                                                              Get.to(() =>
                                                                  WidgetWebview(
                                                                    url: logic
                                                                            .vendorProfileModel
                                                                            .data
                                                                            ?.vendorDocument?[index] ??
                                                                        "",
                                                                    appbarName:
                                                                        legalDocs,
                                                                  ));
                                                            }
                                                          },
                                                          child: Image.asset(
                                                            ic_pdf,
                                                            width: 78,
                                                            height: 100,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    // scrollDirection: Axis.horizontal,
                                                    ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Divider(
                                                  height: 1,
                                                  thickness: 1,
                                                  color: Color(DIVIDERCOLOR)),
                                            ],
                                          ),

                                    SizedBox(
                                      height: 10,
                                    ),
                                    logic.vendorProfileModel.data == null ||
                                            logic
                                                    .vendorProfileModel
                                                    .data
                                                    ?.restaurant
                                                    ?.restaurantImg
                                                    ?.isEmpty ==
                                                true
                                        ? Container()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: WidgetText
                                                      .widgetPoppinsText(
                                                          restImages)),
                                              Container(
                                                height: 100,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: logic
                                                            .vendorProfileModel
                                                            .data
                                                            ?.restaurant
                                                            ?.restaurantImg
                                                            ?.length ??
                                                        2,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Container(
                                                        margin: EdgeInsets.only(
                                                            left: 20),
                                                        child: logic
                                                                    .vendorProfileModel
                                                                    .data
                                                                    ?.restaurant
                                                                    ?.restaurantImg?[index] ==
                                                                null
                                                            ? Image.asset(
                                                                ic_no_image,
                                                                width: 75,
                                                                height: 75,
                                                                fit:
                                                                    BoxFit.fill,
                                                              )
                                                            : InkWell(
                                                                onTap: () {
                                                                  Get.to(() =>
                                                                      WidgetWebview(
                                                                        url: logic.vendorProfileModel.data?.restaurant?.restaurantImg?[index] ??
                                                                            "",
                                                                        appbarName:
                                                                            restImages,
                                                                      ));
                                                                },
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      new BorderRadius
                                                                          .circular(
                                                                          10.0),
                                                                  child: Image
                                                                      .network(
                                                                    logic
                                                                            .vendorProfileModel
                                                                            .data
                                                                            ?.restaurant
                                                                            ?.restaurantImg?[index] ??
                                                                        "",
                                                                    width: 75,
                                                                    height: 75,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                              ),
                                                      );
                                                    }
                                                    // scrollDirection: Axis.horizontal,
                                                    ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Divider(
                                                  height: 1,
                                                  thickness: 1,
                                                  color: Color(DIVIDERCOLOR)),
                                            ],
                                          ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Color(WHITE),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            color: Color(ORANGE),
                          ),
                        );
                });
        }))));
  }

  Widget _profileFieldWidget(String title, String value) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetText.widgetPoppinsText(title),
          SizedBox(
            height: 5,
          ),
          WidgetText.widgetPoppinsMediumText(
            value,
            Color(BLACKINPUT),
            16,
          ),
          SizedBox(
            height: 10,
          ),
          // Divider(height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
        ],
      ),
    );
  }

  onClickEditProfile() async {
    await Get.to(() => ProfileTabScreen());
    vendorProfileGetController.getUserProfile();
    setState(() {});
  }
}

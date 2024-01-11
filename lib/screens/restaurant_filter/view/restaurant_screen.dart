import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import '../../../core/http_utils/http_constants.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_preferences.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../../cart/view/cart_screen.dart';
import '../../filter_dialog/filter_dialog_screen.dart';
import '../../restaurant_details/controller/restaurant_details_controller.dart';
import '../../restaurant_details/view/restaurant_details_screen.dart';
import '../controller/restaurant_filter_controller.dart';

class RestaurantFilterScreen extends StatefulWidget {

  @override
  State<RestaurantFilterScreen> createState() => _RestaurantFilterScreenState();
}

class _RestaurantFilterScreenState extends State<RestaurantFilterScreen> {
  final RestaurantFilterController restaurantFilterCtrl = Get.put(RestaurantFilterController());
  final restaurantDetailsController = Get.find<RestaurantDetailsController>();
  String lat = "", long = "";
  Map<String, String>? queryParams;
  String appbarName = "";
  // String value = "";
  List value = [];
  var filterValue1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefsData();
  }

  getSharedPrefsData() async {
    lat = (await AppPreferences.getLat())!;
    long = (await AppPreferences.getLong())!;
    debugPrint('Lat: $lat');
    debugPrint('Long: $long');
      setState(() {
        appbarName = restaurant;
      });
      debugPrint('Call Restaurant Api');
      queryParams = {
        HttpConstants.PARAMS_LAT: lat,
        HttpConstants.PARAMS_LONG: long,
        HttpConstants.PARAMS_DISTANCE: "500",
      };
    restaurantFilterCtrl.callRestaurantAPI(queryParams);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.transparent, //change your color here
        ),
        toolbarHeight: 60,
        shadowColor: Colors.transparent,
        backgroundColor: Color(WHITE),
        flexibleSpace: Container(
          height: double.infinity,
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          alignment: Alignment.bottomCenter,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: Image.asset(
                  ic_right_side_arrow,
                  width: 25,
                  color: Color(ORANGE),
                  height: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: WidgetText.widgetPoppinsRegularText(
                  nearbyRestaurant,
                  Color(BLACK),
                  16,
                ),
                flex: 1,
                fit: FlexFit.tight,
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: onClickApplyFilter,
                child: Image.asset(
                  ic_filter,
                  width: 30,
                  color: Color(BLACK),
                  height: 30,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                child: _restBody(),
                decoration: BoxDecoration(
                  color: Color(WHITE),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _restBody() {
    return GetBuilder<GetXNetworkManager>(builder: (networkManager) {
      return networkManager.connectionType == 0
          ? Center(child: Text(check_internet))
          : GetBuilder<RestaurantFilterController>(builder: (logic) {
        return logic.isLoaderVisible
            ? Center(
          child: CircularProgressIndicator(
            color: Color(ORANGE),
          ),
        ) 
            : logic.restaurantList.length == 0
            ? Center(
            child: Container(
              child: Text('Restaurant List Not Found'),
            ))
            : Container(
          margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisExtent:  270,
                mainAxisSpacing: 10),
            itemCount: logic.restaurantList.length,
            itemBuilder: (context, index) {
              bool statusOpen = false;
              bool restOpen = false;
              String start = "", end = "";

              if (logic.restaurantList[index].openingTime
                  ?.isNotEmpty ==
                  true ||
                  logic.restaurantList[index].closingTime
                      ?.isNotEmpty ==
                      true) {
                if (logic.restaurantList[index].openingTime != null ||
                    logic.restaurantList[index].closingTime != null) {
                  // bool statusOpen = false;
                  start = logic
                      .restaurantList[index].openingTime
                      .toString();
                  end = logic.restaurantList[index].closingTime
                      .toString();
                  debugPrint('CheckDate: ${isRestaurantOpen(start, end)}');

                  if(logic.restaurantList[index].timings?.day?.isNotEmpty == true) {
                    DateTime now = DateTime.now();
                    var d12 = formatterDay.format(now);
                    debugPrint('d12 : ${d12.toUpperCase()}');
                    // debugPrint('day : ${logic.restaurantList[index].day}');
                    List restDay = [];
                    dynamic daySplit = logic.restaurantList[index].timings?.day.toString().split(',').toSet()
                        .toList();
                    restDay = daySplit;
                    // int dayLen = int.parse(logic.restaurantList[index].day.toString().split(',').toString());
                    // debugPrint('dayLen: ${restDay.length}');
                    debugPrint('restDay day : ${restDay}');
                    for (int i = 0; i < restDay.length; i++) {
                      // debugPrint('restDay day : ${restDay[i]}');
                      if (restDay[i] == d12.toUpperCase()) {
                        debugPrint('restaurant open');
                        restOpen = true;
                        if (start.isNotEmpty) {
                          statusOpen =
                              isRestaurantOpen(start, end);
                          debugPrint('ISOPEN: $statusOpen');
                        }
                      }
                    }

                    if (restOpen == false) {
                      statusOpen = false;
                    }
                  }else{
                    if (start.isNotEmpty) {
                      statusOpen = isRestaurantOpen(start, end);
                      debugPrint('ISOPEN: $statusOpen');
                    }
                  }
                }
              }



              return Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(WHITE),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                      color: Color(ORANGE), width: 1),
                  borderRadius:
                  BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius:
                          BorderRadius.circular(10.0),
                          child:
                          Container(
                            height: 100,
                            width: 230,
                            child:  logic.restaurantList[index].restaurantImg?.isEmpty == true
                                ? Image.asset(
                                  ic_no_image,
                                  fit: BoxFit.fill,
                                )
                                : Image.network(
                              logic.restaurantList[index]
                                  .restaurantImg
                                  .toString(),
                              fit: BoxFit.fill,
                              loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Color(ORANGE),
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                              errorBuilder: (context, error,
                                  stackTrace) {
                                return Image.asset(
                                  ic_no_image,
                                  fit: BoxFit.fill,
                                );
                              },
                            ),),


                        ),
                        start == "" ? Container():
                        Positioned(
                          right: 0,
                          top: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:  statusOpen == true ?Color(ORANGE) : Color(RED),
                                  blurRadius: 3.0,
                                ),
                              ],
                              color: statusOpen == true ?Color(ORANGE) : Color(RED),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                bottomLeft:
                                Radius.circular(5.0),
                              ),
                            ),
                            height: 22,
                            width: 53,
                            alignment: Alignment.center,
                            child:  statusOpen == true
                                ? WidgetText
                                .widgetPoppinsMediumText(
                                open,
                                // "Open",
                                Color(WHITE),
                                12)
                                : WidgetText
                                .widgetPoppinsMediumText(
                                closed,
                                // "Open",
                                Color(WHITE),
                                12),
                          ),
                        ),
                        logic.restaurantList[index].deliveryTime == 0 || logic.restaurantList[index].deliveryTime == ""
                            ? Container()
                            : Positioned(
                          right: 7,
                          bottom: 7,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(WHITE),
                                  blurRadius: 3.0,
                                ),
                              ],
                              color: Color(WHITE),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5.0)),
                            ),
                            height: 26,
                            // width: 80,
                            width: MediaQuery.of(context).size.width / 5,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ic_timer,
                                  height: 15,
                                  width: 15,
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                // start == ""
                                WidgetText
                                    .widgetPoppinsMediumText(
                                    logic.restaurantList[index].deliveryTime.toString() + ' min',
                                    // "27 min",
                                    Color(BLACK),
                                    12)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: WidgetText.widgetPoppinsMediumText(
                          logic.restaurantList[index]
                              .restaurantName
                              .toString(),
                          Color(BLACK),
                          14,
                          align: TextAlign.center),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    logic.restaurantList[index].updateCategoryName == null ||
                        logic.restaurantList[index].updateCategoryName?.isEmpty == true
                        ? WidgetText
                        .widgetPoppinsRegularText(
                        "",
                        Color(SUBTEXTBLACKCOLOR),
                        14)
                        : WidgetText
                        .widgetPoppinsMaxLineOverflowText(
                        logic
                            .restaurantList[index]
                            .updateCategoryName
                            .toString(),
                        // "Italian",
                        Color(SUBTEXTBLACKCOLOR),
                        14, maxline: 1),
                    SizedBox(
                      height: 5,
                    ),
                    logic.restaurantList[index].totalDistance == null ||
                        logic.restaurantList[index].totalDistance?.isEmpty == true ? Container():
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ic_location_pin,
                          height: 15,
                          width: 15,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        // logic.restaurantList[index].distance == null ||
                        //     logic.restaurantList[index].distance!
                        //         .isEmpty == null ? Text('miles') :
                        WidgetText.widgetPoppinsRegularText(
                            (logic.restaurantList[index].totalDistance ?? "") + " miles", Color(BLACK),
                            14),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    logic.restaurantList[index].ratings == null || logic.restaurantList[index].ratings == "" ? Container() :
                    RatingStars(
                      value: double.parse(logic
                          .restaurantList[index]
                          .ratings
                          .toString()),
                      // 3.5,
                      onValueChanged: (v) {},
                      starBuilder: (index, color) => Icon(
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
                    SizedBox(
                      height: 10,
                    ),

                    Container(
                      height: 33,
                      width: 100,
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(7.0),
                            ),
                          ),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(
                            Color(ORANGE),
                          ),
                          minimumSize:
                          MaterialStateProperty.all<Size>(
                            Size(double.maxFinite, 45.0),
                          ),
                        ),
                        onPressed: () {
                          Get.to(() =>
                              RestaurantDetailsScreen(
                                restaurantid: logic
                                    .restaurantList[index]
                                    .restaurantId
                                    .toString(),
                              ));
                        },
                        child: WidgetText.widgetPoppinsMediumText(
                            "View More", Color(WHITE), 12),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      });
    });
  }

  onClickCart() async {
    await Get.to(() => CartScreen());
    setState(() {
      getSharedPrefsData();
    });
  }

  onClickApplyFilter() async {

    final filterValue = await Get.to(() => FilterDialogScreen(filterValue: filterValue1,));
    var foodType, distance;
    setState(() {
      this.value = filterValue;
      debugPrint('FilterValue: $filterValue');
      filterValue1 = filterValue;
      foodType = filterValue[0].join(",");
      debugPrint('foodType List: $foodType');
      distance = filterValue[1];
      debugPrint('distance: $distance');
    });

      queryParams = {
        HttpConstants.PARAMS_LAT: lat,
        HttpConstants.PARAMS_LONG: long,
        HttpConstants.PARAMS_FOODTYPES: foodType.toString(),
        HttpConstants.PARAMS_DISTANCE: distance,
      };
      debugPrint('Params: $queryParams');
    restaurantFilterCtrl.callRestaurantAPI(queryParams);
    }

  onClickFoodDetail() {
    // Get.to(() => FoodDetailScreen());
  }
}

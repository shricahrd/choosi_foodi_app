import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_radio_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/cart/view/cart_screen.dart';
import 'package:choosifoodi/screens/group_orders/view/create_group_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_preferences.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../../base_application/base_application.dart';
import '../../food_detail/food_item_add_screen.dart';
import '../../home/controller/testimonials_controller.dart';
import '../../home/view/testimonials_screen.dart';
import '../../orders/view/group_order/view_group_order_screen.dart';
import '../controller/restaurant_details_controller.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  dynamic restaurantid;

  RestaurantDetailsScreen({required this.restaurantid});

  static bool _isGroupOrder = false;

  static bool getIsGroupOrder() {
    return _isGroupOrder;
  }

  static void setIsGroupOrder(bool bool) {
    _isGroupOrder = bool;
  }

  @override
  _RestaurantDetailsScreenState createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  final RestaurantDetailsController userHomeController =
      Get.put(RestaurantDetailsController());
  final TestimonialsController _testimonialsController =
      Get.put(TestimonialsController());

  int _orderTypeValue = 0;

  // int _addItemInCart = 0;
  String lat = "", long = "";
  int caloriesBefore = 0;
  int fatBefore = 0;
  int carbsBefore = 0;
  int proteinBefore = 0;
  dynamic groupId;

  // List<GetCustomCartModel> getCustomModelList = [];

  @override
  void initState() {
    debugPrint('init');
    userHomeController.isLoaderVisible = true;
    getSharedPrefsData();
    userHomeController.callGetCartAPI(restaurantId: widget.restaurantid);
    super.initState();
  }

  getSharedPrefsData() async {
    lat = (await AppPreferences.getLat())!;
    long = (await AppPreferences.getLong())!;
    groupId = await AppPreferences.getGroupId();
    debugPrint('groupId: $groupId');
    if (groupId != null) {
      if (groupId != "") {
        RestaurantDetailsScreen._isGroupOrder = true;
        debugPrint('IsGroupOrder not null: ${RestaurantDetailsScreen._isGroupOrder}');
      } else {
        RestaurantDetailsScreen._isGroupOrder = false;
        debugPrint('IsGroupOrder null: ${RestaurantDetailsScreen._isGroupOrder}');
      }
    } else {
      RestaurantDetailsScreen._isGroupOrder = false;
      debugPrint('IsGroupOrder null: ${RestaurantDetailsScreen._isGroupOrder}');
    }
    userHomeController.callRestaurantDetailsAPI(
      restaurantId: widget.restaurantid,
      lat: lat,
      long: long,
    );
    _testimonialsController.callRestaurantReviewListAPI(widget.restaurantid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(WHITE),
        child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
          return networkManager.connectionType == 0
              ? Center(child: Text(check_internet))
              : GetBuilder<RestaurantDetailsController>(builder: (logic) {
                
                  return logic.isLoaderVisible == false ?
                          Scaffold(
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
                                    onTap: () {
                                      Get.offAll(() => BaseApplication());
                                    },
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
                                    child: WidgetText.widgetPoppinsMaxLineOverflowText(
                                      logic.restaurantDetailsModel.data
                                                      ?.restaurantName ==
                                                  null ||
                                              logic.restaurantDetailsModel.data
                                                      ?.restaurantName ==
                                                  ""
                                          ? 'Restaurant Name'
                                          : logic.restaurantDetailsModel.data!
                                              .restaurantName
                                              .toString(),
                                      Color(BLACK),
                                      18,
                                    ),
                                    flex: 1,
                                    fit: FlexFit.tight,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          body:
                          logic.restaurantDetailsModel.meta?.status == false
                              ? Center(
                              child: Container(
                                  color: Color(WHITE),
                                  child: WidgetText.widgetPoppinsMediumText(
                                      'Restaurant Details Not Found',
                                      Color(BLACK),
                                      16))) :
                              Stack(
                            children: [
                              SafeArea(
                                child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  children: [
                                    Stack(
                                      children: [
                                        logic.restaurantDetailsModel.data
                                                    ?.restaurantImg?.first ==
                                                null
                                            ? Image.asset(
                                                ic_no_image,
                                                height: 210,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                logic.restaurantDetailsModel.data?.restaurantImg?.first.toString() ?? "",
                                                height: 210,
                                                width: double.infinity,
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
                                                errorBuilder:
                                                    (context, error, stackTrace) {
                                                  return Image.asset(
                                                    ic_no_image,
                                                    height: 210,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              ),
                                        Positioned(
                                          right: 0,
                                          top: 10,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(ORANGE),
                                                  blurRadius: 3.0,
                                                ),
                                              ],
                                              color:  logic.statusOpen == true ?Color(ORANGE) : Color(RED),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5.0),
                                                bottomLeft: Radius.circular(5.0),
                                              ),
                                            ),
                                            height: 30,
                                            width: 70,
                                            alignment: Alignment.center,
                                            child: logic.start == null
                                                ? Text('')
                                                : logic.statusOpen == true
                                                    ? WidgetText
                                                        .widgetPoppinsMediumText(
                                                            open,
                                                            Color(WHITE),
                                                            14)
                                                    : WidgetText
                                                        .widgetPoppinsMediumText(
                                                            closed,
                                                            Color(WHITE),
                                                            14),
                                          ),
                                        ),
                                        Positioned(
                                          right: 10,
                                          bottom: 10,
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
                                            height: 35,
                                            width: 100,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  ic_timer,
                                                  height: 20,
                                                  width: 20,
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                logic.restaurantDetailsModel.data?.deliveryTime == null
                                                    ? Text('')
                                                    : WidgetText
                                                        .widgetPoppinsMediumText(
                                                       (logic.restaurantDetailsModel.data?.deliveryTime.toString() ?? "") +
                                                                " min",
                                                            Color(BLACK),
                                                            14)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              logic.restaurantDetailsModel.data!
                                                          .restaurantName ==
                                                      null
                                                  ? Text('')
                                                  : WidgetText
                                                      .widgetPoppinsMediumText(
                                                          logic
                                                              .restaurantDetailsModel
                                                              .data!
                                                              .restaurantName
                                                              .toString(),
                                                          Color(BLACK),
                                                          18),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              WidgetText.widgetPoppinsMediumText(
                                                  // "Italian",
                                                  logic.foodTypeData ?? "",
                                                  Color(SUBTEXTBLACKCOLOR),
                                                  16),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    ic_location_pin,
                                                    height: 25,
                                                    width: 25,
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  logic.arrDistance == null
                                                      ? Text('')
                                                      : WidgetText
                                                          .widgetPoppinsMediumText(
                                                              logic.arrDistance +
                                                                  " miles",
                                                              Color(BLACK),
                                                              14),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  WidgetText
                                                      .widgetPoppinsMediumText(
                                                          "Delivery : ",
                                                          Color(BLACK),
                                                          14),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  logic.restaurantDetailsModel
                                                              .data!.isDelivery ==
                                                          true
                                                      ? WidgetText
                                                          .widgetPoppinsBoldText(
                                                              "Available",
                                                              Color(BLACK),
                                                              14)
                                                      : WidgetText
                                                          .widgetPoppinsBoldText(
                                                              "Not Available",
                                                              Color(BLACK),
                                                              14),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(
                                                children: [
                                                  WidgetText
                                                      .widgetPoppinsMediumText(
                                                          "Pickup : ",
                                                          Color(BLACK),
                                                          14),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  logic.restaurantDetailsModel
                                                              .data!.isPickup ==
                                                          true
                                                      ? WidgetText
                                                          .widgetPoppinsBoldText(
                                                              "Available",
                                                              Color(BLACK),
                                                              14)
                                                      : WidgetText
                                                          .widgetPoppinsBoldText(
                                                              "Not Available",
                                                              Color(BLACK),
                                                              14),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              RestaurantDetailsScreen
                                                      ._isGroupOrder
                                                  ? Container(
                                                      width: 250,
                                                      child: WidgetButton
                                                          .widgetDefaultButton(
                                                              "VIEW GROUP ORDER",
                                                              () {
                                                        if (groupId != "") {
                                                          onClickViewGroupOrder(
                                                            groupId,
                                                          );
                                                        }
                                                      }),
                                                    )
                                                  : Container(
                                                      // width: 250,
                                                      width: MediaQuery.of(context).size.width / 1.3,
                                                      alignment: Alignment.center,
                                                      child: ElevatedButton(
                                                        style: ButtonStyle(
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                            Color(ORANGE),
                                                          ),
                                                          minimumSize:
                                                              MaterialStateProperty
                                                                  .all<Size>(
                                                            Size(double.maxFinite,
                                                                55.0),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          List cordinateArray = [lat, long];
                                                          debugPrint('cordinateArray: $cordinateArray');
                                                          onClickGroupOrder(
                                                            logic
                                                                .restaurantDetailsModel.data?.restaurantId.toString() ?? "",
                                                            logic
                                                                .restaurantDetailsModel.data?.isPickup,
                                                            cordinates: cordinateArray
                                                          );
                                                        },
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Image.asset(
                                                              ic_plus,
                                                              height: 18,
                                                              width: 18,
                                                              color: Color(WHITE),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            WidgetText
                                                                .widgetPoppinsMediumText(
                                                              "CREATE GROUP ORDER",
                                                              Colors.white,
                                                              16,
                                                              align:
                                                                  TextAlign.end,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              RestaurantDetailsScreen
                                                      ._isGroupOrder
                                                  ? Container()
                                                  : Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              logic.restaurantDetailsModel.data!
                                                                          .isDelivery ==
                                                                      true
                                                                  ? Expanded(
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            if (logic.restaurantDetailsModel.data!.isDelivery ==
                                                                                true) {
                                                                              _orderTypeValue =
                                                                                  0;
                                                                            } else {
                                                                              _orderTypeValue =
                                                                                  1;
                                                                              showToastMessage('Not Available');
                                                                            }
                                                                          });
                                                                        },
                                                                        child: _orderTypeValue ==
                                                                                0
                                                                            ? WidgetRadioButton.selectedRadioButton(
                                                                                "Delivery")
                                                                            : WidgetRadioButton.unselectedRadioButton(
                                                                                "Delivery"),
                                                                      ),
                                                                    )
                                                                  : Expanded(
                                                                      child:
                                                                          Container(),
                                                                    ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              logic.restaurantDetailsModel.data!
                                                                          .isPickup ==
                                                                      true
                                                                  ? Expanded(
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            if (logic.restaurantDetailsModel.data!.isPickup ==
                                                                                true) {
                                                                              _orderTypeValue =
                                                                                  1;
                                                                            } else {
                                                                              _orderTypeValue =
                                                                                  0;
                                                                              showToastMessage('Not Available');
                                                                            }
                                                                          });
                                                                        },
                                                                        child: _orderTypeValue ==
                                                                                1
                                                                            ? WidgetRadioButton.selectedRadioButton(
                                                                                "Pickup")
                                                                            : WidgetRadioButton.unselectedRadioButton(
                                                                                "Pickup"),
                                                                      ),
                                                                    )
                                                                  : Expanded(
                                                                      child:
                                                                          Container(),
                                                                    ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Container(),
                                                        ),
                                                      ],
                                                    ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                            height: 5,
                                            thickness: 5,
                                            color: Color(LIGHTDIVIDERCOLOR)),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(15, 0, 0, 0),
                                          child:
                                              WidgetText.widgetPoppinsMediumText(
                                            "Foodi Menu",
                                            Color(BLACK),
                                            18,
                                          ),
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: logic
                                                .restaurantDetailsModel
                                                .data
                                                ?.menus
                                                ?.length,
                                            itemBuilder: (context, index) {

                                              bool statusOpen = false;
                                              String start = logic
                                                  .restaurantDetailsModel
                                                  .data
                                                  ?.menus?[index]
                                                  .dishVisibilityStart
                                                  .toString() ?? "";
                                              String end = logic
                                                  .restaurantDetailsModel
                                                  .data
                                                  ?.menus?[index]
                                                  .dishVisibilityEnd
                                                  .toString() ?? "";

                                              if(start.split(":").last.split(" ").last.toLowerCase().contains('am') || start.split(":").last.split(" ").last.toLowerCase().contains('pm')){
                                                int h = int.parse(start.split(":").first);
                                                int m = int.parse(start.split(":").last.split(" ").first);
                                                String meridium = start.split(":").last.split(" ").last.toLowerCase();
                                                if (meridium == "pm") {
                                                  if (h != 12) {
                                                    h = h + 12;
                                                  }
                                                }
                                                if (meridium == "am") {
                                                  if (h == 12) {
                                                    h = 00;
                                                  }
                                                }
                                                String newStartTime = "${h == 0 ? "00" : h}:${m == 0 ? "00" : m}";
                                                int endHour = int.parse(start.split(":").first);
                                                int endMin = int.parse(start.split(":").last.split(" ").first);
                                                String endMeridium = start.split(":").last.split(" ").last.toLowerCase();
                                                if (endMeridium == "pm") {
                                                  if (endHour != 12) {
                                                    endHour = endHour + 12;
                                                  }
                                                }
                                                if (endMeridium == "am") {
                                                  if (endHour == 12) {
                                                    endHour = 00;
                                                  }
                                                }
                                                String newEndTime = "${endHour == 0 ? "00" : endHour}:${endMin == 0 ? "00" : endMin}";
                                                debugPrint('newStartTime: $newStartTime , newEndTime : $newEndTime');

                                                debugPrint('CheckDate: ${isRestaurantOpen(newStartTime, newEndTime)}');
                                                if (newStartTime.isNotEmpty) {
                                                  statusOpen = isRestaurantOpen(newStartTime, newEndTime);
                                                  debugPrint('ISOPEN: $statusOpen');
                                                }
                                              }else {
                                                debugPrint(
                                                    'CheckDate: ${isRestaurantOpen(
                                                        start, end)}');
                                                if (start.isNotEmpty) {
                                                  statusOpen = isRestaurantOpen(
                                                      start, end);
                                                  debugPrint('ISOPEN: $statusOpen');
                                                }
                                              }

                                              return logic.restaurantDetailsModel
                                                          .data?.menus?.length ==
                                                      0
                                                  ? Container()
                                                  : logic.restaurantDetailsModel
                                                              .data?.menus ==
                                                          null
                                                      ? Container()
                                                      : Container(
                                                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                                        decoration: BoxDecoration(
                                                          color: statusOpen == true?Color(WHITE) : Color(GREY6).withOpacity(0.5),
                                                        ),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    width: 110,
                                                                    height: 95,
                                                                    child:   logic
                                                                        .restaurantDetailsModel.data?.menus?[index].menuImg?.isEmpty == true
                                                                        ? Image
                                                                        .asset(
                                                                      ic_no_image,
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    )   : ClipRRect(
                                                                      borderRadius:
                                                                      BorderRadius.circular(10.0),
                                                                      child: Image
                                                                          .network(
                                                                        logic
                                                                            .restaurantDetailsModel.data?.menus?[index].menuImg?.first.toString() ?? "",
                                                                        fit: BoxFit
                                                                            .fill,
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
                                                                        errorBuilder: (context,
                                                                            error,
                                                                            stackTrace) {
                                                                          return Image.asset(
                                                                            ic_no_image,
                                                                            fit: BoxFit.fill,
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),


                                                                  SizedBox(
                                                                    width: 15,
                                                                  ),
                                                                  Expanded(
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        logic.restaurantDetailsModel.data?.menus?[index].dishName ==
                                                                                null
                                                                            ? Text(
                                                                                '')
                                                                            : WidgetText
                                                                                .widgetPoppinsMediumText(
                                                                                logic.restaurantDetailsModel.data!.menus![index].dishName.toString(),
                                                                                Color(BLACK),
                                                                                16,
                                                                              ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Container(
                                                                          padding: EdgeInsets.fromLTRB(
                                                                              10,
                                                                              3,
                                                                              10,
                                                                              3),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(WHITE),
                                                                            shape:
                                                                                BoxShape.rectangle,
                                                                            border: Border.all(
                                                                                color: Color(BORDERCOLOR),
                                                                                width: 1),
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(20)),
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children: [
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  if(statusOpen == true) {
                                                                                    int _quantity = 0;
                                                                                    setState(() {
                                                                                      debugPrint(
                                                                                          'Select Quantitity: ${logic
                                                                                              .restaurantDetailsModel
                                                                                              .data!
                                                                                              .menus![index]
                                                                                              .selectQuantity}');
                                                                                      _quantity =
                                                                                          logic
                                                                                              .restaurantDetailsModel
                                                                                              .data!
                                                                                              .menus![index]
                                                                                              .selectQuantity;
                                                                                    });
                                                                                    // debugPrint('Quantitity: $_quantity');
                                                                                    if (_quantity != null) {
                                                                                      if (_quantity ==
                                                                                          1) {
                                                                                        showToastMessage(
                                                                                            'Minimum order 1 Quantity');
                                                                                      } else {
                                                                                        // logic.decrementQtyApi(restaurantId: widget.restaurantid, menuId: logic.restaurantDetailsModel.data!.menus![index].menuId.toString(), selectQty: 1);

                                                                                        setState(() {
                                                                                          debugPrint(
                                                                                              'Quantitity: $_quantity');
                                                                                          _quantity--;

                                                                                          //Calories calculation
                                                                                          if (logic
                                                                                              .restaurantDetailsModel
                                                                                              .data!
                                                                                              .menus![index]
                                                                                              .calories !=
                                                                                              null) {
                                                                                            if (logic
                                                                                                .restaurantDetailsModel
                                                                                                .data!
                                                                                                .menus![index]
                                                                                                .calories !=
                                                                                                0) {
                                                                                              caloriesBefore =
                                                                                                  int
                                                                                                      .parse(
                                                                                                      logic
                                                                                                          .restaurantDetailsModel
                                                                                                          .data!
                                                                                                          .menus![index]
                                                                                                          .calories
                                                                                                          .toString());
                                                                                              int calories = _quantity *
                                                                                                  caloriesBefore;
                                                                                              logic
                                                                                                  .restaurantDetailsModel
                                                                                                  .data!
                                                                                                  .menus![index]
                                                                                                  .setCalories =
                                                                                                  calories;
                                                                                              debugPrint(
                                                                                                  'calories model: ${logic
                                                                                                      .restaurantDetailsModel
                                                                                                      .data!
                                                                                                      .menus![index]
                                                                                                      .calories
                                                                                                      .toString()}');
                                                                                            } else {
                                                                                              caloriesBefore =
                                                                                              0;
                                                                                            }
                                                                                          } else {
                                                                                            caloriesBefore =
                                                                                            0;
                                                                                          }

                                                                                          //Fat calculation
                                                                                          if (logic
                                                                                              .restaurantDetailsModel
                                                                                              .data!
                                                                                              .menus![index]
                                                                                              .fat !=
                                                                                              null) {
                                                                                            if (logic
                                                                                                .restaurantDetailsModel
                                                                                                .data!
                                                                                                .menus![index]
                                                                                                .fat !=
                                                                                                0) {
                                                                                              fatBefore =
                                                                                                  int
                                                                                                      .parse(
                                                                                                      logic
                                                                                                          .restaurantDetailsModel
                                                                                                          .data!
                                                                                                          .menus![index]
                                                                                                          .fat
                                                                                                          .toString());
                                                                                              int fat = _quantity *
                                                                                                  fatBefore;
                                                                                              logic
                                                                                                  .restaurantDetailsModel
                                                                                                  .data!
                                                                                                  .menus![index]
                                                                                                  .setFat =
                                                                                                  fat;
                                                                                              debugPrint(
                                                                                                  'fat model: ${logic
                                                                                                      .restaurantDetailsModel
                                                                                                      .data!
                                                                                                      .menus![index]
                                                                                                      .fat
                                                                                                      .toString()}');
                                                                                            } else {
                                                                                              fatBefore =
                                                                                              0;
                                                                                            }
                                                                                          } else {
                                                                                            fatBefore =
                                                                                            0;
                                                                                          }

                                                                                          //Carbs calculation
                                                                                          if (logic
                                                                                              .restaurantDetailsModel
                                                                                              .data!
                                                                                              .menus![index]
                                                                                              .carbs !=
                                                                                              null) {
                                                                                            if (logic
                                                                                                .restaurantDetailsModel
                                                                                                .data!
                                                                                                .menus![index]
                                                                                                .carbs !=
                                                                                                0) {
                                                                                              carbsBefore =
                                                                                                  int
                                                                                                      .parse(
                                                                                                      logic
                                                                                                          .restaurantDetailsModel
                                                                                                          .data!
                                                                                                          .menus![index]
                                                                                                          .carbs
                                                                                                          .toString());
                                                                                              int carbs = _quantity *
                                                                                                  carbsBefore;
                                                                                              // debugPrint('carbs: ${carbs.toString()}');
                                                                                              logic
                                                                                                  .restaurantDetailsModel
                                                                                                  .data!
                                                                                                  .menus![index]
                                                                                                  .setCarbs =
                                                                                                  carbs;
                                                                                              // debugPrint('carbs model: ${logic.restaurantDetailsModel.data!.menus![index].carbs.toString()}');
                                                                                            } else {
                                                                                              carbsBefore =
                                                                                              0;
                                                                                            }
                                                                                          } else {
                                                                                            carbsBefore =
                                                                                            0;
                                                                                          }

                                                                                          //Protein calculation
                                                                                          if (logic
                                                                                              .restaurantDetailsModel
                                                                                              .data!
                                                                                              .menus![index]
                                                                                              .protein !=
                                                                                              null) {
                                                                                            if (logic
                                                                                                .restaurantDetailsModel
                                                                                                .data!
                                                                                                .menus![index]
                                                                                                .protein !=
                                                                                                0) {
                                                                                              proteinBefore =
                                                                                                  int
                                                                                                      .parse(
                                                                                                      logic
                                                                                                          .restaurantDetailsModel
                                                                                                          .data!
                                                                                                          .menus![index]
                                                                                                          .protein
                                                                                                          .toString());
                                                                                              int protein = _quantity *
                                                                                                  proteinBefore;
                                                                                              logic
                                                                                                  .restaurantDetailsModel
                                                                                                  .data!
                                                                                                  .menus![index]
                                                                                                  .setProtein =
                                                                                                  protein;
                                                                                              // debugPrint('protein model: ${logic.restaurantDetailsModel.data!.menus![index].protein.toString()}');
                                                                                            } else {
                                                                                              proteinBefore =
                                                                                              0;
                                                                                            }
                                                                                          } else {
                                                                                            proteinBefore =
                                                                                            0;
                                                                                          }
                                                                                        });
                                                                                      }

                                                                                      setState(() {
                                                                                        logic
                                                                                            .restaurantDetailsModel
                                                                                            .data!
                                                                                            .menus![index]
                                                                                            .setQuantity =
                                                                                            _quantity;
                                                                                        // debugPrint('Quantitity: $_quantity');

                                                                                        var price = _quantity *
                                                                                            int
                                                                                                .parse(
                                                                                                logic
                                                                                                    .restaurantDetailsModel
                                                                                                    .data!
                                                                                                    .menus![index]
                                                                                                    .price
                                                                                                    .toString());
                                                                                        // debugPrint('Price: $price');
                                                                                        logic
                                                                                            .restaurantDetailsModel
                                                                                            .data!
                                                                                            .menus![index]
                                                                                            .setPrice =
                                                                                            price;
                                                                                      });
                                                                                    }
                                                                                  }
                                                                                },
                                                                                child: Image.asset(
                                                                                  ic_descrease,
                                                                                  width: 15,
                                                                                  height: 15,
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              WidgetText.widgetPoppinsMediumText(
                                                                                logic.restaurantDetailsModel.data!.menus![index].selectQuantity.toString(),
                                                                                // "1",
                                                                                Color(BLACK),
                                                                                14,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              InkWell(
                                                                                child: Image.asset(
                                                                                  ic_increase,
                                                                                  width: 15,
                                                                                  height: 15,
                                                                                ),
                                                                                onTap: () {
                                                                                  if(statusOpen == true) {
                                                                                    setState(() {
                                                                                      int? _quantity = logic
                                                                                          .restaurantDetailsModel
                                                                                          .data!
                                                                                          .menus![index]
                                                                                          .selectQuantity;
                                                                                      if (_quantity !=
                                                                                          null) {
                                                                                        // debugPrint('Quantitity plus: $_quantity');
                                                                                        _quantity++;
                                                                                        logic
                                                                                            .restaurantDetailsModel
                                                                                            .data!
                                                                                            .menus![index]
                                                                                            .setQuantity =
                                                                                            _quantity;

                                                                                        // logic.incrementQtyApi(restaurantId: widget.restaurantid, menuId: logic.restaurantDetailsModel.data!.menus![index].menuId.toString(), selectQty: 1);

                                                                                        //Calories calculation
                                                                                        if (logic
                                                                                            .restaurantDetailsModel
                                                                                            .data!
                                                                                            .menus![index]
                                                                                            .calories !=
                                                                                            null) {
                                                                                          if (logic
                                                                                              .restaurantDetailsModel
                                                                                              .data!
                                                                                              .menus![index]
                                                                                              .calories !=
                                                                                              0) {
                                                                                            caloriesBefore =
                                                                                                int
                                                                                                    .parse(
                                                                                                    logic
                                                                                                        .restaurantDetailsModel
                                                                                                        .data!
                                                                                                        .menus![index]
                                                                                                        .calories
                                                                                                        .toString());
                                                                                            int calories = _quantity *
                                                                                                caloriesBefore;
                                                                                            logic
                                                                                                .restaurantDetailsModel
                                                                                                .data!
                                                                                                .menus![index]
                                                                                                .setCalories =
                                                                                                calories;
                                                                                            // debugPrint('calories model: ${logic.restaurantDetailsModel.data!.menus![index].calories.toString()}');
                                                                                          } else {
                                                                                            caloriesBefore =
                                                                                            0;
                                                                                          }
                                                                                        } else {
                                                                                          caloriesBefore =
                                                                                          0;
                                                                                        }

                                                                                        //Fat calculation
                                                                                        if (logic
                                                                                            .restaurantDetailsModel
                                                                                            .data!
                                                                                            .menus![index]
                                                                                            .fat !=
                                                                                            null) {
                                                                                          if (logic
                                                                                              .restaurantDetailsModel
                                                                                              .data!
                                                                                              .menus![index]
                                                                                              .fat !=
                                                                                              0) {
                                                                                            // debugPrint('===> ${logic.restaurantDetailsModel.data!.menus![index].fat.toString()}')
                                                                                            fatBefore =
                                                                                                int
                                                                                                    .parse(
                                                                                                    logic
                                                                                                        .restaurantDetailsModel
                                                                                                        .data!
                                                                                                        .menus![index]
                                                                                                        .fat
                                                                                                        .toString());
                                                                                            int fat = _quantity *
                                                                                                fatBefore;
                                                                                            logic
                                                                                                .restaurantDetailsModel
                                                                                                .data!
                                                                                                .menus![index]
                                                                                                .setFat =
                                                                                                fat;
                                                                                            // debugPrint('fat model: ${logic.restaurantDetailsModel.data!.menus![index].fat.toString()}');
                                                                                          } else {
                                                                                            fatBefore =
                                                                                            0;
                                                                                          }
                                                                                        } else {
                                                                                          fatBefore =
                                                                                          0;
                                                                                        }

                                                                                        //Carbs calculation
                                                                                        if (logic
                                                                                            .restaurantDetailsModel
                                                                                            .data!
                                                                                            .menus![index]
                                                                                            .carbs !=
                                                                                            null) {
                                                                                          if (logic
                                                                                              .restaurantDetailsModel
                                                                                              .data!
                                                                                              .menus![index]
                                                                                              .carbs !=
                                                                                              0) {
                                                                                            carbsBefore =
                                                                                                int
                                                                                                    .parse(
                                                                                                    logic
                                                                                                        .restaurantDetailsModel
                                                                                                        .data!
                                                                                                        .menus![index]
                                                                                                        .carbs
                                                                                                        .toString());
                                                                                            int carbs = _quantity *
                                                                                                carbsBefore;
                                                                                            // debugPrint('carbs: ${carbs.toString()}');
                                                                                            logic
                                                                                                .restaurantDetailsModel
                                                                                                .data!
                                                                                                .menus![index]
                                                                                                .setCarbs =
                                                                                                carbs;
                                                                                            // debugPrint('carbs model: ${logic.restaurantDetailsModel.data!.menus![index].carbs.toString()}');
                                                                                          } else {
                                                                                            carbsBefore =
                                                                                            0;
                                                                                          }
                                                                                        } else {
                                                                                          carbsBefore =
                                                                                          0;
                                                                                        }

                                                                                        //Protein calculation
                                                                                        if (logic
                                                                                            .restaurantDetailsModel
                                                                                            .data!
                                                                                            .menus![index]
                                                                                            .protein !=
                                                                                            null) {
                                                                                          if (logic
                                                                                              .restaurantDetailsModel
                                                                                              .data!
                                                                                              .menus![index]
                                                                                              .protein !=
                                                                                              0) {
                                                                                            proteinBefore =
                                                                                                int
                                                                                                    .parse(
                                                                                                    logic
                                                                                                        .restaurantDetailsModel
                                                                                                        .data!
                                                                                                        .menus![index]
                                                                                                        .protein
                                                                                                        .toString());
                                                                                            int protein = _quantity *
                                                                                                proteinBefore;
                                                                                            logic
                                                                                                .restaurantDetailsModel
                                                                                                .data!
                                                                                                .menus![index]
                                                                                                .setProtein =
                                                                                                protein;
                                                                                            // debugPrint('protein model: ${logic.restaurantDetailsModel.data!.menus![index].protein.toString()}');
                                                                                          } else {
                                                                                            proteinBefore =
                                                                                            0;
                                                                                          }
                                                                                        } else {
                                                                                          proteinBefore =
                                                                                          0;
                                                                                        }

                                                                                        var price = _quantity *
                                                                                            int
                                                                                                .parse(
                                                                                                logic
                                                                                                    .restaurantDetailsModel
                                                                                                    .data!
                                                                                                    .menus![index]
                                                                                                    .price
                                                                                                    .toString());
                                                                                        // debugPrint('Price: $price');
                                                                                        logic
                                                                                            .restaurantDetailsModel
                                                                                            .data!
                                                                                            .menus![index]
                                                                                            .setPrice =
                                                                                            price;
                                                                                      }
                                                                                    });
                                                                                  }
                                                                                },
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        logic.restaurantDetailsModel.data!.menus![index].calculatePrice ==
                                                                                null
                                                                            ? Text(
                                                                                '')
                                                                            : WidgetText
                                                                                .widgetPoppinsMediumText(
                                                                                "\$" + logic.restaurantDetailsModel.data!.menus![index].calculatePrice.toString(),
                                                                                Color(ORANGE),
                                                                                14,
                                                                              )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              0,
                                                                              15,
                                                                              0,
                                                                              15),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0xffF9F7F8),
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                                Radius.circular(10)),
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .center,
                                                                        children: [
                                                                          WidgetText
                                                                              .widgetPoppinsRegularText(
                                                                            "Calories",
                                                                            Color(
                                                                                BLACK),
                                                                            13,
                                                                          ),
                                                                          WidgetText
                                                                              .widgetPoppinsMediumText(
                                                                            logic.restaurantDetailsModel.data!.menus![index].calculateCalories.toString(),
                                                                            Color(
                                                                                BLACK),
                                                                            14,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 15,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              0,
                                                                              15,
                                                                              0,
                                                                              15),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0xffF9F7F8),
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                                Radius.circular(10)),
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .center,
                                                                        children: [
                                                                          WidgetText
                                                                              .widgetPoppinsRegularText(
                                                                            "Fat",
                                                                            Color(
                                                                                BLACK),
                                                                            13,
                                                                          ),
                                                                          WidgetText
                                                                              .widgetPoppinsMediumText(
                                                                            logic.restaurantDetailsModel.data!.menus![index].calculateFat.toString() +
                                                                                "gm",
                                                                            Color(
                                                                                BLACK),
                                                                            14,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 15,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              0,
                                                                              15,
                                                                              0,
                                                                              15),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0xffF9F7F8),
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                                Radius.circular(10)),
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .center,
                                                                        children: [
                                                                          WidgetText
                                                                              .widgetPoppinsRegularText(
                                                                            "Carbs",
                                                                            Color(
                                                                                BLACK),
                                                                            13,
                                                                          ),
                                                                          WidgetText
                                                                              .widgetPoppinsMediumText(
                                                                            logic.restaurantDetailsModel.data!.menus![index].calculateCarbs.toString() +
                                                                                "gm",
                                                                            Color(
                                                                                BLACK),
                                                                            14,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 15,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets
                                                                          .fromLTRB(
                                                                              0,
                                                                              15,
                                                                              0,
                                                                              15),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0xffF9F7F8),
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                                Radius.circular(10)),
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .center,
                                                                        children: [
                                                                          WidgetText
                                                                              .widgetPoppinsRegularText(
                                                                            "Protein",
                                                                            Color(
                                                                                BLACK),
                                                                            13,
                                                                          ),
                                                                          WidgetText
                                                                              .widgetPoppinsMediumText(
                                                                            logic.restaurantDetailsModel.data!.menus![index].calculateProtein.toString() +
                                                                                "gm",
                                                                            Color(
                                                                                BLACK),
                                                                            14,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: logic
                                                                            .restaurantDetailsModel.data?.menus?[index]
                                                                            .description ==
                                                                        null
                                                                    ? Text('')
                                                                    : WidgetText
                                                                        .widgetPoppinsRegularMaxOverflowText(
                                                                        logic
                                                                            .restaurantDetailsModel
                                                                            .data!
                                                                            .menus![
                                                                                index]
                                                                            .description
                                                                            .toString()
                                                                            .replaceAll(
                                                                                RegExp(r'<[^>]*>|&[^;]+;'),
                                                                                ' '),
                                                                        Color(
                                                                            BLACK),
                                                                        14,
                                                                      ),
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),

                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  logic
                                                                              .restaurantDetailsModel
                                                                              .data!
                                                                              .menus![index]
                                                                              .isAddToCart ==
                                                                          false
                                                                      ? Flexible(
                                                                          child:
                                                                              InkWell(
                                                                            onTap: () async {
                                                                              if(logic.statusOpen == true) {
                                                                                if (statusOpen == true) {
                                                                                  // debugPrint('Check Condition');
                                                                                  if (logic
                                                                                      .restaurantDetailsModel
                                                                                      .data
                                                                                      ?.menus?[index]
                                                                                      .isAddOnEnable ==
                                                                                      true) {
                                                                                    debugPrint(
                                                                                        'If Condition');
                                                                                    if (RestaurantDetailsScreen
                                                                                        ._isGroupOrder ==
                                                                                        false) {
                                                                                      Get.to(() =>
                                                                                          FoodItemAddScreen(
                                                                                            otherAddonsList: logic
                                                                                                .restaurantDetailsModel.data?.menus?[index].otherAddons,
                                                                                            foodTitle: logic
                                                                                                .restaurantDetailsModel.data?.menus?[index].dishName.toString() ?? "",
                                                                                            menuId: logic
                                                                                                .restaurantDetailsModel.data?.menus?[index].menuId,
                                                                                            restId: logic
                                                                                                .restaurantDetailsModel.data?.menus?[index].restaurantId,
                                                                                            selectQty: logic
                                                                                                .restaurantDetailsModel.data?.menus?[index]
                                                                                                .selectQuantity,
                                                                                          ));
                                                                                    } else {
                                                                                      await logic
                                                                                          .postAddGroupCardApi(
                                                                                          groupId: groupId,
                                                                                          menuId: logic
                                                                                              .restaurantDetailsModel.data?.menus?[index].menuId.toString() ?? "",
                                                                                          selectQty: logic
                                                                                              .restaurantDetailsModel.data?.menus?[index].selectQuantity ?? 0);
                                                                                      setState(() {
                                                                                        logic
                                                                                            .restaurantDetailsModel.data?.menus?[index].setAddToCart =
                                                                                        false;
                                                                                      });
                                                                                    }
                                                                                  } else {
                                                                                    debugPrint(
                                                                                        'Else Condition');
                                                                                    if (logic
                                                                                        .restaurantDetailsModel.data?.menus?[index].selectQuantity != 0) {
                                                                                      setState(() {
                                                                                        logic
                                                                                            .restaurantDetailsModel.data?.menus?[index].setAddToCart = true;
                                                                                      });
                                                                                      RestaurantDetailsScreen
                                                                                          ._isGroupOrder
                                                                                          ? await logic
                                                                                          .postAddGroupCardApi(
                                                                                          groupId: groupId,
                                                                                          menuId: logic
                                                                                              .restaurantDetailsModel.data?.menus?[index].menuId.toString() ?? "",
                                                                                          selectQty: logic
                                                                                              .restaurantDetailsModel.data?.menus?[index].selectQuantity ?? 0)
                                                                                          : await logic
                                                                                          .postAddCardApi(
                                                                                          restId: logic
                                                                                              .restaurantDetailsModel.data?.menus?[index].restaurantId.toString() ?? "",
                                                                                          menuId: logic
                                                                                              .restaurantDetailsModel.data?.menus?[index].menuId.toString() ?? "",
                                                                                          selectQty: logic
                                                                                              .restaurantDetailsModel.data?.menus?[index].selectQuantity ?? 0,
                                                                                          isAddOn: false);

                                                                                      setState(() {
                                                                                        logic
                                                                                            .restaurantDetailsModel.data?.menus?[index].setAddToCart = false;
                                                                                      });
                                                                                    } else {
                                                                                      showToastMessage(
                                                                                          'Please Add Items First');
                                                                                    }
                                                                                  }
                                                                                }
                                                                              }else{
                                                                                showToastMessage('${logic.restaurantDetailsModel.data?.restaurantName} is closed right now');
                                                                              }
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              padding: EdgeInsets.fromLTRB(
                                                                                  0,
                                                                                  10,
                                                                                  0,
                                                                                  10),
                                                                              decoration:
                                                                                  BoxDecoration(
                                                                                color: Color(ORANGE),
                                                                                shape: BoxShape.rectangle,
                                                                                borderRadius: BorderRadius.all(Radius.circular(7)),
                                                                              ),
                                                                              alignment:
                                                                                  Alignment.center,
                                                                              child:
                                                                                  WidgetText.widgetPoppinsMediumText(
                                                                                "Add to cart",
                                                                                Color(WHITE),
                                                                                14,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          flex: 1,
                                                                          fit: FlexFit
                                                                              .loose,
                                                                        )
                                                                      : Center(
                                                                          child:
                                                                              CircularProgressIndicator(
                                                                            color:
                                                                                Color(ORANGE),
                                                                          ),
                                                                        ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  logic.restaurantDetailsModel.data?.menus?[index].isAddToCartEnable == true
                                                                      ? (logic.restaurantDetailsModel.data?.menus?[index].isBuyNow) == false
                                                                          ? Flexible(
                                                                              child:
                                                                                  InkWell(
                                                                                onTap: () async {
                                                                                  if(logic.statusOpen == true) {
                                                                                    if (statusOpen ==
                                                                                        true) {
                                                                                      if (logic
                                                                                          .restaurantDetailsModel
                                                                                          .data
                                                                                          ?.menus?[index]
                                                                                          .selectQuantity !=
                                                                                          0) {
                                                                                        setState(() {
                                                                                          logic
                                                                                              .restaurantDetailsModel
                                                                                              .data
                                                                                              ?.menus?[index]
                                                                                              .setBuyNow =
                                                                                          true;
                                                                                        });
                                                                                        RestaurantDetailsScreen
                                                                                            ._isGroupOrder
                                                                                            ?
                                                                                        await logic
                                                                                            .postAddGroupCardApi(
                                                                                            groupId: groupId,
                                                                                            menuId: logic
                                                                                                .restaurantDetailsModel
                                                                                                .data
                                                                                                ?.menus?[index]
                                                                                                .menuId
                                                                                                .toString() ??
                                                                                                "",
                                                                                            selectQty: logic
                                                                                                .restaurantDetailsModel
                                                                                                .data
                                                                                                ?.menus?[index]
                                                                                                .selectQuantity ??
                                                                                                0)
                                                                                            : await logic
                                                                                            .postAddCardApi(
                                                                                            restId: logic
                                                                                                .restaurantDetailsModel
                                                                                                .data
                                                                                                ?.menus?[index]
                                                                                                .restaurantId
                                                                                                .toString() ??
                                                                                                "",
                                                                                            menuId: logic
                                                                                                .restaurantDetailsModel
                                                                                                .data
                                                                                                ?.menus?[index]
                                                                                                .menuId
                                                                                                .toString() ??
                                                                                                "",
                                                                                            selectQty: logic
                                                                                                .restaurantDetailsModel
                                                                                                .data
                                                                                                ?.menus?[index]
                                                                                                .selectQuantity ??
                                                                                                0,
                                                                                            isAddOn: false);

                                                                                        setState(() {
                                                                                          logic
                                                                                              .restaurantDetailsModel
                                                                                              .data
                                                                                              ?.menus?[index]
                                                                                              .setBuyNow =
                                                                                          false;
                                                                                        });

                                                                                        if (logic
                                                                                            .deleteCartModel
                                                                                            .meta
                                                                                            ?.status ==
                                                                                            true) {
                                                                                          if (!RestaurantDetailsScreen
                                                                                              ._isGroupOrder) {
                                                                                            if (logic
                                                                                                .deleteCartModel
                                                                                                .meta
                                                                                                ?.msg
                                                                                                .toString() !=
                                                                                                "This menu is from different cafe. first clear cart.") {
                                                                                              await Get
                                                                                                  .to(() =>
                                                                                                  CartScreen());
                                                                                              setState(() {
                                                                                                userHomeController
                                                                                                    .callGetCartAPI(
                                                                                                    restaurantId: widget
                                                                                                        .restaurantid);
                                                                                                userHomeController
                                                                                                    .callRestaurantDetailsAPI(
                                                                                                  restaurantId: widget
                                                                                                      .restaurantid,
                                                                                                  lat: lat,
                                                                                                  long: long,
                                                                                                );
                                                                                              });
                                                                                            }
                                                                                          }
                                                                                        }
                                                                                      } else {
                                                                                        showToastMessage(
                                                                                            'Please Add Items First');
                                                                                      }
                                                                                    }
                                                                                  }else{
                                                                                    showToastMessage('${logic.restaurantDetailsModel.data?.restaurantName} is closed right now');
                                                                                  }
                                                                                },
                                                                                child: Container(
                                                                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(ORANGE),
                                                                                    shape: BoxShape.rectangle,
                                                                                    borderRadius: BorderRadius.all(Radius.circular(7)),
                                                                                  ),
                                                                                  alignment: Alignment.center,
                                                                                  child: WidgetText.widgetPoppinsMediumText(
                                                                                    "Buy Now",
                                                                                    Color(WHITE),
                                                                                    14,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              flex:
                                                                                  1,
                                                                              fit:
                                                                                  FlexFit.loose,
                                                                            )
                                                                          : Center(
                                                                              child:
                                                                                  CircularProgressIndicator(
                                                                                color: Color(ORANGE),
                                                                              ),
                                                                            )
                                                                      : Container(
                                                                          padding:
                                                                              EdgeInsets.all(10),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Color(GREY),
                                                                            shape:
                                                                                BoxShape.rectangle,
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(7)),
                                                                          ),
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child: WidgetText
                                                                              .widgetPoppinsMediumText(
                                                                            "Buy Now",
                                                                            Color(
                                                                                WHITE),
                                                                            14,
                                                                          ),
                                                                        ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Flexible(
                                                                    child:
                                                                        Container(),
                                                                    flex: 1,
                                                                    fit: FlexFit
                                                                        .loose,
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Divider(
                                                                  height: 1,
                                                                  thickness: 1,
                                                                  color: Color(
                                                                      DIVIDERCOLOR)),
                                                            ],
                                                          ),
                                                        );
                                            }),
                                        /*  SizedBox(
                                          height: 10,
                                        ),*/
                                        _testimonialsController.reviewListModel
                                                    .data?.length ==
                                                0
                                            ? Container()
                                            : _testimonialsController
                                                        .reviewListModel.data ==
                                                    null
                                                ? Container()
                                                : Container(
                                                  margin: EdgeInsets.only(top: 20),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.fromLTRB(
                                                                  15, 0, 0, 0),
                                                          child: WidgetText
                                                              .widgetPoppinsMediumText(
                                                            "Ratings & Reviews",
                                                            Color(BLACK),
                                                            18,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.fromLTRB(
                                                                  15, 0, 15, 0),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisSize:
                                                                MainAxisSize.min,
                                                            children: [
                                                              WidgetText
                                                                  .widgetPoppinsMediumText(
                                                                "${double.parse(logic.restaurantDetailsModel.data?.ratings.toString() ?? "")}/5",
                                                                // "${logic.restaurantDetailsModel.data?.ratings}/5",
                                                                // "3.2/5",
                                                                Color(BLACK),
                                                                18,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              WidgetText
                                                                  .widgetPoppinsRegularText(
                                                                "(${_testimonialsController.reviewListModel.data?.length} reviews)",
                                                                // "(150 reviews)",
                                                                Color(
                                                                    LIGHTTEXTCOLOR),
                                                                12,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              RatingStars(
                                                                // value: 3.5,
                                                                value: double.parse(logic.restaurantDetailsModel.data?.ratings.toString() ?? ""),
                                                                onValueChanged:
                                                                    (v) {},
                                                                starBuilder: (index,
                                                                        color) =>
                                                                    Icon(
                                                                  Icons
                                                                      .star_rounded,
                                                                  color: color,
                                                                ),
                                                                maxValueVisibility:
                                                                    false,
                                                                valueLabelVisibility:
                                                                    false,
                                                                starCount: 5,
                                                                starSpacing: 2,
                                                                starSize: 20,
                                                                starColor: Color(
                                                                    0xffFFD633),
                                                                starOffColor: Color(
                                                                    0xffC1C1C1),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.fromLTRB(
                                                                  15, 0, 15, 0),
                                                          child: Divider(
                                                              height: 0.2,
                                                              thickness: 0.2,
                                                              color: Color(
                                                                  DIVIDERCOLOR)),
                                                        ),
                                                        ListView.builder(
                                                            shrinkWrap: true,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            itemCount: (_testimonialsController.reviewListModel.data?.length ?? 0) >= 3
                                                                ? 3
                                                                : (_testimonialsController
                                                                    .reviewListModel
                                                                    .data
                                                                    ?.length ?? 0),
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemBuilder: (context, index) {

                                                                  _testimonialsController.reviewListModel.data?.sort((a, b)=> b.updatedAt.toString().compareTo(a.updatedAt.toString()));

                                                              var reviewDate;
                                                              String
                                                                  parseTimeStampReport(
                                                                      int value) {
                                                                var date = DateTime.fromMicrosecondsSinceEpoch(value * 1000);
                                                                var d12 = formatterDate.format(date);

                                                                reviewDate = d12;
                                                                return d12;
                                                              }



                                                              reviewDate = parseTimeStampReport(int.parse(
                                                                  _testimonialsController.reviewListModel.data?[index].updatedAt.toString() ?? ""));

                                                              return Padding(
                                                                padding: EdgeInsets
                                                                    .fromLTRB(15,
                                                                        15, 15, 0),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    _testimonialsController
                                                                                .reviewListModel
                                                                                .data?[
                                                                                    index]
                                                                                .restaurantName ==
                                                                            null
                                                                        ? Text('')
                                                                        : WidgetText.widgetPoppinsRegularText(
                                                                            _testimonialsController.reviewListModel.data?[index].userName.toString() ?? "",
                                                                            Color(
                                                                                BLACK),
                                                                            16),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    RatingStars(
                                                                      value: double.parse(_testimonialsController.reviewListModel.data?[index].rating.toString() ?? ""),
                                                                      onValueChanged:
                                                                          (v) {},
                                                                      starBuilder:
                                                                          (index, color) =>
                                                                              Icon(
                                                                        Icons
                                                                            .star_rounded,
                                                                        color:
                                                                            color,
                                                                      ),
                                                                      maxValueVisibility:
                                                                          false,
                                                                      valueLabelVisibility:
                                                                          false,
                                                                      starCount: 5,
                                                                      starSpacing:
                                                                          2,
                                                                      starSize: 20,
                                                                      starColor: Color(
                                                                          0xffFFD633),
                                                                      starOffColor:
                                                                          Color(
                                                                              0xffC1C1C1),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 10,
                                                                    ),
                                                                    WidgetText.widgetPoppinsRegularText(
                                                                            _testimonialsController.reviewListModel.data?[index].review.toString() ?? "",
                                                                            Color(
                                                                                SUBTEXT),
                                                                            14),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    WidgetText.widgetPoppinsRegularText(
                                                                        reviewDate,
                                                                        // "14th Feb, 2022",
                                                                        Color(LIGHTGREYCOLORICON),
                                                                        12),
                                                                    SizedBox(
                                                                      height: 15,
                                                                    ),
                                                                    Divider(
                                                                        height: 1,
                                                                        thickness:
                                                                            1,
                                                                        color: Color(
                                                                            DIVIDERCOLOR)),
                                                                  ],
                                                                ),
                                                              );
                                                            }),
                                                        SizedBox(
                                                          height: 15,
                                                        ),

                                                        (_testimonialsController.reviewListModel.data?.length ?? 0) >= 3 ?
                                                        InkWell(
                                                          onTap: () async {
                                                            await Get.to(() =>
                                                                TestimonialScreen(isHome: false, restId: widget.restaurantid,));
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.fromLTRB(
                                                                    15, 0, 15, 0),
                                                            child: WidgetText
                                                                .widgetPoppinsRegularText(
                                                                    "View all",
                                                                    Color(ORANGE),
                                                                    16,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline),
                                                          ),
                                                        ) : Container(),
                                                      ],
                                                    ),
                                                )
                                      ],
                                    ),
                                    SizedBox(height: 100,)
                                  ],
                                ),
                              ),

                              logic.cartItemCount == 0
                                  ? Container()
                                  : Positioned(
                                      bottom: 15,
                                      left: 20,
                                      right: 20,
                                      child: Container(
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all<Color>(
                                              Color(ORANGE),
                                            ),
                                            minimumSize:
                                                MaterialStateProperty.all<Size>(
                                              Size(double.maxFinite, 55.0),
                                            ),
                                          ),
                                          onPressed: onClickViewCart,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                ic_cart,
                                                height: 20,
                                                width: 20,
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              WidgetText.widgetRobotoMediumText(
                                                "View Order (${logic.cartItemCount})",
                                                Colors.white,
                                                16,
                                                align: TextAlign.end,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          )
                        )
                          : Container(
                              color: Color(WHITE),
                              child: Center(
                                child: CircularProgressIndicator(
                                    color: Color(ORANGE)),
                              ),
                            );
                  // isLoading: logic.isLoaderVisible);
                });
        }),
      ),
    );
  }

  onClickViewGroupOrder(dynamic groupId) async {
    await Get.to(() => ViewGroupOrderScreen(
          groupId: groupId,
        ));
    getSharedPrefsData();
  }

  onClickViewCart() async {
    await Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => CartScreen()));
    setState(() {
      userHomeController.callGetCartAPI(restaurantId: widget.restaurantid);
      userHomeController.callRestaurantDetailsAPI(
        restaurantId: widget.restaurantid,
        lat: lat,
        long: long,
      );
    });
  }

  onClickGroupOrder(String restaurantId, isPickupAvail, {required List cordinates}) {
    // Get.to(()=> JoinGroupOrderScreen('62fe17d0309a3772d5ae83c6'));
    Get.to(() => CreateGroupScreen(
          restaurantId: restaurantId,
          isPickupAvail: isPickupAvail,
         cordinates: cordinates,
        ));
  }
}

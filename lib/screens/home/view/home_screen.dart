import 'dart:convert';
import 'dart:ui';
import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/utils/app_preferences.dart';
import 'package:choosifoodi/core/widgets/widget_radio_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/cart/view/cart_screen.dart';
import 'package:choosifoodi/screens/home/view/testimonials_screen.dart';
import 'package:choosifoodi/screens/location_details/view/location_details_screen.dart';
import 'package:choosifoodi/screens/notification/view/notification_screen.dart';
import 'package:choosifoodi/screens/search/view/search_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../../../core/widgets/widget_button.dart';
import '../../../core/widgets/widget_card.dart';
import '../../../routes/all_routes.dart';
import '../../foodi_highlight_filter/view/foodi_highlight_screen.dart';
import '../../group_orders/view/join_group_order_screen.dart';
import '../../notification/controller/notification_controller.dart';
import '../../notification/localNotification/local_notification_service.dart';
import '../../orders/view/normal_order/normal_order_screen.dart';
import '../../restaurant_details/controller/restaurant_details_controller.dart';
import '../../restaurant_details/view/restaurant_details_screen.dart';
import '../../restaurant_filter/view/restaurant_screen.dart';
import '../controller/user_home_controller.dart';
import 'dart:math' show cos, sqrt, asin;

class Home extends StatelessWidget {
  static BuildContext? homeContext;

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    homeContext = context;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final UserHomeController userHomeController = Get.put(UserHomeController());

  final NotificationController _notificationController =
      Get.put(NotificationController());
  final RestaurantDetailsController restaurantDetailsController =
      Get.put(RestaurantDetailsController());
  int _orderTypeValue = 0;
  var lat, long, groupId;
  String userId = "";

  final PageController _pageViewController = PageController(
    initialPage: 0,
    viewportFraction: 0.8,
  );
  final PageController _pvFoodiController = PageController(
    initialPage: 0,
    viewportFraction: 0.8,
  );
  final PageController _pvRestaurantController = PageController(
    initialPage: 0,
    viewportFraction: 0.8,
  );
  int _activeTestimonialPage = 0;
  int _activeFoodiPage = 0;
  int _activeRestaurantPage = 0;

  // List<GetCustomCartModel> getCustomModelList = [];

  @override
  void initState() {
    if (mounted) {
      getFirebaseNotification();
      getCurrentLocation();
      getCartApi();
      _notificationController.callNotificationAPI(false);
    }
    super.initState();
  }

  getFirebaseNotification() {
    LocalNotificationService.initialize(context);

    /// TODO Terminated State
    /// 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and
    // you can get notification data in this method
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      debugPrint("FirebaseMessaging.instance.getInitialMessage");
      if (message != null) {
        debugPrint(message.notification?.title);
        debugPrint(message.notification?.body);
        debugPrint("Terminated Message ID: ${message.data["_id"]}");
        debugPrint("Foreground Message Body: ${message.data}");
        //data => {groupId: 63354d06fb5bdd2e3c5ba455, notificationType: GROUPORDER}
        // GROUPORDER_PAYMENT
        if (message.data['notificationType'] == groupOrderPayment) {
          AppPreferences.setGroupId("");
        } else {
          groupId = message.data['groupId'];
          debugPrint('groupId ===> $groupId');
          if (groupId != null) {
            AppPreferences.setGroupId(groupId);
          }
        }
        checkIsLogin();
        LocalNotificationService.createAndDisplayNotification(message);
      }
    });

    /// TODO Foreground State
    /// 2. This method only call when App in foreground it mean app must be opened
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint("FirebaseMessaging.onMessage.listen");
      if (message.notification != null) {
        debugPrint(message.notification?.title);
        debugPrint(message.notification?.body);
        debugPrint("Foreground Message ID: ${message.data["_id"]}");
        debugPrint("Foreground Message Body: ${message.data}");
        groupId = message.data['groupId'];
        debugPrint('groupId ===> $groupId');
        if (message.data['notificationType'] == groupOrderPayment) {
          AppPreferences.setGroupId("");
        } else {
          groupId = message.data['groupId'];
          debugPrint('groupId ===> $groupId');
          if (groupId != null) {
            AppPreferences.setGroupId(groupId);
          }
        }
        LocalNotificationService.createAndDisplayNotification(message);
      }
    });

    /// TODO Background State
    /// 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint("FirebaseMessaging.onMessageOpenedApp.listen");
      if (message.notification != null) {
        /* final routeFromMessage = message.data["route"];
        Navigator.of(context).pushNamed(routeFromMessage);*/

        debugPrint(message.notification?.title);
        debugPrint(message.notification?.body);
        debugPrint("Background Message ID: ${message.data['_id']}");
        debugPrint("Foreground Message Body: ${message.data}");
        if (message.data['notificationType'] == groupOrderPayment) {
          AppPreferences.setGroupId("");
        } else {
          groupId = message.data['groupId'];
          debugPrint('groupId ===> $groupId');
          if (groupId != null) {
            AppPreferences.setGroupId(groupId);
          }
        }
        checkIsLogin();
        LocalNotificationService.createAndDisplayNotification(message);
      }
    });
  }

  void checkIsLogin() {
    AppPreferences.getIsLogin().then((value) {
      if (value == true) {
        if (IsCustomerApp) {
          AppPreferences.getUserData().then((userData) {
            if (userData != null) {
              debugPrint('User Not Null');
              if (groupId != null && groupId != "") {
                Get.to(() => JoinGroupOrderScreen(groupId));
              }
            }
          });
        }
      } else {
        Get.toNamed(AllRoutes.start);
      }
    });
  }

  getCurrentLocation() async {
    groupId = await AppPreferences.getGroupId();
    debugPrint('groupId: $groupId');
    debugPrint('Call getCurrentLocation');
    lat = await AppPreferences.getLat();
    long = await AppPreferences.getLong();
    var data = await AppPreferences.getUserData();
    var userID = jsonEncode(data?.userId.toString());
    userId = userID.replaceAll(new RegExp(r'[^\w\s]+'), '');
    debugPrint('userId: $userId');
    if (lat == null) {
      await userHomeController.getLocation();
      lat = await AppPreferences.getLat();
      long = await AppPreferences.getLong();
    }
    userHomeController.callProfile(lat, long);
    debugPrint('Lat: $lat, Long: $long');
    if (lat == "" && long == "" || lat == null && long == null) {
      debugPrint('Call Gps');
      await userHomeController.checkGps();
      debugPrint('haspermission: ${userHomeController.haspermission}');
      if (userHomeController.haspermission == false) {
        await userHomeController.checkGps();
      }
    } else {
      callHomeApi();
    }
  }

  getCartApi() async {
    await userHomeController.callGetCartAPI();
    if (mounted) {
      if (userHomeController.isCartVisible == true) {
        setState(() {
          var cartCount = userHomeController.itemCount;
          debugPrint('CartCount: $cartCount');
        });
      }
    }
  }

  callHomeApi() async {
    // debugPrint('Firebase name: ${FirebaseAuth.instance.currentUser?.displayName}');
    // debugPrint('Firebase phone: ${FirebaseAuth.instance.currentUser?.phoneNumber}');
    // debugPrint('Firebase id: ${FirebaseAuth.instance.currentUser?.uid}');
    lat = await AppPreferences.getLat();
    long = await AppPreferences.getLong();
    latString = lat;
    longString = long;
    debugPrint('Lat: $lat, Long: $long');
    debugPrint('Call Home');
    userHomeController.getAddressFromLatLongDirect(
        lat: double.parse(lat.toString()), long: double.parse(long.toString()));
    debugPrint('_orderTypeValue: $_orderTypeValue');

    userHomeController.callHomeAPI(
        lat: lat.toString(),
        long: long.toString(),
        isDelivery: _orderTypeValue);
  }

  onClickCart() async {
    await Get.to(() => CartScreen());
    setState(() {
      getCartApi();
      callHomeApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(WHITE),
      body: SafeArea(
          child: GetBuilder<GetXNetworkManager>(builder: (networkManager) {
        return networkManager.connectionType == 0
            ? Center(child: Text(check_internet))
            : GetBuilder<UserHomeController>(builder: (logic) {
                // debugPrint('bannerLen screen : ${logic.bannerLen}');

                return appLoader(
                    widget: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 70,
                          decoration: BoxDecoration(
                            color: Color(WHITE),
                          ),
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    WidgetText.widgetPoppinsMediumText(
                                      "Location",
                                      Color(ORANGE),
                                      12,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    InkWell(
                                      // onTap: onClickLocationUpdate,
                                      onTap: () async {
                                        final newValue = await Get.to(() =>
                                            LocationDetailsScreen(
                                                isFromSignup: false));
                                        setState(() {
                                          debugPrint('NewValue: $newValue');
                                          callHomeApi();
                                        });
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          logic.address == ""
                                              ? Text('')
                                              : Expanded(
                                                  child: WidgetText
                                                      .widgetPoppinsRegularOverflowText(
                                                    logic.address,
                                                    Color(BLACK),
                                                    16,
                                                  ),
                                                ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Image.asset(
                                            ic_down_arrow,
                                            width: 18,
                                            color: Color(ORANGE),
                                            height: 18,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: onClickCart,
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 50,
                                      width:  logic.itemCount.toString().length > 3 ? 60 : 40,
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        ic_cart_head,
                                        height: 30,
                                        width: 30,
                                      ),
                                    ),
                                   /* logic.itemCount == 0
                                        ? Container(
                                            height: 20,
                                            width: 20,
                                          )
                                        : */Positioned(
                                            child: Container(
                                              height: 20,
                                              width: logic.itemCount.toString().length > 3 ? 30 : 20,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(ORANGE)),
                                                color: Color(ORANGE),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(13.0),
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: WidgetText
                                                  .widgetPoppinsRegularText(
                                                logic.itemCount.toString(),
                                                Color(WHITE),
                                                9,
                                              ),
                                            ),
                                            bottom: 25,
                                            right: 0,
                                          )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: onClickNotification,
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: _notificationController.notificationCount.toString().length > 3 ? 60 : 40,
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        ic_notification,
                                        height: 22,
                                        width: 22,
                                      ),
                                    ),
                                    _notificationController.notificationCount ==
                                            0
                                        ? Container(
                                            height: 20,
                                            width: 20,
                                          )
                                        : Positioned(
                                            child: Container(
                                              height: 20,
                                              width: _notificationController.notificationCount.toString().length > 3 ? 30 : 20,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(ORANGE)),
                                                color: Color(ORANGE),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(13.0),
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: WidgetText
                                                  .widgetPoppinsRegularText(
                                                _notificationController
                                                    .notificationCount
                                                    .toString(),
                                                // "10",
                                                Color(WHITE),
                                                9,
                                              ),
                                            ),
                                            bottom: 25,
                                            right: 0,
                                          )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: onClickOrder,
                                child: Container(
                                  height: 50,
                                  width: 40,
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(
                                    ic_order,
                                    height: 22.0,
                                    width: 22.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: [
                              SizedBox(
                                height: 5,
                              ),

                              logic.userHomeModel.data?.banner == null
                                  ? Container()
                                  : Container(
                                      decoration: BoxDecoration(
                                        color: Color(WHITE),
                                      ),
                                      height: 200,
                                      child: Swiper(
                                        outer: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                              return   ClipRRect(borderRadius: BorderRadius.circular(20.0),child:
                                              imageFromNetworkCache(logic.bannerImageList[index]
                                                  .toString(), height: 200));
                                        },
                                        // itemCount: logic.userHomeModel.data?.banner?.length ?? 0,
                                        itemCount: logic.bannerImageList.length,
                                        pagination: SwiperPagination(
                                          alignment: Alignment.bottomCenter,
                                          builder:
                                              new DotSwiperPaginationBuilder(
                                            color: Colors.grey,
                                            activeColor: Color(ORANGE),
                                          ),
                                        ),
                                        autoplay: true,
                                        viewportFraction: 0.8,
                                        scale: 0.9,
                                        // control: SwiperControl(color: Color(ORANGE)),
                                      ),
                                    ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: 120,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _orderTypeValue = 0;
                                            userHomeController.callHomeAPI(
                                                lat: lat.toString(),
                                                long: long.toString(),
                                                isDelivery: _orderTypeValue);
                                          });
                                        },
                                        child: _orderTypeValue == 0
                                            ? WidgetRadioButton
                                                .selectedRadioButton(delivery)
                                            : WidgetRadioButton
                                                .unselectedRadioButton(
                                                    delivery),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 120,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _orderTypeValue = 1;
                                          userHomeController.callHomeAPI(
                                              lat: lat.toString(),
                                              long: long.toString(),
                                              isDelivery: _orderTypeValue);
                                        });
                                      },
                                      child: _orderTypeValue == 1
                                          ? WidgetRadioButton
                                              .selectedRadioButton(pickup)
                                          : WidgetRadioButton
                                              .unselectedRadioButton(pickup),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              logic.userHomeModel.data?.featuredFoods?.length ==
                                      0
                                  ? Container()
                                  : logic.userHomeModel.data?.featuredFoods ==
                                          null
                                      ? Container()
                                      : Column(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              child: WidgetText
                                                  .widgetPoppinsMediumText(
                                                      featured,
                                                      Color(BLACK),
                                                      18),
                                            ),
                                            Container(
                                              height: 300,
                                              width: double.infinity,
                                              margin: EdgeInsets.all(15),
                                              child: GridView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                gridDelegate:
                                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                                        maxCrossAxisExtent: 150,
                                                        childAspectRatio:
                                                            4 / 2.2,
                                                        crossAxisSpacing: 4,
                                                        mainAxisSpacing: 4),
                                                itemCount: logic
                                                    .userHomeModel
                                                    .data
                                                    ?.featuredFoods
                                                    ?.length,
                                                // itemCount: featuredList.length,
                                                itemBuilder: (context, index) {
                                                  var featuredFoodName,
                                                      featuredFoodImage;
                                                  if (logic.userHomeModel.data
                                                          ?.featuredFoods ==
                                                      null) {
                                                    featuredFoodName = "";
                                                    featuredFoodImage = "";
                                                  } else {
                                                    featuredFoodName = logic
                                                        .userHomeModel
                                                        .data
                                                        ?.featuredFoods?[index]
                                                        .dishName;

                                                    if (logic
                                                                .userHomeModel
                                                                .data
                                                                ?.featuredFoods?[
                                                                    index]
                                                                .menuImg ==
                                                            null ||
                                                        logic
                                                                .userHomeModel
                                                                .data
                                                                ?.featuredFoods?[
                                                                    index]
                                                                .menuImg
                                                                .isEmpty ==
                                                            true) {
                                                      featuredFoodImage = "";
                                                    } else {
                                                      featuredFoodImage = logic
                                                          .userHomeModel
                                                          .data
                                                          ?.featuredFoods?[
                                                              index]
                                                          .menuImg
                                                          .first;
                                                    }
                                                  }

                                                  return Container(
                                                    constraints: BoxConstraints(
                                                      maxHeight: 80,
                                                      minWidth: 80,
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        InkWell(
                                                          onTap: () async {
                                                            var result =
                                                                await Get.to(() =>
                                                                    RestaurantDetailsScreen(
                                                                      restaurantid: logic
                                                                          .userHomeModel
                                                                          .data
                                                                          ?.featuredFoods?[
                                                                              index]
                                                                          .restaurantId
                                                                          .toString(),
                                                                    ));
                                                            setState(() {
                                                              debugPrint(
                                                                  'Result: $result');
                                                              getCartApi();
                                                            });
                                                          },
                                                          child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    LIGHTDIVIDERCOLOR),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                border: Border.all(
                                                                    color: Color(
                                                                        LIGHTDIVIDERCOLOR),
                                                                    width: 5),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            100)),
                                                              ),
                                                              margin: EdgeInsets
                                                                  .fromLTRB(5,
                                                                      5, 0, 0),
                                                              child: ClipOval(
                                                                child: SizedBox
                                                                    .fromSize(
                                                                  size: Size
                                                                      .fromRadius(
                                                                          30),
                                                                  child:
                                                                  imageFromNetworkCache(featuredFoodImage
                                                                      .toString(), height: 20),
                                                                ),
                                                              )),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        logic
                                                                    .userHomeModel
                                                                    .data
                                                                    ?.featuredFoods?[
                                                                        index]
                                                                    .dishName !=
                                                                null
                                                            ? WidgetText
                                                                .widgetPoppinsMaxLineOverflowText(
                                                                    featuredFoodName,
                                                                    // featuredList[index],
                                                                    Color(
                                                                        BLACK),
                                                                    14,
                                                                    align: TextAlign
                                                                        .center,
                                                                    maxline: 2)
                                                            : Text('')
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                              logic.userHomeModel.data?.restaurants?.isEmpty == true || logic.userHomeModel.data?.restaurants ==
                                  null
                                  ? Container()
                                  : /*logic.userHomeModel.data?.restaurants ==
                                          null
                                      ? Container()
                                      :*/ Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Divider(
                                              color: Color(LIGHTDIVIDERCOLOR),
                                              height: 5,
                                              thickness: 5,
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  15, 15, 15, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: WidgetText
                                                        .widgetPoppinsMediumText(
                                                            nearbyRestaurant,
                                                            Color(BLACK),
                                                            18),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Get.to(() =>
                                                          RestaurantFilterScreen());
                                                    },
                                                    child: WidgetText
                                                        .widgetPoppinsRegularText(
                                                            viewall,
                                                            Color(ORANGE),
                                                            12,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  15, 15, 0, 0),
                                              height: 250,
                                              child: PageView.builder(
                                                  pageSnapping: true,
                                                  padEnds: false,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  controller:
                                                      _pvRestaurantController,
                                                  onPageChanged: (int index) {
                                                    setState(() {
                                                      _activeRestaurantPage =
                                                          index;
                                                      debugPrint(
                                                          '_activeRestaurantPage: $_activeRestaurantPage');
                                                    });
                                                  },
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  // itemCount: logic.userHomeModel.data?.restaurants?.length,
                                                  itemCount: (logic
                                                                  .userHomeModel
                                                                  .data
                                                                  ?.restaurants
                                                                  ?.length ??
                                                              0) >=
                                                          6
                                                      ? 6
                                                      : (logic
                                                              .userHomeModel
                                                              .data
                                                              ?.restaurants
                                                              ?.length ??
                                                          0),
                                                  itemBuilder:
                                                      (context, index) {
                                                    var restaurantImage = logic
                                                        .userHomeModel
                                                        .data
                                                        ?.restaurants?[index]
                                                        .restaurantImg
                                                        .first
                                                        .toString();
                                                    var distance;

                                                    if (logic
                                                            .userHomeModel
                                                            .data
                                                            ?.restaurants?[
                                                                index]
                                                            .distance !=
                                                        null) {
                                                      distance = logic
                                                          .userHomeModel
                                                          .data
                                                          ?.restaurants?[index]
                                                          .distance;
                                                    }

                                                    var totalDistance =
                                                        (distance / 1609.344);
                                                    String totalDistance1 =
                                                        totalDistance
                                                            .round()
                                                            .toString();
                                                    var arrDistance =
                                                        totalDistance1
                                                            .toString();
                                                    debugPrint(
                                                        'arrDistance: ${arrDistance}');
                                                    String start = "", end = "";
                                                    bool statusOpen = false;
                                                    if (logic
                                                                .userHomeModel
                                                                .data
                                                                ?.restaurants?[
                                                                    index]
                                                                .timings
                                                                .openingTime
                                                                .isNotEmpty ==
                                                            true ||
                                                        logic
                                                                .userHomeModel
                                                                .data
                                                                ?.restaurants?[
                                                                    index]
                                                                .timings
                                                                .closingTime
                                                                .isNotEmpty ==
                                                            true) {
                                                      start = logic
                                                              .userHomeModel
                                                              .data
                                                              ?.restaurants?[
                                                                  index]
                                                              .timings
                                                              .openingTime
                                                              .toString() ??
                                                          "";
                                                      end = logic
                                                              .userHomeModel
                                                              .data
                                                              ?.restaurants?[
                                                                  index]
                                                              .timings
                                                              .closingTime
                                                              .toString() ??
                                                          "";
                                                      debugPrint(
                                                          'CheckDate: ${isRestaurantOpen(start, end)}');

                                                      statusOpen =
                                                          isRestaurantOpen(
                                                              start, end);
                                                      debugPrint(
                                                          'ISOPEN: $statusOpen');
                                                    }

                                                    dynamic foodTypeData;
                                                    if (logic
                                                            .userHomeModel
                                                            .data
                                                            ?.restaurants?[
                                                                index]
                                                            .rootCategory
                                                            .isNotEmpty ==
                                                        true) {
                                                      for (int i = 0;
                                                          i <
                                                              (logic
                                                                      .userHomeModel
                                                                      .data
                                                                      ?.restaurants?[
                                                                          index]
                                                                      .rootCategory
                                                                      .length ??
                                                                  0);
                                                          i++) {
                                                        if (i == 0) {
                                                          foodTypeData = logic
                                                                  .userHomeModel
                                                                  .data
                                                                  ?.restaurants?[
                                                                      index]
                                                                  .rootCategory[
                                                                      i]
                                                                  .categoryName ??
                                                              "";
                                                        } else {
                                                          foodTypeData += ", " +
                                                              (logic
                                                                      .userHomeModel
                                                                      .data
                                                                      ?.restaurants?[
                                                                          index]
                                                                      .rootCategory[
                                                                          i]
                                                                      .categoryName ??
                                                                  "");
                                                        }
                                                      }
                                                    }

                                                    return logic
                                                                    .userHomeModel
                                                                    .data
                                                                    ?.restaurants?[
                                                                index] ==
                                                            null
                                                        ? Container()
                                                        : Container(
                                                            width: 250,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            margin: EdgeInsets
                                                                .fromLTRB(0, 0,
                                                                    10, 0),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Color(WHITE),
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              border: Border.all(
                                                                  color: Color(
                                                                      ORANGE),
                                                                  width: 1),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Stack(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          100,
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      child:

                                                                      ClipRRect(borderRadius: BorderRadius.circular(10.0),child:
                                                                      imageFromNetworkCache(restaurantImage
                                                                          .toString(), height: 100)),
                                                                    ),
                                                                    Positioned(
                                                                      right: 0,
                                                                      top: 10,
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              color: statusOpen == true ? Color(ORANGE) : Color(RED),
                                                                              blurRadius: 3.0,
                                                                            ),
                                                                          ],
                                                                          color: statusOpen == true
                                                                              ? Color(ORANGE)
                                                                              : Color(RED),
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(5.0),
                                                                            bottomLeft:
                                                                                Radius.circular(5.0),
                                                                          ),
                                                                        ),
                                                                        height:
                                                                            22,
                                                                        width:
                                                                            53,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child: start ==
                                                                                ""
                                                                            ? WidgetText.widgetPoppinsMediumText(
                                                                                "",
                                                                                Color(WHITE),
                                                                                12)
                                                                            : statusOpen == true
                                                                                ? WidgetText.widgetPoppinsMediumText(
                                                                                    open,
                                                                                    // "Open",
                                                                                    Color(WHITE),
                                                                                    12)
                                                                                : WidgetText.widgetPoppinsMediumText(
                                                                                    closed,
                                                                                    // "Open",
                                                                                    Color(WHITE),
                                                                                    12),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      right: 7,
                                                                      bottom: 7,
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              color: Color(WHITE),
                                                                              blurRadius: 3.0,
                                                                            ),
                                                                          ],
                                                                          color:
                                                                              Color(WHITE),
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(5.0)),
                                                                        ),
                                                                        height:
                                                                            26,
                                                                        width:
                                                                            70,
                                                                        child:
                                                                            Row(
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
                                                                            WidgetText.widgetPoppinsMediumText(
                                                                                (logic.userHomeModel.data?.restaurants![index].deliveryTime.toString() ?? "") + 'min',
                                                                                // "27 min",
                                                                                Color(BLACK),
                                                                                12)
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      left: 7,
                                                                      bottom: 7,
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              color: Color(WHITE),
                                                                              blurRadius: 3.0,
                                                                            ),
                                                                          ],
                                                                          color:
                                                                              Color(WHITE),
                                                                          borderRadius:
                                                                              BorderRadius.all(Radius.circular(5.0)),
                                                                        ),
                                                                        height:
                                                                            26,
                                                                        width:
                                                                            100,
                                                                        child:
                                                                            Row(
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
                                                                            distance == null
                                                                                ? Text(miles)
                                                                                : WidgetText.widgetPoppinsMediumText(arrDistance.toString() + " miles", Color(BLACK), 12)
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                logic
                                                                            .userHomeModel
                                                                            .data
                                                                            ?.restaurants ==
                                                                        null
                                                                    ? WidgetText
                                                                        .widgetPoppinsMediumText(
                                                                            "",
                                                                            Color(
                                                                                BLACK),
                                                                            16)
                                                                    : WidgetText.widgetPoppinsMediumOverflowText(
                                                                        logic.userHomeModel.data?.restaurants?[index].restaurantName.toString() ??
                                                                            "",
                                                                        Color(
                                                                            BLACK),
                                                                        16),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                WidgetText.widgetPoppinsRegularText(
                                                                    // logic.userHomeModel.data?.restaurants?[index].rootCategory[0].categoryName.toString() ?? "",
                                                                    foodTypeData ?? "",
                                                                    Color(SUBTEXTBLACKCOLOR),
                                                                    14),
                                                                RatingStars(
                                                                  value: logic
                                                                              .userHomeModel
                                                                              .data
                                                                              ?.restaurants ==
                                                                          null
                                                                      ? 0
                                                                      : double.parse(logic
                                                                              .userHomeModel
                                                                              .data
                                                                              ?.restaurants?[index]
                                                                              .ratings
                                                                              .toString() ??
                                                                          ""),
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
                                                                Container(
                                                                  height: 33,
                                                                  width: MediaQuery.of(context).size.width / 3,
                                                                  // width: 100,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      ElevatedButton(
                                                                    style:
                                                                        ButtonStyle(
                                                                      shape: MaterialStateProperty
                                                                          .all<
                                                                              RoundedRectangleBorder>(
                                                                        RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(7.0),
                                                                        ),
                                                                      ),
                                                                      backgroundColor:
                                                                          MaterialStateProperty.all<
                                                                              Color>(
                                                                        Color(
                                                                            ORANGE),
                                                                      ),
                                                                      minimumSize:
                                                                          MaterialStateProperty.all<
                                                                              Size>(
                                                                        Size(
                                                                            double.maxFinite,
                                                                            45.0),
                                                                      ),
                                                                    ),
                                                                    // onPressed: onClickFoodDetail,
                                                                    onPressed:
                                                                        () async {
                                                                      var result =
                                                                          await Get.to(() =>
                                                                              RestaurantDetailsScreen(
                                                                                restaurantid: logic.userHomeModel.data?.restaurants?[index].restaurantId.toString(),
                                                                              ));
                                                                      setState(
                                                                          () {
                                                                        debugPrint(
                                                                            'Result: $result');
                                                                        getCartApi();
                                                                        getCurrentLocation();
                                                                      });
                                                                    },
                                                                    child: WidgetText.widgetPoppinsMediumText(
                                                                        viewMore,
                                                                        Color(
                                                                            WHITE),
                                                                        12),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                    );
                                                  }),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                             DotsIndicator(
                                              dotsCount: (logic.userHomeModel.data
                                                              ?.restaurants?.length ?? 0) >= 6 ? 6
                                                  : (logic
                                                          .userHomeModel
                                                          .data
                                                          ?.restaurants
                                                          ?.length ??
                                                      0),
                                              position: _activeRestaurantPage
                                                  .toDouble(),
                                              decorator: DotsDecorator(
                                                color: Colors
                                                    .grey, // Inactive color
                                                activeColor: Color(ORANGE),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                          ],
                                        ),

                              ///Foodi Highlight ==> Menu array
                              logic.userHomeModel.data?.menu?.length == 0
                                  ? Container()
                                  : logic.userHomeModel.data?.menu == null
                                      ? Container()
                                      : Column(
                                          children: [
                                            Divider(
                                              color: Color(LIGHTDIVIDERCOLOR),
                                              height: 5,
                                              thickness: 5,
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  15, 15, 15, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: WidgetText
                                                        .widgetPoppinsMediumText(
                                                            foodiHighlight,
                                                            Color(BLACK),
                                                            18),
                                                  ),
                                                  InkWell(
                                                    // onTap: onClickFoodieHighLight,
                                                    onTap: () {
                                                      Get.to(() =>
                                                          FoodiHighlightFilterScreen());
                                                      // RestaurantScreen(
                                                      //   screenName:
                                                      //       foodiHighlight,
                                                      // ));
                                                    },
                                                    child: WidgetText
                                                        .widgetPoppinsRegularText(
                                                            viewall,
                                                            Color(ORANGE),
                                                            12,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  15, 15, 0, 0),
                                              height: 220,
                                              child: PageView.builder(
                                                  pageSnapping: true,
                                                  padEnds: false,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  controller:
                                                      _pvFoodiController,
                                                  onPageChanged: (int index) {
                                                    setState(() {
                                                      _activeFoodiPage = index;
                                                      debugPrint(
                                                          '_activeFoodiPage: $_activeFoodiPage');
                                                    });
                                                  },
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: (logic
                                                                  .userHomeModel
                                                                  .data
                                                                  ?.menu
                                                                  ?.length ??
                                                              0) >=
                                                          5
                                                      ? 5
                                                      : (logic
                                                              .userHomeModel
                                                              .data
                                                              ?.menu
                                                              ?.length ??
                                                          0),
                                                  itemBuilder:
                                                      (context, index) {
                                                    bool statusOpen = false;
                                                    String start = logic
                                                            .userHomeModel
                                                            .data
                                                            ?.menu?[index]
                                                            .dishVisibilityStart
                                                            .toString() ??
                                                        "";
                                                    String end = logic
                                                            .userHomeModel
                                                            .data
                                                            ?.menu?[index]
                                                            .dishVisibilityEnd
                                                            .toString() ??
                                                        "";

                                                    debugPrint(
                                                        'Menu CheckDate Index $index: ${isRestaurantOpen(start, end)}');
                                                    if (start.isNotEmpty) {
                                                      statusOpen =
                                                          isRestaurantOpen(
                                                              start, end);
                                                      debugPrint(
                                                          'ISOPEN: $statusOpen');
                                                    }

                                                    return Container(
                                                      width: 250,
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 10, 0),
                                                      decoration: BoxDecoration(
                                                        color: statusOpen ==
                                                                true
                                                            ? Color(WHITE)
                                                            : Color(GREY6)
                                                                .withOpacity(
                                                                    0.5),
                                                        shape:
                                                            BoxShape.rectangle,
                                                        border: Border.all(
                                                            color:
                                                                Color(ORANGE),
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10)),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                      ClipRRect(borderRadius: BorderRadius.circular(10.0),child:
                                                      imageFromNetworkCache(logic.userHomeModel.data?.menu?[index].menuImg.first.toString() ?? "", height: 100)),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Flexible(
                                                                child: logic.userHomeModel.data?.menu?.isEmpty ==
                                                                            true ||
                                                                        logic.userHomeModel.data?.menu ==
                                                                            null
                                                                    ? Text('')
                                                                    : WidgetText
                                                                        .widgetPoppinsMediumOverflowText(
                                                                        logic.userHomeModel.data?.menu?[index].dishName.toString() ??
                                                                            "",
                                                                        // "Veg Biryani",
                                                                        Color(
                                                                            BLACK),
                                                                        16,
                                                                      ),
                                                                flex: 1,
                                                                fit: FlexFit
                                                                    .tight,
                                                              ),
                                                              logic.userHomeModel.data?.menu
                                                                              ?.isEmpty ==
                                                                          true ||
                                                                      logic.userHomeModel.data
                                                                              ?.menu ==
                                                                          null
                                                                  ? Text('')
                                                                  : WidgetText.widgetPoppinsMediumText(
                                                                      "\$" +
                                                                          (logic.userHomeModel.data?.menu?[index].price.toString() ??
                                                                              ""),
                                                                      Color(
                                                                          ORANGE),
                                                                      16),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          logic.userHomeModel.data?.menu
                                                                          ?.isEmpty ==
                                                                      true ||
                                                                  logic
                                                                          .userHomeModel
                                                                          .data
                                                                          ?.menu ==
                                                                      null
                                                              ? Text('')
                                                              : WidgetText.widgetPoppinsRegularOverflowText(
                                                                  logic
                                                                          .userHomeModel
                                                                          .data
                                                                          ?.menu?[
                                                                              index]
                                                                          .restaurantName
                                                                          .toString() ??
                                                                      "",
                                                                  Color(BLACK),
                                                                  14),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          logic
                                                                      .userHomeModel
                                                                      .data!
                                                                      .menu![
                                                                          index]
                                                                      .isBuyNow ==
                                                                  false
                                                              ? Container(
                                                                  height: 33,
                                                                  width: 100,
                                                                  child: WidgetButton.widgetOrangeButton(
                                                                      buyNow,
                                                                      () async {
                                                                    if (statusOpen ==
                                                                        true) {
                                                                      setState(
                                                                          () {
                                                                        logic
                                                                            .userHomeModel
                                                                            .data
                                                                            ?.menu?[index]
                                                                            .setBuyNow = true;
                                                                      });

                                                                      await restaurantDetailsController.postAddCardApi(
                                                                          restId: logic.userHomeModel.data?.menu?[index].restaurantId.toString() ??
                                                                              "",
                                                                          menuId: logic.userHomeModel.data?.menu?[index].menuId.toString() ??
                                                                              "",
                                                                          selectQty:
                                                                              1,
                                                                          isAddOn:
                                                                              false);

                                                                      if (restaurantDetailsController
                                                                              .deleteCartModel
                                                                              .meta
                                                                              ?.status ==
                                                                          true) {
                                                                        setState(
                                                                            () {
                                                                          logic
                                                                              .userHomeModel
                                                                              .data
                                                                              ?.menu?[index]
                                                                              .setBuyNow = false;
                                                                          if (restaurantDetailsController.deleteCartModel.meta?.msg.toString() !=
                                                                              differentCafe) {
                                                                            onClickCart();
                                                                          }
                                                                        });
                                                                      } else {
                                                                        setState(
                                                                            () {
                                                                          logic
                                                                              .userHomeModel
                                                                              .data
                                                                              ?.menu?[index]
                                                                              .setBuyNow = false;
                                                                        });
                                                                      }

                                                                      /*  Future.delayed(
                                                                        const Duration(milliseconds: 500),
                                                                            () async {
                                                                          debugPrint('addToCartBool timer => ${restaurantDetailsController.addToCartBool}');
                                                                          if (restaurantDetailsController.deleteCartModel.meta?.status == true) {
                                                                            var result = true;
                                                                            debugPrint('Result => $result');
                                                                            if (result) {
                                                                              setState(() {
                                                                                logic.userHomeModel.data!.menu![index].setBuyNow = false;
                                                                                if(logic.userHomeModel.meta?.msg != "This menu is from different cafe. first clear cart.") {
                                                                                  onClickCart();
                                                                                  debugPrint('not match');
                                                                                }else{
                                                                                  debugPrint('match');
                                                                                }
                                                                              });
                                                                              // await getCartApi();
                                                                              // if(userHomeController.getMenuCartModel.meta?.msg != 'This menu is from different cafe. first clear cart.'){
                                                                              //   onClickCart();
                                                                              // }
                                                                            }
                                                                          } else {
                                                                            setState(() {
                                                                              logic.userHomeModel.data!.menu![index].setBuyNow = false;
                                                                            });
                                                                          }
                                                                        },
                                                                      );*/
                                                                    } /*else{
                                                                      showToastMessage('${logic.userHomeModel.data!.menu![index].dishName} is Not available right now');
                                                                    }*/
                                                                  },
                                                                      fontSize:
                                                                          12.0,
                                                                      buttonSize:
                                                                          45.0))
                                                              : Center(
                                                                  child:
                                                                      Container(
                                                                    height: 33,
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      color: Color(
                                                                          ORANGE),
                                                                    ),
                                                                  ),
                                                                )
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ],
                                        ),

                              logic.userHomeModel.data?.menu?.isEmpty == true ||
                                      logic.userHomeModel.data?.menu == null
                                  ? Container()
                                  : Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: new DotsIndicator(
                                        dotsCount: (logic.userHomeModel.data
                                                        ?.menu?.length ??
                                                    0) >=
                                                5
                                            ? 5
                                            : (logic.userHomeModel.data?.menu
                                                    ?.length ??
                                                0),
                                        position: _activeFoodiPage.toDouble(),
                                        decorator: DotsDecorator(
                                          color: Colors.grey, // Inactive color
                                          activeColor: Color(ORANGE),
                                        ),
                                      ),
                                    ),

                              SizedBox(
                                height: 15,
                              ),

                              // ? Container(): logic.userHomeModel.data?.reviews == null

                              logic.userHomeModel.data?.reviews?.length == 0
                                  ? Container()
                                  : logic.userHomeModel.data?.reviews
                                                  ?.isEmpty ==
                                              true ||
                                          logic.userHomeModel.data?.reviews ==
                                              null
                                      ? Container()
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Divider(
                                              color: Color(LIGHTDIVIDERCOLOR),
                                              height: 5,
                                              thickness: 5,
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  15, 15, 15, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: WidgetText
                                                        .widgetPoppinsMediumText(
                                                            reviews,
                                                            Color(BLACK),
                                                            18),
                                                  ),
                                                  InkWell(
                                                    onTap: onClickTestimonials,
                                                    child: WidgetText
                                                        .widgetPoppinsRegularText(
                                                            viewall,
                                                            Color(ORANGE),
                                                            12,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 210,
                                              child: PageView.builder(
                                                  pageSnapping: true,
                                                  padEnds: false,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  controller:
                                                      _pageViewController,
                                                  onPageChanged: (int index) {
                                                    setState(() {
                                                      _activeTestimonialPage =
                                                          index;
                                                      debugPrint(
                                                          '_activePage: $_activeTestimonialPage');
                                                    });
                                                  },
                                                  itemCount: (logic
                                                                  .userHomeModel
                                                                  .data
                                                                  ?.reviews
                                                                  ?.length ??
                                                              0) >=
                                                          5
                                                      ? 5
                                                      : (logic
                                                              .userHomeModel
                                                              .data
                                                              ?.reviews
                                                              ?.length ??
                                                          0),
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    logic.userHomeModel.data
                                                        ?.reviews
                                                        ?.sort((a, b) => b
                                                            .updatedAt
                                                            .toString()
                                                            .compareTo(a
                                                                .updatedAt
                                                                .toString()));

                                                    var reviewDate;
                                                    String parseTimeStampReport(
                                                        int value) {
                                                      var date = DateTime
                                                          .fromMicrosecondsSinceEpoch(
                                                              value * 1000);
                                                      var d12 = formatterMonth
                                                          .format(date);
                                                      reviewDate = d12;
                                                      return d12;
                                                    }

                                                    reviewDate =
                                                        parseTimeStampReport(
                                                            int.parse(logic
                                                                    .userHomeModel
                                                                    .data
                                                                    ?.reviews?[
                                                                        index]
                                                                    .updatedAt
                                                                    .toString() ??
                                                                ""));

                                                    return InkWell(
                                                      onTap: onClickFoodDetail,
                                                      child: Card(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                15,
                                                                15,
                                                                7.5,
                                                                15),
                                                        elevation: 5.0,
                                                        shadowColor:
                                                            Color(BLACK),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: Color(WHITE),
                                                            borderRadius: BorderRadius.circular(10.0),
                                                          ),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          // width: 100,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              logic.userHomeModel.data?.reviews?[index].userName ==
                                                                          "" ||
                                                                      logic
                                                                              .userHomeModel
                                                                              .data
                                                                              ?.reviews?[
                                                                                  index]
                                                                              .userName
                                                                              .isEmpty ==
                                                                          true
                                                                  ? WidgetText
                                                                      .widgetPoppinsRegularText(
                                                                          "Anonymous",
                                                                          Color(
                                                                              BLACK),
                                                                          16)
                                                                  : WidgetText
                                                                      .widgetPoppinsRegularText(
                                                                          logic.userHomeModel.data?.reviews?[index].userName ??
                                                                              "",
                                                                          Color(
                                                                              BLACK),
                                                                          16),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              logic
                                                                          .userHomeModel
                                                                          .data
                                                                          ?.reviews?[
                                                                              index]
                                                                          .rating ==
                                                                      null
                                                                  ? Text('')
                                                                  : RatingStars(
                                                                      value: double.parse(logic
                                                                              .userHomeModel
                                                                              .data
                                                                              ?.reviews?[index]
                                                                              .rating
                                                                              .toString() ??
                                                                          ""),
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
                                                                      starCount:
                                                                          5,
                                                                      starSpacing:
                                                                          2,
                                                                      starSize:
                                                                          20,
                                                                      starColor:
                                                                          Color(
                                                                              0xffFFD633),
                                                                      starOffColor:
                                                                          Color(
                                                                              0xffC1C1C1),
                                                                    ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              WidgetText.widgetPoppinsMaxLineOverflowText(
                                                                  logic
                                                                          .userHomeModel
                                                                          .data
                                                                          ?.reviews?[
                                                                              index]
                                                                          .review
                                                                          .toString() ??
                                                                      "",
                                                                  Color(
                                                                      SUBTEXT),
                                                                  14,
                                                                  maxline: 3),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Spacer(),
                                                              WidgetText
                                                                  .widgetPoppinsRegularText(
                                                                reviewDate,
                                                                // "14th Feb, 2022",
                                                                Color(
                                                                    LIGHTGREYCOLORICON),
                                                                14,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                          ],
                                        ),
                              logic.userHomeModel.data?.reviews == null
                                  ? Container()
                                  : new DotsIndicator(
                                      dotsCount: (logic.userHomeModel.data
                                                      ?.reviews?.length ??
                                                  0) >=
                                              5
                                          ? 5
                                          : (logic.userHomeModel.data?.reviews
                                                  ?.length ??
                                              0),
                                      position:
                                          _activeTestimonialPage.toDouble(),
                                      decorator: DotsDecorator(
                                        color: Colors.grey, // Inactive color
                                        activeColor: Color(ORANGE),
                                      ),
                                    ),
                              SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                          flex: 1,
                          fit: FlexFit.tight,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                    isLoading: !logic.isLoaderVisible);
              });
      })),
    );
  }

  onClickNotification() async {
    var result = await Navigator.of(Home.homeContext!).push(MaterialPageRoute(
        builder: (BuildContext context) => NotificationScreen()));
    setState(() {
      debugPrint('Result: $result');
      _notificationController.callNotificationAPI(false);
    });
  }

  onClickFoodDetail() {
    // Navigator.of(Home.homeContext!).push(MaterialPageRoute(
    //     builder: (BuildContext context) => FoodDetailScreen()));
  }

  onClickLocationUpdate() {
    Navigator.of(Home.homeContext!).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            LocationDetailsScreen(isFromSignup: false)));
  }

  onClickTestimonials() async {
    await Get.to(() => TestimonialScreen(
          isHome: true,
        ));
  }

  onClickSearch() {
    Navigator.of(Home.homeContext!).push(MaterialPageRoute(
        builder: (BuildContext context) => SearchScreen(
              isFromHome: false,
            )));
  }

  onClickOrder() {
    Get.to(() => NormalOrderScreen(orderStatus: 1));
  }
}

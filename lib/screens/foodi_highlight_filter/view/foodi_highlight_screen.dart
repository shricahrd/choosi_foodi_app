import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../../../core/http_utils/http_constants.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_preferences.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../../core/utils/networkManager.dart';
import '../../cart/view/cart_screen.dart';
import '../../filter_dialog/filter_dialog_screen.dart';
import '../../restaurant_details/controller/restaurant_details_controller.dart';
import '../controller/foodi_highlight_filter_ctrl.dart';

class FoodiHighlightFilterScreen extends StatefulWidget {
  @override
  State<FoodiHighlightFilterScreen> createState() =>
      _FoodiHighlightFilterScreenState();
}

class _FoodiHighlightFilterScreenState
    extends State<FoodiHighlightFilterScreen> {
  final FoodiHighlightFilterCtrl foodiHighlightCtrl =
      Get.put(FoodiHighlightFilterCtrl());
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
      HttpConstants.PARAMS_FOODTYPES: "",
      HttpConstants.PARAMS_DISTANCE: "500",
    };
    foodiHighlightCtrl.callFoodiHighlightAPI(queryParams);
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
                  foodiHighlight,
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
          : GetBuilder<FoodiHighlightFilterCtrl>(builder: (logic) {
              return logic.isLoaderVisible
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Color(ORANGE),
                      ),
                    )
                  : logic.foodiHighlightList.length == 0
                      ? Center(
                          child: Container(
                          child: Text('Foodi Highlight Not Found'),
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
                                    mainAxisExtent: 250,
                                    mainAxisSpacing: 10),
                            itemCount: logic.foodiHighlightList.length,
                            itemBuilder: (context, index) {
                              bool statusOpen = false;
                              String start = "", end = "";

                              if (logic.foodiHighlightList[index]
                                          .dishVisibilityStart.isNotEmpty ==
                                      true ||
                                  logic.foodiHighlightList[index]
                                          .dishVisibilityEnd.isNotEmpty ==
                                      true) {
                                // bool statusOpen = false;
                                start = logic.foodiHighlightList[index]
                                    .dishVisibilityStart
                                    .toString();
                                end = logic
                                    .foodiHighlightList[index].dishVisibilityEnd
                                    .toString();
                                debugPrint(
                                    'CheckDate: ${isRestaurantOpen(start, end)}');

                                if (start.isNotEmpty) {
                                  statusOpen = isRestaurantOpen(start, end);
                                  debugPrint('ISOPEN: $statusOpen');
                                }
                              }

                              return Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color:
                                  statusOpen ==
                                      true
                                      ? Color(WHITE)
                                      : Color(GREY6)
                                      .withOpacity(
                                      0.5),
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
                                          child: Container(
                                            height: 100,
                                            width: 230,
                                            child: logic
                                                        .foodiHighlightList[
                                                            index]
                                                        .menuImg
                                                        .isEmpty ==
                                                    true
                                                ? Image.asset(
                                                    ic_no_image,
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.network(
                                                    logic
                                                        .foodiHighlightList[
                                                            index]
                                                        .menuImg
                                                        .toString(),
                                                    fit: BoxFit.fill,
                                                    loadingBuilder: (BuildContext
                                                            context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) return child;
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: Color(ORANGE),
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes!
                                                              : null,
                                                        ),
                                                      );
                                                    },
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                        ic_no_image,
                                                        fit: BoxFit.fill,
                                                      );
                                                    },
                                                  ),
                                          ),
                                        ),
                                 /*       Positioned(
                                          left: 0,
                                          top: 10,
                                          child: RibbonWidget(
                                            text: 'Lunch',
                                            color: Color(ORANGE),
                                            ribbonHeight: 40,
                                            ribbonWidth: 100,
                                            ribbonTailWidth: 30,
                                          ),
                                        ),*/
                                        start == "" ? Container():
                                        Positioned(
                                          right: 0,
                                          top: 10,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color:  Color(ORANGE),
                                                  blurRadius: 3.0,
                                                ),
                                              ],
                                              color: Color(ORANGE),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5.0),
                                                bottomLeft:
                                                Radius.circular(5.0),
                                              ),
                                            ),
                                            height: 22,
                                            width: 60,
                                            alignment: Alignment.center,
                                            child: WidgetText
                                                .widgetPoppinsMediumText(
                                                logic.foodiHighlightList[index].dishType,
                                                Color(WHITE),
                                                10),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    WidgetText.widgetPoppinsMediumOverflowText(
                                        logic.foodiHighlightList[index].dishName
                                            .toString(),
                                        // "fdnfnfwfiowfiofiofioqwfiowmfiomodncosdnd",
                                        Color(BLACK),
                                        14,
                                        maxline: 1,
                                        align: TextAlign.center),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    logic.foodiHighlightList[index].foodType
                                                .isEmpty ==
                                            true
                                        ? WidgetText.widgetPoppinsRegularText(
                                            "", Color(BLACK5), 14)
                                        : WidgetText
                                            .widgetPoppinsMaxLineOverflowText(
                                                logic.foodiHighlightList[index]
                                                    .foodType
                                                    .toString(),
                                                // "Italian",
                                                Color(BLACK5),
                                                14,
                                                maxline: 1),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    WidgetText
                                        .widgetPoppinsMaxLineOverflowText(
                                            "\$ ${logic.foodiHighlightList[index]
                                                .price
                                                .toString()}",
                                            Color(ORANGE),
                                            14,
                                            align: TextAlign.center,
                                            maxline: 1),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    logic.foodiHighlightList[index].isBuyNow ==
                                            false
                                        ? Container(
                                            height: 33,
                                            width: 100,
                                            alignment: Alignment.center,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.0),
                                                  ),
                                                ),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(
                                                  Color(ORANGE),
                                                ),
                                                minimumSize:
                                                    MaterialStateProperty.all<
                                                        Size>(
                                                  Size(double.maxFinite, 45.0),
                                                ),
                                              ),
                                              onPressed: () async {
                                                if (statusOpen == true) {
                                                  setState(() {
                                                    logic
                                                        .foodiHighlightList[
                                                            index]
                                                        .setBuyNow = true;
                                                  });

                                                  await restaurantDetailsController
                                                      .postAddCardApi(
                                                          restId: logic
                                                              .foodiHighlightList[
                                                                  index]
                                                              .restaurantId
                                                              .toString(),
                                                          menuId: logic
                                                              .foodiHighlightList[
                                                                  index]
                                                              .menuId
                                                              .toString(),
                                                          selectQty: 1,
                                                          isAddOn: false);

                                                  debugPrint(
                                                      'addToCartBool timer => ${restaurantDetailsController.addToCartBool}');
                                                  if (restaurantDetailsController
                                                          .deleteCartModel
                                                          .meta
                                                          ?.status ==
                                                      true) {
                                                    var result = true;
                                                    debugPrint(
                                                        'Result => $result');
                                                    if (result) {
                                                      setState(() {
                                                        logic
                                                            .foodiHighlightList[
                                                                index]
                                                            .setBuyNow = false;
                                                        if (restaurantDetailsController
                                                                .deleteCartModel
                                                                .meta
                                                                ?.msg
                                                                .toString() !=
                                                            "This menu is from different cafe. first clear cart.") {
                                                          onClickCart();
                                                        }
                                                      });
                                                    }
                                                  } else {
                                                    setState(() {
                                                      logic
                                                          .foodiHighlightList[
                                                              index]
                                                          .setBuyNow = false;
                                                    });
                                                  }
                                                }
                                              },
                                              child: WidgetText
                                                  .widgetPoppinsMediumText(
                                                      'Buy Now',
                                                      Color(WHITE),
                                                      12),
                                            ),
                                          )
                                        : Center(
                                            child: Container(
                                              height: 20, width: 20,
                                              child: CircularProgressIndicator(
                                                color: Color(ORANGE),
                                              ),
                                            ),
                                          ),
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
    final filterValue = await Get.to(() => FilterDialogScreen(
          filterValue: filterValue1,
        ));
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
    foodiHighlightCtrl.callFoodiHighlightAPI(queryParams);
  }

  onClickFoodDetail() {
    // Get.to(() => FoodDetailScreen());
  }
}

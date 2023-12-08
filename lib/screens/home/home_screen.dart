import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_radio_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/cart/cart_screen.dart';
import 'package:choosifoodi/screens/category_detail/category_detail_screen.dart';
import 'package:choosifoodi/screens/food_detail/food_detail_screen.dart';
import 'package:choosifoodi/screens/location_details/location_details_screen.dart';
import 'package:choosifoodi/screens/notification/notification_screen.dart';
import 'package:choosifoodi/screens/orders/orders_screen.dart';
import 'package:choosifoodi/screens/search/search_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Home extends StatelessWidget {
  static BuildContext? homeContext;

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    homeContext = context;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: {
        "CategoryDetailsScreen": (context) => CategoryDetailsScreen(),
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _orderTypeValue = 0;

  List<String> featuredList = [
    "Burger",
    "North Indian",
    "Veg Biryani",
    "Pizza",
    "Chow Mein",
    "Chaat",
    "Healthy",
    "Coffee"
  ];

  @override
  void initState() {
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
                          onTap: onClickLocationUpdate,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              WidgetText.widgetPoppinsRegularText(
                                "1234 Howard Place",
                                Color(BLACK),
                                16,
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
                          width: 40,
                          alignment: Alignment.center,
                          child: Image.asset(
                            ic_cart_head,
                            height: 30,
                            width: 30,
                          ),
                        ),
                        Positioned(
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(ORANGE)),
                              color: Color(ORANGE),
                              borderRadius: BorderRadius.all(
                                Radius.circular(13.0),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: WidgetText.widgetPoppinsRegularText(
                              "2",
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
                          width: 40,
                          alignment: Alignment.center,
                          child: Image.asset(
                            ic_notification,
                            height: 22,
                            width: 22,
                          ),
                        ),
                        Positioned(
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(ORANGE)),
                              color: Color(ORANGE),
                              borderRadius: BorderRadius.all(
                                Radius.circular(13.0),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: WidgetText.widgetPoppinsRegularText(
                              "10",
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
                    width: 12,
                  ),
                  InkWell(
                    onTap: onClickSearch,
                    child: Image.asset(
                      ic_search,
                      width: 25,
                      color: Color(ORANGE),
                      height: 25,
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
                  Container(
                    decoration: BoxDecoration(
                      color: Color(WHITE),
                    ),
                    height: 200,
                    child: Swiper(
                      outer: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.asset(
                          tmp_swipe_img,
                          fit: BoxFit.fill,
                        );
                      },
                      itemCount: 3,
                      // pagination: SwiperPagination(),
                      autoplay: true,
                      viewportFraction: 0.8,
                      scale: 0.9,
                      control: SwiperControl(color: Color(ORANGE)),
                    ),
                  ),
                  new DotsIndicator(
                    dotsCount: 3,
                    position: 1,
                    decorator: DotsDecorator(
                      color: Colors.grey, // Inactive color
                      activeColor: Color(ORANGE),
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
                              });
                            },
                            child: _orderTypeValue == 0
                                ? WidgetRadioButton.selectedRadioButton(
                                    "Delivery")
                                : WidgetRadioButton.unselectedRadioButton(
                                    "Delivery"),
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
                            });
                          },
                          child: _orderTypeValue == 1
                              ? WidgetRadioButton.selectedRadioButton("Pickup")
                              : WidgetRadioButton.unselectedRadioButton(
                                  "Pickup"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: WidgetText.widgetPoppinsMediumText(
                        "Featured", Color(BLACK), 18),
                  ),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 5,
                          mainAxisExtent: 140,
                          mainAxisSpacing: 5),
                      itemCount: featuredList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                  maxHeight: 80,
                                  minWidth: 80,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(LIGHTDIVIDERCOLOR),
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                ),
                                child: Image.asset(tmp_featured_img),
                                padding: EdgeInsets.all(5),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              WidgetText.widgetPoppinsRegularText(
                                  featuredList[index], Color(BLACK), 14,
                                  align: TextAlign.center)
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Color(LIGHTDIVIDERCOLOR),
                    height: 5,
                    thickness: 5,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: WidgetText.widgetPoppinsMediumText(
                              "Nearby Restaurants", Color(BLACK), 18),
                        ),
                        InkWell(
                          onTap: onClickCategory,
                          child: WidgetText.widgetPoppinsRegularText(
                              "View all", Color(ORANGE), 12,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                    height: 220,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 250,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            decoration: BoxDecoration(
                              color: Color(WHITE),
                              shape: BoxShape.rectangle,
                              border:
                                  Border.all(color: Color(ORANGE), width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Image.asset(
                                      tmp_restorant_img,
                                      height: 100,
                                      width: 230,
                                      fit: BoxFit.fill,
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
                                          color: Color(ORANGE),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5.0),
                                            bottomLeft: Radius.circular(5.0),
                                          ),
                                        ),
                                        height: 22,
                                        width: 53,
                                        alignment: Alignment.center,
                                        child:
                                            WidgetText.widgetPoppinsMediumText(
                                                "Open", Color(WHITE), 12),
                                      ),
                                    ),
                                    Positioned(
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
                                        width: 70,
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
                                            WidgetText.widgetPoppinsMediumText(
                                                "27 min", Color(BLACK), 12)
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 7,
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
                                        width: 70,
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
                                            WidgetText.widgetPoppinsMediumText(
                                                "5 miles", Color(BLACK), 12)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                WidgetText.widgetPoppinsMediumText(
                                    "The Breakfast Club", Color(BLACK), 16),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    WidgetText.widgetPoppinsRegularText(
                                        "Italian",
                                        Color(SUBTEXTBLACKCOLOR),
                                        14),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    RatingStars(
                                      value: 3.5,
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
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
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
                                    onPressed: onClickFoodDetail,
                                    child: WidgetText.widgetPoppinsMediumText(
                                        "View More", Color(WHITE), 12),
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
                  new DotsIndicator(
                    dotsCount: 3,
                    position: 1,
                    decorator: DotsDecorator(
                      color: Colors.grey, // Inactive color
                      activeColor: Color(ORANGE),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: Color(LIGHTDIVIDERCOLOR),
                    height: 5,
                    thickness: 5,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: WidgetText.widgetPoppinsMediumText(
                              "Foodi Highlights", Color(BLACK), 18),
                        ),
                        InkWell(
                          onTap: onClickCategory,
                          child: WidgetText.widgetPoppinsRegularText(
                              "View all", Color(ORANGE), 12,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                    height: 220,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 250,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            decoration: BoxDecoration(
                              color: Color(WHITE),
                              shape: BoxShape.rectangle,
                              border:
                                  Border.all(color: Color(ORANGE), width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  temp_img_food4,
                                  height: 100,
                                  width: 230,
                                  fit: BoxFit.fill,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: WidgetText.widgetPoppinsMediumText(
                                          "Veg Biryani", Color(BLACK), 16),
                                      flex: 1,
                                      fit: FlexFit.tight,
                                    ),
                                    WidgetText.widgetPoppinsMediumText(
                                        "\$202", Color(ORANGE), 16),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                WidgetText.widgetPoppinsRegularText(
                                    "The Breakfast Club", Color(BLACK), 14),
                                SizedBox(
                                  height: 5,
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
                                    onPressed: onClickFoodDetail,
                                    child: WidgetText.widgetPoppinsMediumText(
                                        "Buy Now", Color(WHITE), 12),
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
                  new DotsIndicator(
                    dotsCount: 3,
                    position: 1,
                    decorator: DotsDecorator(
                      color: Colors.grey, // Inactive color
                      activeColor: Color(ORANGE),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: Color(LIGHTDIVIDERCOLOR),
                    height: 5,
                    thickness: 5,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: WidgetText.widgetPoppinsMediumText(
                              "Testimonials", Color(BLACK), 18),
                        ),
                        WidgetText.widgetPoppinsRegularText(
                            "View all", Color(ORANGE), 12,
                            decoration: TextDecoration.underline)
                      ],
                    ),
                  ),
                  Container(
                    height: 210,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: onClickFoodDetail,
                            child: Card(
                              margin: EdgeInsets.fromLTRB(15, 15, 7.5, 15),
                              color: Color(WHITE),
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              shadowColor: Color(BLACK),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: 280,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    WidgetText.widgetPoppinsRegularText(
                                        "Suman Gosain", Color(BLACK), 16),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    RatingStars(
                                      value: 3.5,
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
                                    WidgetText.widgetPoppinsRegularText(
                                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                        Color(SUBTEXT),
                                        14),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    WidgetText.widgetPoppinsRegularText(
                                        "14th Feb, 2022",
                                        Color(LIGHTGREYCOLORICON),
                                        14),
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
                  new DotsIndicator(
                    dotsCount: 3,
                    position: 1,
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
      ),
    );
  }

  onClickCart() {
    Navigator.of(Home.homeContext!).push(
        MaterialPageRoute(builder: (BuildContext context) => CartScreen()));
  }

  onClickNotification() {
    Navigator.of(Home.homeContext!).push(MaterialPageRoute(
        builder: (BuildContext context) => NotificationScreen()));
  }

  onClickFoodDetail() {
    Navigator.of(Home.homeContext!).push(MaterialPageRoute(
        builder: (BuildContext context) => FoodDetailScreen()));
  }

  onClickLocationUpdate() {
    Navigator.of(Home.homeContext!).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            LocationDetailsScreen(isUpdateLocation: true)));
  }

  onClickCategory() {
    Navigator.pushNamed(context, "CategoryDetailsScreen");

    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (BuildContext context) => CategoryDetailsScreen()));
  }

  onClickSearch() {
    Navigator.of(Home.homeContext!).push(
        MaterialPageRoute(builder: (BuildContext context) => SearchScreen()));
  }
}

import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/filter_dialog/filter_dialog_screen.dart';
import 'package:choosifoodi/screens/food_detail/food_detail_screen.dart';
import 'package:choosifoodi/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class CategoryDetailsScreen extends StatefulWidget {
  @override
  _CategoryDetailsScreenState createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
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
                  "Nearby restaurants",
                  Color(BLACK),
                  18,
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
                child: _foodiCategoryDetails11(),
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

  Widget _foodiCategoryDetails11() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: GridView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisExtent: 300,
            mainAxisSpacing: 10),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(WHITE),
              shape: BoxShape.rectangle,
              border: Border.all(color: Color(ORANGE), width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
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
                        child: WidgetText.widgetPoppinsMediumText(
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
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        height: 26,
                        width: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                WidgetText.widgetPoppinsMediumText(
                    "The Breakfast Club", Color(BLACK), 14),
                SizedBox(
                  height: 5,
                ),
                WidgetText.widgetPoppinsRegularText(
                    "Italian", Color(SUBTEXTBLACKCOLOR), 14),
                SizedBox(
                  height: 5,
                ),
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
                    WidgetText.widgetPoppinsMediumText(
                        "5 miles", Color(BLACK), 12),
                  ],
                ),
                SizedBox(
                  height: 15,
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
                  height: 15,
                ),
                Container(
                  height: 33,
                  width: 100,
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Color(ORANGE),
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
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
        },
      ),
    );
  }

  onClickApplyFilter() {
    Navigator.of(Home.homeContext == null ? context : Home.homeContext!).push(
        MaterialPageRoute(
            builder: (BuildContext context) => FilterDialogScreen()));
  }

  onClickFoodDetail() {
    Navigator.of(Home.homeContext == null ? context : Home.homeContext!).push(
        MaterialPageRoute(
            builder: (BuildContext context) => FoodDetailScreen()));
  }
}

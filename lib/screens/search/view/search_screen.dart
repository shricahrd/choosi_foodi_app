import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../core/utils/app_preferences.dart';
import '../../../core/utils/app_strings_constants.dart';
import '../../restaurant_details/view/restaurant_details_screen.dart';
import '../controller/global_search_controller.dart';

class SearchScreen extends StatefulWidget {
  final bool isFromHome;

  SearchScreen({
    required this.isFromHome,
  });

  @override
  _SearchScreenState createState() => _SearchScreenState(isFromHome);
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalSearchController globalSearchController =
      Get.put(GlobalSearchController());
  TextEditingController searchController = TextEditingController();

  bool isFromHome = false;
  var lat, long, searchValue = "";

  _SearchScreenState(bool isFromHome) {
    this.isFromHome = isFromHome;
  }

  @override
  void initState() {
    getSpData();
    super.initState();
  }

  getSpData() async {
    lat = await AppPreferences.getLat();
    long = await AppPreferences.getLong();
    if (lat != null && long != null) {
      if (lat != "" && long != "") {
        globalSearchController.callSearchAPI(
          lat: lat,
          long: long,
          search: searchValue,
        );
      }
    }
  }

  @override
  void dispose() {
    searchValue = "";
    searchController.clear();
    globalSearchController.searchResult.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
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
                mainAxisSize: MainAxisSize.max,
                children: [
                  isFromHome
                      ? Container(
                          height: 20,
                        ) : InkWell(
                          onTap: () {
                            Navigator.of(context).pop(false);
                          },
                          child: Image.asset(
                            ic_right_side_arrow,
                            width: 18,
                            height: 18,
                          ),
                        ),
                  SizedBox(
                    width: 15,
                  ),
                  WidgetText.widgetRobotoMediumText(
                    search,
                    Color(BLACK),
                    20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Column(children: [
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
                        controller: searchController,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Color(LIGHTHINTCOLOR),
                            fontSize: 16,
                            fontFamily: FontRoboto,
                            fontWeight: RobotoRegular,
                          ),
                          hintText: search,
                        ),
                        style: TextStyle(
                          color: Color(BLACK),
                          fontSize: 16,
                          fontFamily: FontRoboto,
                          fontWeight: RobotoMedium,
                        ),
                        onChanged: (value) {
                          setState(() {
                            print("$lat $long");
                            searchValue = searchController.text;
                            globalSearchController.callSearchAPI(
                              lat: lat,
                              long: long,
                              search: searchValue,
                            );
                            // searchLocation = value;
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
            ]),
            Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: GetBuilder<GlobalSearchController>(builder: (logic) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Color(WHITE),
                        ),
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: logic.searchResult.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              await Get.to(() => RestaurantDetailsScreen(
                                    restaurantid:
                                        logic.searchResult[index].id.toString(),
                                  ));

                              setState(() {
                                searchController.clear();
                                logic.searchResult.clear();
                                searchValue = "";
                              });
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                index == 0
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            child: Text(
                                                logic.searchResult[index]
                                                    .refranceName,
                                                style: TextStyle(
                                                  color: Color(ORANGE),
                                                  fontSize: 16,
                                                  fontFamily: FontRoboto,
                                                  fontWeight: RobotoMedium,
                                                )),
                                          )
                                        ],
                                      )
                                    : logic.searchResult[index].refranceName ==
                                            logic.searchResult[index - 1]
                                                .refranceName
                                        ? Container()
                                        : Column(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                child: Text(
                                                    logic.searchResult[index]
                                                        .refranceName,
                                                    style: TextStyle(
                                                      color:
                                                          Color(ORANGE),
                                                      fontSize: 16,
                                                      fontFamily: FontRoboto,
                                                      fontWeight: RobotoMedium,
                                                    )),
                                              )
                                            ],
                                          ),
                                SizedBox(
                                  height: 20,
                                ),
                                WidgetText.widgetRobotoRegularText(
                                  logic.searchResult[index].name.toString(),
                                  Color(BLACK),
                                  16,
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
                        }),
                  );
                })),
          ],
        ),
      ),
    );
  }
}

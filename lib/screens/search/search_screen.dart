import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  InkWell(
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
                    "Search",
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
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Color(LIGHTHINTCOLOR),
                          fontSize: 16,
                          fontFamily: FontRoboto,
                          fontWeight: RobotoRegular,
                        ),
                        hintText: "Search",
                      ),
                      style: TextStyle(
                        color: Color(BLACK),
                        fontSize: 16,
                        fontFamily: FontRoboto,
                        fontWeight: RobotoMedium,
                      ),
                      onChanged: (value) {
                        setState(() {
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
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(WHITE),
                ),
                padding: EdgeInsets.all(15),
                width: double.infinity,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          index == 0
                              ? WidgetText.widgetRobotoMediumText(
                                  "Restaurants",
                                  Color(ORANGE),
                                  16,
                                )
                              : WidgetText.widgetRobotoRegularText(
                                  "Pattycake Vegan Bakery",
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
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

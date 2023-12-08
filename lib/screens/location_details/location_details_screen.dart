import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_font_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_button.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

class LocationDetailsScreen extends StatefulWidget {
  final bool isUpdateLocation;

  const LocationDetailsScreen({Key? key, required this.isUpdateLocation})
      : super(key: key);

  @override
  _LocationDetailsScreenState createState() =>
      _LocationDetailsScreenState(isUpdateLocation);
}

class _LocationDetailsScreenState extends State<LocationDetailsScreen> {
  String searchLocation = "";
  bool isUpdateLocation = false;

  _LocationDetailsScreenState(bool isUpdateLocation) {
    this.isUpdateLocation = isUpdateLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                  isUpdateLocation
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
                  isUpdateLocation
                      ? SizedBox(
                          width: 15,
                        )
                      : Container(),
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
                        child: isUpdateLocation && searchLocation.isEmpty
                            ? Container(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    WidgetText.widgetRobotoRegularText(
                                      "Previously user address",
                                      Color(BLACK),
                                      16,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          itemCount: 3,
                                          itemBuilder: (context, index) {
                                            return Column(
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
                                                            "240 Parsone Avenue",
                                                            Color(DARKGREY),
                                                            16,
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          WidgetText
                                                              .widgetRobotoRegularText(
                                                            "Columbus, OH",
                                                            Color(DARKGREY),
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
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Column(
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
                                            width: 3,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                WidgetText.widgetRobotoRegularText(
                                                  "240 Parsone Avenue",
                                                  Color(BLACK),
                                                  16,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                WidgetText.widgetRobotoRegularText(
                                                  "Columbus, OH",
                                                  Color(DARKGREY),
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
                      child: WidgetButton.widgetDefaultButton(
                          "Next", onClickNext),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onClickNext() {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginScreen()), (r) => false);
  }
}

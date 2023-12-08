import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
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
              WidgetText.widgetPoppinsRegularText(
                "FAQ's",
                Color(BLACK),
                18,
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: WidgetText.widgetPoppinsMediumText(
                "We are happy to help",
                Color(ORANGE),
                18,
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
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  // bool showDetail = true;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          // setState(() {
                          //   if (showDetail) {
                          //     showDetail = false;
                          //   } else {
                          //     showDetail = true;
                          //   }
                          // });
                          setState(() {
                            if (selectedIndex == index) {
                              selectedIndex = -1;
                            } else {
                              selectedIndex = index;
                            }
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: WidgetText.widgetPoppinsMediumText(
                                  "Lorem ipsum dolor sit amet",
                                  Color(BLACK),
                                  16,
                                ),
                              ),
                              Image.asset(
                                // showDetail == true
                                index == selectedIndex
                                    ? ic_down_arrow
                                    : ic_left_side_arrow,
                                height: 15,
                                color: Color(ORANGE),
                                width: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                      // showDetail == true
                      index == selectedIndex
                          ? Padding(
                              padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                              child: WidgetText.widgetPoppinsRegularText(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                Color(SUBTEXT),
                                13,
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                          height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                    ],
                  );
                },
              ),
              flex: 1,
              fit: FlexFit.tight,
            ),
          ],
        ),
      ),
    );
  }
}

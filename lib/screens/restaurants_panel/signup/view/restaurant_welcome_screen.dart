import 'package:choosifoodi/screens/restaurants_panel/restaurant_base_application/restaurant_base_application.dart';
import 'package:choosifoodi/screens/restaurants_panel/signup/view/restaurant_mobile_no_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_color_utils.dart';
import '../../../../core/utils/app_images_utils.dart';
import '../../../../core/widgets/widget_button.dart';
import '../../../../core/widgets/widget_text.dart';
import '../../../../routes/all_routes.dart';

class RestaurantWelcomeScreen extends StatefulWidget {
  @override
  _RestaurantWelcomeScreenState createState() =>
      _RestaurantWelcomeScreenState();
}

class _RestaurantWelcomeScreenState extends State<RestaurantWelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(WHITE),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.transparent, //change your color here
        ),
        toolbarHeight: 60,
        shadowColor: Color(HINTCOLOR),
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
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => RestaurantMobileNoScreen()),
                      (Route<dynamic> route) => false);
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
              WidgetText.widgetPoppinsRegularText(
                "Welcome",
                Color(BLACK),
                18,
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.asset(
                      app_logo,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  flex: 5,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      WidgetText.widgetRobotoRegularText(
                          "Welcome to Choosi Foodi", Color(BLACK), 20,
                          align: TextAlign.center),
                      SizedBox(height: 10,),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: WidgetText.widgetRobotoRegularText(
                            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. "
                                "Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec,"
                                " pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec.", Color(DARKGREY), 16,
                            align: TextAlign.center),
                      ),
                    ],
                  ),
                  flex: 5,
                )
              ],
            ),
            Positioned(
              bottom: 10,
              width: MediaQuery.of(context).size.width,
              child: Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: WidgetButton.widgetDefaultButton(
                      "Next", (){
                    Get.offAllNamed(AllRoutes.login);
                  })),
            ),
          ],
        ),
      ),
    );
  }

  onClickNext() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) =>
            RestaurantBaseApplication()));
  }
}

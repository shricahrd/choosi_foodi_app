import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/restaurants_panel/signup/view/tabs/bank_rest_info_screen.dart';
import 'package:choosifoodi/screens/restaurants_panel/signup/view/tabs/rest_signup_info_screen.dart';
import 'package:choosifoodi/screens/restaurants_panel/signup/view/tabs/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/app_images_utils.dart';
import '../restaurant_mobile_no_screen.dart';

class SignupTabScreen extends StatefulWidget {
  String mobile;
  SignupTabScreen({Key? key,required this.mobile}) : super(key: key);

  @override
  State<SignupTabScreen> createState() => _SignupTabScreenState();
}

class _SignupTabScreenState extends State<SignupTabScreen>  with SingleTickerProviderStateMixin{
  late TabController _controller;
  int selectedIndex = 0;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this, initialIndex: 0);
    _controller.animateTo(selectedIndex);
    super.initState();
  }

  // void moveToWelcomeScreen() {
  //   Get.offAll(() => RestaurantWelcomeScreen());
  // }

   void moveToBankTab() {
    setState(() {
      selectedIndex = 2;
      debugPrint('selectedIndex: $selectedIndex');
      _controller.animateTo(selectedIndex);
    });
  }

  void moveToRestTab() {
    setState(() {
      selectedIndex = 1;
      debugPrint('selectedIndex: $selectedIndex');
      _controller.animateTo(selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(

          appBar: AppBar(
            shape: Border(bottom: BorderSide(color: Color(GREY))),
            backgroundColor: Color(WHITE),
            iconTheme: IconThemeData(
              color: Colors.orange, //change your color here
            ),
            toolbarHeight: 60,
            shadowColor: Color(LIGHTHINTCOLOR),
            flexibleSpace: Container(
              color: Color(WHITE),
              height: double.infinity,
              padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
              alignment: Alignment.bottomCenter,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                  onTap: () {
                      Get.offAll(() => RestaurantMobileNoScreen());
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
                    "Sign Up",
                    Color(BLACK),
                    16,
                  )
                ],
              ),
            ),
            elevation: 4,
          ),
          backgroundColor: Color(WHITE),
          body: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                SizedBox(height: 10,),
               Container(
                 constraints: BoxConstraints.expand(height: 50),
                 child:  TabBar(
                   // isScrollable: true,
                   indicatorSize: TabBarIndicatorSize.label,
                   controller: _controller,
                   indicatorColor: Color(ORANGE),
                   unselectedLabelColor: Colors.white.withOpacity(0.3),
                   labelPadding: EdgeInsets.all(2),
                   indicatorWeight: 3,
                   // unselectedLabelColor: Colors.black,
                   tabs: [
                     WidgetText.widgetPoppinsMediumText("Owner Info",
                       selectedIndex == 0
                           ? Color(BLACK)
                           : Color(0xff848383), 14,),
                     WidgetText.widgetPoppinsMediumText("Restaurant Info",
                       selectedIndex == 1
                           ? Color(BLACK)
                           : Color(0xff848383), 14,),
                     WidgetText.widgetPoppinsMediumText("Bank Info",
                       selectedIndex == 2
                           ? Color(BLACK)
                           : Color(0xff848383), 14,),
                   ],
                   onTap: (int index) {
                     setState(() {
                       print('Selected Tab: $index');
                       selectedIndex = index;
                     });
                   },
                 ),
               ),
                Expanded(
                  child: TabBarView(
                    controller: _controller,
                    children: [
                      SignupForm(mobile: widget.mobile,moveToRestTab: moveToRestTab,),
                      RestaurantSignupInfo(moveToBankTab: moveToBankTab,),
                      BankRestInfo(mobile: widget.mobile,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/screens/restaurants_panel/dashboard/view/dashboard.dart';
import 'package:choosifoodi/screens/restaurants_panel/profileRest/view/profile_rest_screen.dart';
import 'package:choosifoodi/screens/restaurants_panel/setting/setting_rest_screen.dart';
import 'package:flutter/material.dart';
import '../order/view/orders_mgmt_screen.dart';

class RestaurantBaseApplication extends StatefulWidget {
  @override
  RestaurantBaseApplicationState createState() =>
      RestaurantBaseApplicationState();
}

class RestaurantBaseApplicationState extends State<RestaurantBaseApplication> {
  int _selectedIndex = 0;

  List<Widget> viewContainer = [
    DashboardScreen(),
    OrderManagementScreen( isFromHome: true,),
    ProfileRestScreen(
      isFromHome: true,
    ),
    SettingRestScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(WHITE),
        body: viewContainer[_selectedIndex],
        extendBody: true,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(WHITE),
          elevation: 5.0,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                ic_home_menu,
                color:
                    _selectedIndex == 0 ? Color(ORANGE) : Color(UNSELECTEDICON),
                width: 25,
                height: 25,
              ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                ic_mask,
                color:
                    _selectedIndex == 1 ? Color(ORANGE) : Color(UNSELECTEDICON),
                width: 25,
                height: 25,
              ),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                ic_profile,
                color:
                    _selectedIndex == 2 ? Color(ORANGE) : Color(UNSELECTEDICON),
                width: 25,
                height: 25,
              ),
              label: 'My Profile',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                ic_setting_menu,
                color:
                    _selectedIndex == 3 ? Color(ORANGE) : Color(UNSELECTEDICON),
                width: 25,
                height: 25,
              ),
              label: 'More',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

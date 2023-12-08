import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/screens/foodi_goal/foodi_goal_add_edit.dart';
import 'package:choosifoodi/screens/home/home_screen.dart';
import 'package:choosifoodi/screens/search/search_screen.dart';
import 'package:choosifoodi/screens/setting/setting_screen.dart';
import 'package:flutter/material.dart';

class BaseApplication extends StatefulWidget {
  @override
  _BaseApplicationState createState() => _BaseApplicationState();
}

class _BaseApplicationState extends State<BaseApplication> {
  int _selectedIndex = 0;

  List<Widget> viewContainer = [
    Home(),
    FoodiGoalAddEditScreen(isEditFoodiGoal: false, isFromHome: true,isFromSignup: false,),
    SearchScreen(),
    SettingScreen(),
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
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                app_icon,
                color:
                    _selectedIndex == 1 ? Color(ORANGE) : Color(UNSELECTEDICON),
                width: 25,
                height: 25,
              ),
              label: 'Foodi Goal',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                ic_search,
                color:
                    _selectedIndex == 2 ? Color(ORANGE) : Color(UNSELECTEDICON),
                width: 25,
                height: 25,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                ic_setting_menu,
                color:
                    _selectedIndex == 3 ? Color(ORANGE) : Color(UNSELECTEDICON),
                width: 25,
                height: 25,
              ),
              label: 'Menu',
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

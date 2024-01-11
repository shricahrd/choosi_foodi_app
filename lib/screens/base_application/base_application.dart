import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/screens/foodi_goal/view/foodi_goal_add_edit.dart';
import 'package:choosifoodi/screens/home/view/home_screen.dart';
import 'package:choosifoodi/screens/search/view/search_screen.dart';
import 'package:choosifoodi/screens/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/networkManager.dart';
import '../foodi_goal/controller/foodi_goal_view_controller.dart';
import '../foodi_goal/view/foodi_goal_result.dart';
import 'base_controller.dart';

class BaseApplication extends StatefulWidget {

  @override
  _BaseApplicationState createState() => _BaseApplicationState();
}

class _BaseApplicationState extends State<BaseApplication> {
  int _selectedIndex = 0;
  final GetXNetworkManager _networkManager = Get.put(GetXNetworkManager());
  final FoodieViewController foodieViewController = Get.put(FoodieViewController());
  final TabBarItemController tabBarItemControllerController = Get.put(TabBarItemController(), permanent: true);

  @override
  void initState() {
    if (_networkManager.connectionType != 0) {
      debugPrint('Connection Type: ${_networkManager.connectionType}');
      callApi();
    }
    super.initState();
  }

  callApi() async {
    await foodieViewController.callGetFoodGoalAPI();
    if(foodieViewController.foodiGoalModel.meta?.status == true){
      tabBarItemControllerController.isFoodiGoalUpdated.value = true;
    }else{
      tabBarItemControllerController.isFoodiGoalUpdated.value = false;
    }

    if(mounted){
      setState(() {
      });
    }
  }

  List<Widget> viewContainer = [
    Home(),
    FoodiGoalAddEditScreen(isEditFoodiGoal: false, isFromHome: true,),
    SearchScreen(isFromHome: true),
    SettingScreen(isEditFoodiGoal: false),
  ];

  List<Widget> viewContainer1 = [
    Home(),
    FoodiGoalResultScreen(isFromHome: true,isEdit: true),
    SearchScreen(isFromHome: true),
    SettingScreen(isEditFoodiGoal: true),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(WHITE),
        body: Obx(()=> tabBarItemControllerController.isFoodiGoalUpdated.value == false ? viewContainer[_selectedIndex] : viewContainer1[_selectedIndex],),
        // body: widget.isFoodiGoalCal == false ? viewContainer[_selectedIndex] : viewContainer1[_selectedIndex],
        // body: isFoodiGoalUpdated == false ? viewContainer[_selectedIndex] : viewContainer1[_selectedIndex],
        extendBody: true,
        bottomNavigationBar:  BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(WHITE),
          elevation: 5.0,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                ic_home_menu,
                color: _selectedIndex == 0 ? Color(ORANGE) : Color(UNSELECTEDICON),
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
          onTap: onItemTapped,
        ));
  }

  onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

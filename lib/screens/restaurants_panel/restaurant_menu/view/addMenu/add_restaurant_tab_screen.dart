import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_images_utils.dart';
import 'package:choosifoodi/core/utils/app_strings_constants.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/restaurants_panel/restaurant_menu/view/addMenu/add_general_info_screen.dart';
import 'package:choosifoodi/screens/restaurants_panel/restaurant_menu/view/addMenu/add_image_screen.dart';
import 'package:choosifoodi/screens/restaurants_panel/restaurant_menu/view/addMenu/add_macro_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/rest_menu_tab_controller.dart';
import 'add_otherAddOns_screen.dart';

class AddRestaurantTabScreen extends StatefulWidget {

  AddRestaurantTabScreen({Key? key,}) : super(key: key);

  @override
  State<AddRestaurantTabScreen> createState() => _AddRestaurantTabScreenState();
}

class _AddRestaurantTabScreenState extends State<AddRestaurantTabScreen>
    with SingleTickerProviderStateMixin {
  final MenuRestTabController menuRestTabController = Get.put(
      MenuRestTabController());

  // int menuRestTabController.selectedIndex.value, = 0;
  // late TabController _controller;
  // String appbarName = "General Information";


  @override
  void initState() {
    menuRestTabController.tabController =
        TabController(length: 4, vsync: this, initialIndex: 0);
    menuRestTabController.tabController.animateTo(
        menuRestTabController.selectedIndex.value);
    menuRestTabController.tabController.addListener(
        menuRestTabController.onPositionChange);
    super.initState();
  }

  @override
  void dispose() {
    menuRestTabController.tabController.dispose();
    menuRestTabController.dispose();
    super.dispose();
  }


  /* @override
  void initState() {
    _controller = TabController(length: 4, vsync: this, initialIndex: 0);
    _controller.animateTo(menuRestTabController.selectedIndex.value,);
    super.initState();
  }

  void moveToImageTab() {
    setState(() {
      menuRestTabController.selectedIndex.value, = 1;
      print('menuRestTabController.selectedIndex.value,: menuRestTabController.selectedIndex.value,');
      _controller.animateTo(menuRestTabController.selectedIndex.value,);
      appbarName = "Images";
    });
  }

  void moveToMacroTab() {
    setState(() {
      menuRestTabController.selectedIndex.value, = 2;
      print('menuRestTabController.selectedIndex.value,: menuRestTabController.selectedIndex.value,');
      _controller.animateTo(menuRestTabController.selectedIndex.value,);
      appbarName = "Macronutrient Information";
    });
  }

  void moveToAddonsTab() {
    setState(() {
      menuRestTabController.selectedIndex.value, = 3;
      print('menuRestTabController.selectedIndex.value,: menuRestTabController.selectedIndex.value,');
      _controller.animateTo(menuRestTabController.selectedIndex.value,);
      appbarName = "Other Addons";
    });
  }
  */
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.transparent, //change your color here
          ),
          // shape: Border(bottom: BorderSide(color: Color(DARKGREY))),
          backgroundColor: Color(WHITE),
          // automaticallyImplyLeading: false,
          toolbarHeight: 60,
          elevation: 3,
          shadowColor: Color(HINTCOLOR),
          flexibleSpace: Container(
            height: double.infinity,
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ic_right_side_arrow,
                  width: 25,
                  color: Color(ORANGE),
                  height: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                WidgetText.widgetPoppinsRegularText(
                  menuRestTabController.appbarName.value,
                  Color(BLACK),
                  18,
                )
              ],
            ),
          ),
        ),
        backgroundColor: Color(WHITE),
        body: SafeArea(
          child: DefaultTabController(
            length: 4,
            initialIndex: menuRestTabController.selectedIndex.value,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  child: TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    labelPadding: EdgeInsets.all(12),
                    controller: menuRestTabController.tabController,
                    indicatorColor: Color(ORANGE),
                    unselectedLabelColor: Colors.white.withOpacity(0.3),
                    // labelPadding: EdgeInsets.all(12),
                    indicatorWeight: 4,
                    tabs: [
                      WidgetText.widgetPoppinsMediumText(
                        "General Info",
                        menuRestTabController.selectedIndex.value == 0
                            ? Color(BLACK)
                            : Color(0xff848383),
                        16,
                      ),
                      WidgetText.widgetPoppinsMediumText(
                        imagesTxt,
                        menuRestTabController.selectedIndex.value == 1
                            ? Color(BLACK)
                            : Color(0xff848383),
                        16,
                      ),
                      WidgetText.widgetPoppinsMediumText(
                        macroInfoTxt,
                        menuRestTabController.selectedIndex.value == 2
                            ? Color(BLACK)
                            : Color(0xff848383),
                        16,
                      ),
                      WidgetText.widgetPoppinsMediumText(
                        addOnsTxt,
                        menuRestTabController.selectedIndex.value == 3
                            ? Color(BLACK)
                            : Color(0xff848383),
                        16,
                      ),
                    ],
                    onTap: (int index) {
                      print('Selected Tab: $index');
                      menuRestTabController.selectedIndex.value = index;
                      menuRestTabController.appbarNameChange(index);
                      // setState(() {
                      //
                      // });
                    },
                  ),
                ),
                Divider(
                    height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                Flexible(
                  flex: 20,
                  fit: FlexFit.loose,
                  child: TabBarView(
                    controller: menuRestTabController.tabController,
                    children: [
                      AddGeneralInfoScreen(moveToImageTab: menuRestTabController.moveToImageTab),
                      AddImageScreen(moveToMacroTab: menuRestTabController.moveToMacroTab),
                      AddMacroInfoScreen(moveToAddonsTab: menuRestTabController.moveToOtherAddonsTab,),
                      AddOtherAddOnScreen(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
/*
  appbarNameChange(int index){
    if(index == 0){
      setState((){
        appbarName = "General Information";
      });
    }else if(index == 1){
      setState((){
        appbarName = "Images";
      });
    }else if(index == 2){
      setState((){
        appbarName = "Macronutrient Information";
      });
    }else if(index == 3){
      setState((){
        appbarName = "Add-Ons";
      });
    }*/
}

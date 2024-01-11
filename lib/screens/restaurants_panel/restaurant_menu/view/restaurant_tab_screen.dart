import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/utils/app_constants.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/restaurants_panel/restaurant_menu/view/restaurant_tab_details/general_info_screen.dart';
import 'package:choosifoodi/screens/restaurants_panel/restaurant_menu/view/restaurant_tab_details/image_screen.dart';
import 'package:choosifoodi/screens/restaurants_panel/restaurant_menu/view/restaurant_tab_details/macro_info_screen.dart';
import 'package:choosifoodi/screens/restaurants_panel/restaurant_menu/view/restaurant_tab_details/otherAddOns_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/app_images_utils.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../controller/rest_menu_tab_controller.dart';
import '../controller/rest_menu_view_controller.dart';

class RestaurantMenuTabScreen extends StatefulWidget {
  String menuId;
  bool isEditable;

  RestaurantMenuTabScreen(
      {Key? key, required this.menuId, required this.isEditable})
      : super(key: key);

  @override
  State<RestaurantMenuTabScreen> createState() => _RestaurantTabScreenState();
}

class _RestaurantTabScreenState extends State<RestaurantMenuTabScreen>
    with SingleTickerProviderStateMixin {
  final RestMenuViewController restMenuViewController =
  Get.put(RestMenuViewController());
  final MenuRestTabController menuRestTabController =
  Get.put(MenuRestTabController());

  @override
  void initState() {
    restMenuViewController.isEditable.value = widget.isEditable;
    debugPrint("isEditable value : ${restMenuViewController.isEditable.value}");
    menuRestTabController.tabController =
        TabController(length: 4, vsync: this, initialIndex: 0);
    setTabIndex();
    restMenuViewController.getMenuDetailsApi(widget.menuId);
    super.initState();
  }

  setTabIndex() {
    menuRestTabController.tabController
        .animateTo(menuRestTabController.selectedIndex.value);
    menuRestTabController.tabController
        .addListener(menuRestTabController.onPositionChange);
  }

  @override
  void dispose() {
    menuRestTabController.tabController.dispose();
    menuRestTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.transparent, //change your color here
          ),
          toolbarHeight: 60,
          elevation: 4,
          shadowColor: Color(HINTCOLOR),
          backgroundColor: Color(WHITE),
          flexibleSpace: Container(
            color: Color(WHITE),
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
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: WidgetText.widgetPoppinsMaxLineOverflowText(
                    menuRestTabController.appbarName.value,
                    Color(BLACK),
                    16,
                  ),
                ),
                InkWell(
                  onTap: () {
                    restMenuViewController.isEditable.value = !restMenuViewController.isEditable.value;
                    setTabIndex();
                  },
                  child: WidgetText.widgetPoppinsRegularText(
                    restMenuViewController.isEditable.value == true
                        ? "View"
                        : "Edit",
                    Color(BLACK),
                    14,
                  ),)
              ],
            ),
          ),
        ),
        backgroundColor: Color(WHITE),
        body: SafeArea(
          child: GetBuilder<RestMenuViewController>(builder: (logic) {
            return logic.isLoaderVisible == true
                ? Center(
              child: CircularProgressIndicator(
                color: Color(ORANGE),
              ),
            )
                : DefaultTabController(
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
                        controller: menuRestTabController.tabController,
                        tabAlignment: TabAlignment.start,
                        indicatorColor: Color(ORANGE),
                        unselectedLabelColor: Colors.white.withOpacity(0.3),
                        labelPadding: EdgeInsets.all(12),
                        indicatorWeight: 3,
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
                        },
                      ),
                    ),
                  Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(DIVIDERCOLOR)),

                  Flexible(
                    flex: 20,
                    fit: FlexFit.loose,
                    child: TabBarView(
                      controller: menuRestTabController.tabController,
                      children: [
                        GeneralInfoScreen(
                          isEditable: restMenuViewController.isEditable.value,
                          moveToImageTab:
                          menuRestTabController.moveToImageTab,
                        ),
                        ImageScreen(
                            isEditable: restMenuViewController.isEditable.value,
                            moveToMacroTab:
                            menuRestTabController.moveToMacroTab),
                        MacroInfoScreen(
                          isEditable: restMenuViewController.isEditable.value,
                          moveToAddons:
                          menuRestTabController.moveToOtherAddonsTab,
                        ),
                        OtherAddOnScreen(
                          isEditable: restMenuViewController.isEditable.value,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      );
    });
  }

}

import 'package:choosifoodi/core/utils/app_color_utils.dart';
import 'package:choosifoodi/core/widgets/widget_text.dart';
import 'package:choosifoodi/screens/restaurants_panel/profileRest/view/tab/category_screen.dart';
import 'package:choosifoodi/screens/restaurants_panel/profileRest/view/tab/owner_info_screen.dart';
import 'package:choosifoodi/screens/restaurants_panel/profileRest/view/tab/restaurant_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../core/utils/app_images_utils.dart';
import '../../../../core/utils/app_strings_constants.dart';
import '../controller/profile_tab_controller.dart';
import 'tab/bank_info_screen.dart';

class ProfileTabScreen extends StatefulWidget {

  ProfileTabScreen({Key? key,}) : super(key: key);

  @override
  State<ProfileTabScreen> createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen>
    with SingleTickerProviderStateMixin {
  ProfileRestTabController _profileRestTabController = ProfileRestTabController();

  @override
  void initState() {
    _profileRestTabController.tabController =
        TabController(length: 4, vsync: this, initialIndex: 0);
    _profileRestTabController.tabController.animateTo(
        _profileRestTabController.selectedIndex.value);
    _profileRestTabController.tabController.addListener(
        _profileRestTabController.onPositionChange);
    super.initState();
  }

  @override
  void dispose() {
    _profileRestTabController.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Color(WHITE),
        appBar: AppBar(
          backgroundColor: Color(WHITE),
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          elevation: 0,
          flexibleSpace: Container(
            height: double.infinity,
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(true),
                  child: Image.asset(
                    ic_right_side_arrow,
                    width: 25,
                    color: Colors.orange,
                    height: 20,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                WidgetText.widgetPoppinsRegularText(
                  _profileRestTabController.appbarName.value,
                  Color(BLACK),
                  16,
                )
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: DefaultTabController(
            length: 4,
            initialIndex: _profileRestTabController.selectedIndex.value,
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
                    controller: _profileRestTabController.tabController,
                    indicatorColor: Color(ORANGE),
                    unselectedLabelColor: Colors.white.withOpacity(0.3),
                    labelPadding: EdgeInsets.all(12),
                    indicatorWeight: 3,
                    tabs: [
                      WidgetText.widgetPoppinsMediumText("Owner Info",
                        _profileRestTabController.selectedIndex.value == 0
                            ? Color(BLACK)
                            : Color(0xff848383), 14,),
                      WidgetText.widgetPoppinsMediumText(
                        "Restaurant Info",
                        _profileRestTabController.selectedIndex.value == 1
                            ? Color(BLACK)
                            : Color(0xff848383), 14,),
                      WidgetText.widgetPoppinsMediumText("Bank Info",
                        _profileRestTabController.selectedIndex.value == 2
                            ? Color(BLACK)
                            : Color(0xff848383), 14,),
                      WidgetText.widgetPoppinsMediumText(category,
                        _profileRestTabController.selectedIndex.value == 3
                            ? Color(BLACK)
                            : Color(0xff848383), 14,),
                    ],
                    onTap: (int index) {
                      _profileRestTabController.selectedIndex.value = index;
                      _profileRestTabController.appbarNameChange(index);
                    },
                  ),
                ),
                Divider(
                    height: 1, thickness: 1, color: Color(DIVIDERCOLOR)),
                Flexible(
                  flex: 20,
                  fit: FlexFit.loose,
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    controller: _profileRestTabController.tabController,
                    children: [
                      OwnerInfo(moveToRestTab: _profileRestTabController
                          .moveToRestTab),
                      RestaurantInfo(moveToBankTab: _profileRestTabController
                          .moveToBankTab,),
                      BankInfo(moveToCategoryTab: _profileRestTabController
                          .moveToCategoryTab),
                      CategoryScreen(),
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

}

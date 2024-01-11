import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_strings_constants.dart';

class ProfileRestTabController extends GetxController{
  late TabController tabController;
  RxInt selectedIndex = 0.obs;
  RxString appbarName = "Owner Information".obs;


  void onPositionChange() {
    if (!tabController.indexIsChanging) {
      selectedIndex.value = (tabController.index);
      debugPrint("currentPosition controller: $selectedIndex");
      appbarNameChange(selectedIndex.value);
      update();
    }
  }


  void moveToOwnerTab() {
    selectedIndex.value = 0;
    debugPrint('selectedIndex: $selectedIndex');
    tabController.animateTo(selectedIndex.value);
    appbarName.value = ownerInfo;
    debugPrint('AppbarName: $appbarName');
    update();
  }

  void moveToCategoryTab() {
      selectedIndex.value = 3;
      debugPrint('selectedIndex: $selectedIndex');
      tabController.animateTo(selectedIndex.value);
      appbarName.value = categoryInfo;
      debugPrint('AppbarName: $appbarName');
      update();
  }

  void moveToBankTab() {
      selectedIndex.value = 2;
      debugPrint('selectedIndex: $selectedIndex');
      tabController.animateTo(selectedIndex.value);
      appbarName.value = bankInfo;
      debugPrint('AppbarName: $appbarName');
      update();
  }

  void moveToRestTab() {
      selectedIndex.value = 1;
      debugPrint('selectedIndex: $selectedIndex');
      tabController.animateTo(selectedIndex.value);
      appbarName.value = restInfo;
      debugPrint('AppbarName: $appbarName');
      update();
  }

  appbarNameChange(int index){
    if(index == 0){
        appbarName.value = ownerInfo;
    }else  if(index == 1){
        appbarName.value = restInfo;
    }else  if(index == 2){
        appbarName.value = bankInfo;
    }else  if(index == 3){
        appbarName.value = categoryInfo;
    }
    debugPrint('AppbarName: $appbarName');
    update();
  }

}
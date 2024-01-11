import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/app_strings_constants.dart';

class MenuRestTabController extends GetxController{
  late TabController tabController;
  RxInt selectedIndex = 0.obs;
  RxString appbarName = genInfoTxt.obs;

  void onPositionChange() {
    if (!tabController.indexIsChanging) {
      selectedIndex.value = (tabController.index);
      debugPrint("currentPosition controller: $selectedIndex");
      appbarNameChange(selectedIndex.value);
      update();
    }
  }

  void moveToImageTab() {
    selectedIndex.value = 1;
    debugPrint('selectedIndex: $selectedIndex');
    tabController.animateTo(selectedIndex.value);
    appbarName.value = imagesTxt;
    debugPrint('AppbarName: $appbarName');
    update();
  }

  void moveToMacroTab() {
    selectedIndex.value = 2;
    debugPrint('selectedIndex: $selectedIndex');
    tabController.animateTo(selectedIndex.value);
    appbarName.value = macroInfoTxt;
    debugPrint('AppbarName: $appbarName');
    update();
  }

  void moveToOtherAddonsTab() {
    selectedIndex.value = 3;
    debugPrint('selectedIndex: $selectedIndex');
    tabController.animateTo(selectedIndex.value);
    appbarName.value = addOnsTxt;
    debugPrint('AppbarName: $appbarName');
    update();
  }

  appbarNameChange(int index){
    if(index == 0){
        appbarName.value = genInfoTxt;
    }else  if(index == 1){
        appbarName.value = imagesTxt;
    }else  if(index == 2){
        appbarName.value = macroInfoTxt;
    }else  if(index == 3){
        appbarName.value = addOnsTxt;
    }
    debugPrint('AppbarName: $appbarName');
    update();
  }

}
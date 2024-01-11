
import 'package:get/get.dart';

class TabBarItemController extends GetxController {
  var isFoodiGoalUpdated = false.obs;

  void changeTabIndex(bool update) {
    isFoodiGoalUpdated.value = update;
  }
}

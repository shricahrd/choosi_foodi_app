import 'package:choosifoodi/screens/splash/controller/splash_controller.dart';
import 'package:choosifoodi/screens/start/controller/start_controller.dart';
import 'package:get/get.dart';

import '../core/utils/networkManager.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(GetXNetworkManager(), permanent: true);
    Get.put(SplashController(), permanent: true);
    Get.put(StartController(), permanent: true);
  }
}

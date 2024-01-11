import 'package:choosifoodi/screens/base_application/base_application.dart';
import 'package:choosifoodi/screens/create_account/view/create_account_screen.dart';
import 'package:choosifoodi/screens/restaurants_panel/restaurant_base_application/restaurant_base_application.dart';
import 'package:choosifoodi/screens/restaurants_panel/signup/view/restaurant_mobile_no_screen.dart';
import 'package:choosifoodi/screens/start/view/start_screen.dart';
import 'package:get/get.dart';
import '../screens/login/view/login_view.dart';
import '../screens/splash/view/splash_screen.dart';
import 'all_routes.dart';

class AppRoutes {
  static List<GetPage> pages() => [
    GetPage(
      page: () =>  SplashScreen(),
      name: AllRoutes.splash,
    ),
    GetPage(
      page: () =>  StartScreen(),
      name: AllRoutes.start,
    ),
    GetPage(
      page: () =>  CreateAccountScreen(),
      name: AllRoutes.signupUser,
    ),
    GetPage(
      page: () =>  RestaurantMobileNoScreen(),
      name: AllRoutes.restMobile,
    ),
    GetPage(
      page: () =>  LoginView(),
      name: AllRoutes.login,
    ),
    GetPage(
      page: () =>  RestaurantBaseApplication(),
      name: AllRoutes.baseRestaurant,
    ),
    GetPage(
      page: () =>  BaseApplication(),
      name: AllRoutes.baseUser,
        binding: BindingsBuilder(() {
          // Get.put(HomeViewController());
        })
    ),
  ];
}

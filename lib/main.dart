import 'dart:io';
import 'package:choosifoodi/core/utils/app_theme.dart';
import 'package:choosifoodi/routes/app_routes.dart';
import 'package:choosifoodi/routes/initialbinding.dart';
import 'package:choosifoodi/screens/notification/localNotification/local_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'core/utils/app_preferences.dart';
import 'core/utils/app_strings_constants.dart';
import 'core/widgets/widget_dismiss_keyboard.dart';

dynamic groupId;
//for http connection if url is not secure then this function is works
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage message) async {
  debugPrint(message.notification?.title);
  debugPrint(message.data.toString());
  debugPrint(message.notification?.title);
  debugPrint(message.notification?.body);
  debugPrint("Foreground Message ID: ${message.data["_id"]}");
  debugPrint("Foreground Message Body: ${message.data}");
  groupId = message.data['groupId'];
  debugPrint('groupId ===> $groupId');
  if (message.data['notificationType'] == groupOrderPayment) {
    AppPreferences.setGroupId("");
  } else {
    groupId = message.data['groupId'];
    debugPrint('groupId ===> $groupId');
    if (groupId != null) {
      AppPreferences.setGroupId(groupId);
    }
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  Stripe.merchantIdentifier = merchantIdentifier;
  Stripe.urlScheme = flutterStripe;
  await Stripe.instance.applySettings();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  HttpOverrides.global = new MyHttpOverrides();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LocalNotificationService.initialize(context);
    return DismissKeyboard(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        theme: AppTheme.mainTheme,
        getPages: AppRoutes.pages(),
        initialBinding: InitialBinding(),
      ),
    );
  }
}

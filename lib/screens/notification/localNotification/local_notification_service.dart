import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/utils/app_preferences.dart';
import '../../../routes/all_routes.dart';
import '../../group_orders/view/join_group_order_screen.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static var groupId;

  static get onDidReceiveLocalNotification {

  }

 /* void onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();

            },
          )
        ],
      ),
    );
  }*/


  static void initialize(BuildContext context) {
    // initializationSettings for Android
  /*  const InitializationSettings initializationSettings =
    InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );*/

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings("@mipmap/ic_launcher");
    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);

    void onDidReceiveNotificationResponse(notificationResponse) async {
      final String? payload = notificationResponse.payload;
      if (notificationResponse.payload != null) {
        // debugPrint('notification payload: $payload');
        print("onSelectNotification: $payload");
        groupId = await AppPreferences.getGroupId();
        print('groupId: $groupId');
        checkIsLogin();
      }
    }

      void notificationTapBackground(notificationResponse) async {
        final String? payload = notificationResponse.payload;
        if (notificationResponse.payload != null) {
          // debugPrint('notification payload: $payload');
          print("onSelectNotification: $payload");
          groupId = await AppPreferences.getGroupId();
          print('groupId: $groupId');
          checkIsLogin();
        }
    }

    /// TODO initialize method

    _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      /* onDidReceiveBackgroundNotificationResponse: notificationTapBackground,*/);
       /* onSelectNotification: (String? route) async {

          print("onSelectNotification");
          groupId = await AppPreferences.getGroupId();
          print('groupId: $groupId');
          checkIsLogin();
        });*/

  }

  static void createAndDisplayNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

     /*  List<String> lines = <String>[
        message.notification?.body ?? "",
      ];

       InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
          lines);*/

       NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          // "com.b2c.choosifoodi"
          "choosyFoodieId",
          "choosyFoodieChannel",
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        )
      );

      /// pop up show
      await _notificationsPlugin.show(
        id,
        message.notification?.title.toString().replaceAll(
            RegExp(r'<[^>]*>|&[^;]+;'),
            ' '),
        message.notification?.body.toString().replaceAll(
            RegExp(r'<[^>]*>|&[^;]+;'),
            ' '),
        notificationDetails,
        payload: message.data["route"],

        //////// In case of DemoScreen //////////////////////////////////////
        // this "id" key and "id" key of passing firebase's data must same
        // payload: message.data["_id"],
        ////////////////////////////////////////////////////////////////////
      );
    } on Exception catch (e) {
      print(e);
    }
  }

  static void checkIsLogin() {
    AppPreferences.getIsLogin().then((value) {
      if (value == true){
        if (IsCustomerApp) {
          AppPreferences.getUserData().then((userData) {
            if (userData != null){
              print('User Not Null');
              if(groupId != null && groupId != "") {
                Get.to(() => JoinGroupOrderScreen(groupId));
              }
            }
          });
        }
      }
      else {
        Get.toNamed(AllRoutes.start);
      }
    });
  }
}
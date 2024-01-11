import UIKit
import Flutter
import Firebase
import FirebaseCore
import FirebaseMessaging
import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
   if #available(iOS 13.0, *) {

    } else {
        FirebaseApp.configure()
    }

     if #available(iOS 10.0, *) {
           UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
     }

     FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
                  GeneratedPluginRegistrant.register(with: registry)
     }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    // NOTE: For logging
    // let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
    // print("==== didRegisterForRemoteNotificationsWithDeviceToken ====")
    // print(deviceTokenString)
    Messaging.messaging().apnsToken = deviceToken
  }

   /*  override func application(_application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){

       Messaging.messaging().apnsToken = deviceToken
        print("DeviceToken: \(deviceToken)");
       super.application(application,
       didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
       } */
}

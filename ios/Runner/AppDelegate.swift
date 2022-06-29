import UIKit
import Flutter
import Firebase
import GoogleMaps
import workmanager
import flutter_local_notifications
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                             willPresent notification: UNNotification,
                                             withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
             completionHandler(.alert) // shows banner even if app is in foreground
         }
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    // Other intialization code…
  ) -> Bool {
    UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*15))
  GMSServices.provideAPIKey("AIzaSyDaf3ZfW1IA-QS-469Ud2ZHnxONavHmeL0")
    FirebaseApp.configure()
      GeneratedPluginRegistrant.register(with: self)
             
      WorkmanagerPlugin.register(with: self.registrar(forPlugin: "be.tramckrijte.workmanager.WorkmanagerPlugin")!)
             
             UNUserNotificationCenter.current().delegate = self

             UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*15))
    

             WorkmanagerPlugin.setPluginRegistrantCallback { registry in
                 // registry in this case is the FlutterEngine that is created in Workmanager's performFetchWithCompletionHandler
                 // This will make other plugins available during a background fetch
                 //GeneratedPluginRegistrant.register(with: registry)
                 
                 FlutterLocalNotificationsPlugin.register(with: registry.registrar(forPlugin: "com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin")!)
                 
             }

      if #available(iOS 10.0, *) {
        // For iOS 10 display notification (sent via APNS)
        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )
      } else {
        let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
      }

      if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
      }

      application.registerForRemoteNotifications()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // https://firebase.google.com/docs/auth/ios/phone-auth#appendix:-using-phone-sign-in-without-swizzling
// https://firebase.google.com/docs/cloud-messaging/ios/client#token-swizzle-disabled
override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    // Pass device token to auth
    Auth.auth().setAPNSToken(deviceToken, type: .unknown)

    // Pass device token to messaging
    Messaging.messaging().apnsToken = deviceToken

    return super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
}

// https://firebase.google.com/docs/auth/ios/phone-auth#appendix:-using-phone-sign-in-without-swizzling
// https://firebase.google.com/docs/cloud-messaging/ios/receive#handle-swizzle
override func application(_ application: UIApplication,
                          didReceiveRemoteNotification notification: [AnyHashable : Any],
                          fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    // Handle the message for firebase auth phone verification
    if Auth.auth().canHandleNotification(notification) {
        completionHandler(.noData)
        return
    }

    // Handle it for firebase messaging analytics
    if ((notification["gcm.message_id"]) != nil) {
        Messaging.messaging().appDidReceiveMessage(notification)
    }

    return super.application(application, didReceiveRemoteNotification: notification, fetchCompletionHandler: completionHandler)
}

// https://firebase.google.com/docs/auth/ios/phone-auth#appendix:-using-phone-sign-in-without-swizzling
override func application(_ application: UIApplication, open url: URL,
                          options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
    // Handle auth reCAPTCHA when silent push notifications aren't available
    if Auth.auth().canHandle(url) {
        return true
    }

    return super.application(application, open: url, options: options)
   }

}
//

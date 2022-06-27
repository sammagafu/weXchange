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
}
//

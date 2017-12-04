//
//  AppDelegate.swift
//  EasyShopping
//
//  Created by admin on 11/11/2017.
//  Copyright © 2017 MuhammadAamir. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
import GoogleMaps
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,  UNUserNotificationCenterDelegate {

    var window: UIWindow?
    let APIKey = "AIzaSyBi2sOJKtAP5QfZVSEfqyM3pJ54z-aX0ik"
    var UserProfleImage: String?
    let token = Messaging.messaging().fcmToken
    var deviceID = String()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        GMSServices.provideAPIKey(APIKey)
        IQKeyboardManager.sharedManager().enable = true
        
        // [START set_messaging_delegate]
        Messaging.messaging().delegate = self
        // [END set_messaging_delegate]
        // Register for remote notifications. This shows a permission dialog on first run, to
        // show the dialog at a more appropriate time move this registration accordingly.
        // [START register_for_notifications]
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self

            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
//    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
//        Messaging.messaging().apnsToken = deviceToken as Data
//    }


}

extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
//        guard let newToken = InstanceID.instanceID().token() else {return}
//        self.deviceID = newToken
        print("Firebase registration token: \(fcmToken)")
        
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("notification arrived!")
//        if let notificationObj = userInfo as? [String:Any] {
//
//            if let _ = notificationObj["isMessage"] as? String, let senderID = notificationObj["senderID"] as? String{
//                let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let rootViewController:UINavigationController = storyboard.instantiateViewController(withIdentifier: "VC") as! UINavigationController
//                let main  = storyboard.instantiateViewController(withIdentifier: "Main") as! UITabBarController
//                rootViewController.viewControllers.append(main)
//                switch application.applicationState{
//                case .inactive, .active:
//                    Providor.shared.userRef.child(senderID)
//                        .observeSingleEvent(of: .value, with: { (user) in
//                            let sender = Mapper<DUser>().map(JSONObject: user.value)
//                            sender?.id = user.key
//                            main.selectedIndex = 4
//                            Indicator.hide()
//                        })
//                    self.window?.rootViewController = rootViewController
//                    Indicator.show()
//                    break
//
//                default:
//                    break
//                }
//            }
//        }
        let viewController = self.window!.rootViewController!.storyboard!.instantiateViewController(withIdentifier: "ItemDetailVC")
        self.window?.rootViewController = viewController
        completionHandler(UIBackgroundFetchResult.newData)
    }

    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
        
//        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let ItemDetailVC = storyboard.instantiateViewController(withIdentifier: "ItemDetailVC")
//        window?.makeKeyAndVisible()
//        window?.rootViewController?.present(ItemDetailVC, animated: true, completion: nil)

    }
    // [END ios_10_data_message]
}


//extension AppDelegate : UNUserNotificationCenterDelegate {

//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        let userInfo = notification.request.content.userInfo
//        print(userInfo)
//
//        completionHandler([.alert,.sound,.badge])
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        let userInfo = response.notification.request.content.userInfo
//        print(userInfo)
//
//        completionHandler()
//    }
//}


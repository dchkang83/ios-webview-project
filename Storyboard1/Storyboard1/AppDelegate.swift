//
//  AppDelegate.swift
//  Storyboard1
//
//  Created by 강덕준 on 1/10/23.
//

import UIKit
//import Firebase
//import FirebaseMessaging
import AVFoundation
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
//    var mainVC: MainViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        print("$$$$$$$$$$$$$$$ AppDelegate - scene 000")
        
        
        FirebaseApp.configure()
        
        
        //        self.navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor.red]
        //        self.navigationController?.navigationBar.scrollEdgeAppearance?.backgroundColor = .darkGray
        //        self.navigationController?.navigationBar.scrollEdgeAppearance?.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        /*
        if #available(iOS 15.0, *) {
//            print("$$$$$$$$$$$$$$$ AppDelegate - scene 000 - 111")
            
            // disable UINavigation bar transparent
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithDefaultBackground()
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            UITabBar.appearance().standardAppearance = tabBarAppearance
        }
        */
        
        
        // TODO. 스플래시 딜레이 3초
//        Thread.sleep(forTimeInterval: 3.0)
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}





// MARK: UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Utils.Log("didRegisterForRemoteNotificationsWithDeviceToken deviceToken : \(deviceToken)")
        // TODO. ttttttt
//        Messaging.messaging().apnsToken = deviceToken
    }
    /*
           Function that the app is called while running. App foreground status
     */
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        let userInfo = notification.request.content.userInfo;
        Utils.Log("userNotificationCenter willPresent : \(userInfo)")
        UIApplication.shared.applicationIconBadgeNumber = 0;

        // TODO. ttttttt
//        mainVC?.loadJavascriptForPush(userInfo as NSDictionary)
//        completionHandler([.alert, .badge, .sound]);
    }
    /*
      Function that the app is called while background or not running
     */
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        UIApplication.shared.applicationIconBadgeNumber = 0;
        let userInfo = response.notification.request.content.userInfo;
        Utils.Log("userNotificationCenter didReceive : \(userInfo)")
        
        // TODO. ttttttt
//        self.url = userInfo["url"] as? String
//        self.externalUrlYn = userInfo["externalUrlYn"] as? String
//        self.window?.rootViewController?.dismiss(animated: false, completion: nil)
        
//        if let vc = mainVC, let urlYn = self.externalUrlYn {
//            if urlYn == "Y" {
//                vc.openWindow2(self.url ?? "")
//            } else {
//                vc.openWindow1(self.url ?? "")
//            }
//        }
        completionHandler()
    }
}

// MARK: MessagingDelegate
//extension AppDelegate: MessagingDelegate {
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        Utils.Log("Firebase registration token: \(String(describing: fcmToken))")
//
//        if let token = fcmToken {
//            Utils.Log("FCM Token : \(token)")
//            UserDefaults.standard.set(token, forKey: "fcmToken")
//            UserDefaults.standard.synchronize()
//        }
//        // TODO: If necessary send token to application server.
//        // Note: This callback is fired at each app startup and whenever a new token is generated.
//    }
//    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingDelegate) {
//        Utils.Log("Received data message: \(remoteMessage.description)")
//    }
//}




//
//  AppDelegate.swift
//  final
//
//  Created by 朱泓撰 on 2020/5/14.
//  Copyright © 2020 zhz. All rights reserved.
//

import UIKit
import NotificationCenter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static let CATEGORY_IDENTIFIER = "seanzhz.finalproject.notification"
    var notificationsEnabled = false
    var databaseController: DatabaseProtocol?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        databaseController = CoreDataController()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) { (granted, error) in
            self.notificationsEnabled = granted
            print("User allows notifcations: \(granted)")

            if self.notificationsEnabled {
                let acceptAction = UNNotificationAction(identifier: "accept", title: "Accept", options: .foreground)
                let declineAction = UNNotificationAction(identifier: "decline", title: "Decline", options: .destructive)
                let commentAction = UNTextInputNotificationAction(identifier: "comment", title: "Comment", options: .authenticationRequired, textInputButtonTitle: "Send", textInputPlaceholder: "Share your thoughts..")
                
                // Set up the category
                let appCategory = UNNotificationCategory(identifier: AppDelegate.CATEGORY_IDENTIFIER, actions: [acceptAction, declineAction, commentAction], intentIdentifiers: [], options: UNNotificationCategoryOptions(rawValue: 0))
                
                // Register the category just created with the notification centre
                UNUserNotificationCenter.current().setNotificationCategories([appCategory])
            }
        }
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


//
//  AppDelegate.swift
//  RickAndMorty
//
//  Created by Josue Perez  on 4/10/23.
//

import UIKit

/* UIApplicationDelegate: a protocol to manage shared behaviors of your app.
    Uses:
         - Set up the first view controller of your app, called the root view controller
         - Configure app settings and startup components, such as logging and cloud services
         - Register push notification handlers, and respond to push notifications sent to the app
         - Respond to app lifecycle events, such as entering the background, resuming the app, or exiting the app (termination)
*/

// UIResponder: An abstract interface for responding to and handling events.
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    // first function that the OS calls to start up your app
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        /* This boolean value indicates that the app can be started, based on the options passed to the function. It’s common to return true, but you can also return false when the app cannot start based on some URL resource or user activity.
         */
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


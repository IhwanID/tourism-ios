//
//  TourismAppDelegate.swift
//  tourism
//
//  Created by Ihwan ID on 13/02/21.
//

import Foundation
import UIKit
import RealmSwift

@main
class TourismAppDelegate: NSObject, UIApplicationDelegate {
    var realm: Realm!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        realm = try! Realm()
        return true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {

        let scene = UISceneConfiguration(name: "Fine Scene Delegate", sessionRole: connectingSceneSession.role)
        scene.delegateClass = TourismSceneDelegate.self
        return scene
    }

    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken
                        deviceToken: Data) {
        let token = deviceToken.map{ data in String(format: "%02.2hhx", data) }.joined()
        print("deviceToken \(token)")

    }

    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError
                        error: Error) {
        print("deviceToken failure")
        // Try again later.
    }
}

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

}

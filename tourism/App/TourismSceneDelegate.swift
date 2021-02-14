//
//  TourismSceneDelegate.swift
//  tourism
//
//  Created by Ihwan ID on 13/02/21.
//

import UIKit
import Core
import TourismPlace
import SwiftUI
import RealmSwift

class TourismSceneDelegate: NSObject, UIWindowSceneDelegate {

    var window: UIWindow?

        func scene(
            _ scene: UIScene,
            willConnectTo session: UISceneSession,
            options connectionOptions: UIScene.ConnectionOptions
        ) {


            let favoriteUseCase: Interactor<
                Any,
                [PlaceDomainModel],
                GetFavoritePlaceRepository<
                    GetPlacesLocaleDataSource,
                    PlaceTransformer>
            >  = Injection.init().provideFavorites()

            let homeUseCase: Interactor<
                Any,
                [PlaceDomainModel],
                GetPlacesRepository<
                    GetPlacesLocaleDataSource,
                    GetPlacesRemoteDataSource,
                    PlaceTransformer>
            > = Injection.init().providePlace()

            let homePresenter = GetListPresenter(useCase: homeUseCase)

            let favoritePresenter = GetListPresenter(useCase: favoriteUseCase)

            let contentView = ContentView()
                .environmentObject(homePresenter)
                .environmentObject(favoritePresenter)

            if let windowScene = scene as? UIWindowScene {
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = UIHostingController(rootView: contentView)
                self.window = window
                window.makeKeyAndVisible()
            }
        }
}

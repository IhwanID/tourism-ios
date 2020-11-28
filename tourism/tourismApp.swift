//
//  tourismApp.swift
//  tourism
//
//  Created by Ihwan ID on 30/10/20.
//

import SwiftUI

@main
struct tourismApp: App {

    var body: some Scene {
        let homeUseCase = Injection.init().provideHome()
        let homePresenter = HomePresenter(homeUseCase: homeUseCase)

        let favoriteUseCase = Injection.init().provideFavorite()
        let favoritePresenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)
        
        WindowGroup {
            ContentView().environmentObject(homePresenter).environmentObject(favoritePresenter)
        }
    }
}

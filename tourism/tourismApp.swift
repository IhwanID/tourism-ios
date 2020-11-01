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
        
        WindowGroup {
            ContentView().environmentObject(homePresenter)
        }
    }
}

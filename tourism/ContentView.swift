//
//  ContentView.swift
//  tourism
//
//  Created by Ihwan ID on 30/10/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var homePresenter: HomePresenter
    @EnvironmentObject var favoritePresenter: FavoritePresenter

    var body: some View {
        TabView {
            NavigationView {
                HomeView(presenter: homePresenter)
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            NavigationView {
                FavoriteView(presenter: favoritePresenter)
            }
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Favorite")
            }
            NavigationView {
                ProfileView()
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }

        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

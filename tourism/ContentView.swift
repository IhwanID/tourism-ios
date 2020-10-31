//
//  ContentView.swift
//  tourism
//
//  Created by Ihwan ID on 30/10/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
              .tabItem {
                 Image(systemName: "house.fill")
                 Text("Homeb")
               }
            Text("Favorite Page")
              .tabItem {
                 Image(systemName: "heart.fill")
                 Text("Favorite")
              }

            Text("Profile Page")
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

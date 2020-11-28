//
//  HomeView.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter
    @Namespace var namespace
    var body: some View {
        ZStack {
            if presenter.loadingState {
                VStack {
                    Text("Loading...")
                }
            } else {
                ScrollView(.vertical, showsIndicators: false){
                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: 159), spacing: 16)],
                        spacing: 16) {
                        ForEach(
                            self.presenter.places,
                            id: \.id
                        ){ place in
                            VStack {
                                self.presenter.linkBuilder(for: place) {
                                    PlaceRow(place: place)
                                }
                            }
                        }}
                }.animation(.spring(response: 0.4, dampingFraction: 0.8))
                .padding(.all, 20)

            }
        }.onAppear {
            if self.presenter.places.count == 0 {
                self.presenter.getPlaces()
            }
        }.navigationTitle("Home")
        
    }
}

//
//  HomeView.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter

    var body: some View {
        ZStack {
            if presenter.loadingState {
                VStack {
                    Text("Loading...")

                }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(
                        self.presenter.places,
                        id: \.id
                    ) { place in
                        VStack {
                            self.presenter.linkBuilder(for: place) {
                                PlaceRow(place: place)
                                    .padding(.all, 8)
                                    .frame(maxWidth: 600, maxHeight: 300)
                            }
                        }.padding(8)
                    }
                }
            }
        }.onAppear {
            if self.presenter.places.count == 0 {
                self.presenter.getPlaces()
            }
        }.navigationTitle("Place")
        
    }
}

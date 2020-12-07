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
    @State var searchText = ""

    var body: some View {
        ZStack {
            if presenter.loadingState {
                VStack {
                    ProgressView()
                }
            } else {
                ScrollView(.vertical, showsIndicators: false){
                    TextField("Search", text: $searchText)
                        .font(.title3)
                        .padding(8)
                        .background(Color(#colorLiteral(red: 0.9645187259, green: 0.9649179578, blue: 0.9559617639, alpha: 1)))
                        .mask(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .padding(.vertical, 8)
                    LazyVGrid(
                        columns: [GridItem(.adaptive(minimum: 159), spacing: 16)],
                        spacing: 16) {
                        ForEach(
                            self.presenter.places,
                            id: \.id
                        ){ place in
                            if place.name.localizedCaseInsensitiveContains(searchText) || searchText == ""{
                                VStack {
                                    self.presenter.linkBuilder(for: place) {
                                        PlaceRow(place: place)
                                    }
                                }
                            }

                        }}
                }.animation(.spring(response: 0.4, dampingFraction: 0.8))
                .padding(.horizontal, 20)

            }
        }.onAppear {
            if self.presenter.places.count == 0 {
                self.presenter.getPlaces()
            }
        }.navigationTitle("Home")
        
    }
}

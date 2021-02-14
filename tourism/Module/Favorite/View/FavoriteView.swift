//
//  FavoriteView.swift
//  tourism
//
//  Created by Ihwan ID on 24/11/20.
//

import Foundation
import SwiftUI
import TourismPlace
import Core

struct FavoriteView: View {

    @ObservedObject var presenter: GetListPresenter<Any, PlaceDomainModel, Interactor<Any, [PlaceDomainModel], GetFavoritePlaceRepository<GetPlacesLocaleDataSource,  PlaceTransformer>>>

    var body: some View {
        ZStack {

            if presenter.isLoading {
                VStack{
                    ProgressView()
                }
            } else if presenter.isError {
                VStack{
                    Text("Error!")
                }
            } else if presenter.list.count == 0 {
                VStack{
                    Text("No Favorite Place")
                }
            } else {
                ScrollView(
                    .vertical,
                    showsIndicators: false
                ) {
                    VStack(spacing: 30){
                        ForEach(
                            self.presenter.list,
                            id: \.id
                        ) { place in
//                            self.presenter.linkBuilder(for: place) {
//                                FavoriteRow(place: place).frame(maxWidth: 600, maxHeight: 300)
//                            }
                            FavoriteRow(place: place).frame(maxWidth: 600, maxHeight: 300)
                        }
                    }
                    .animation(.spring(response: 0.4, dampingFraction: 0.8))
                    .padding(20)

                }
            }
        }.onAppear {
            self.presenter.getList(request: nil)
        }.navigationBarTitle(
            Text("Favorite"),
            displayMode: .automatic
        )
    }

}

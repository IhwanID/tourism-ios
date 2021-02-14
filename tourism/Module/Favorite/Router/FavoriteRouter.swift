//
//  FavoriteRouter.swift
//  tourism
//
//  Created by Ihwan ID on 24/11/20.
//

import Foundation
import SwiftUI
import TourismPlace
import Core

class FavoriteRouter {

    func makeDetailView(for place: PlaceDomainModel) -> some View {
        let useCase: Interactor<Int, PlaceDomainModel, UpdateFavoritePlacesRepository<GetPlacesLocaleDataSource,  PlaceTransformer>> = Injection.init().provideDetails()
        let placeUseCase: Interactor<Int, PlaceDomainModel, GetPlaceRepository<GetPlacesLocaleDataSource,  PlaceTransformer>> = Injection.init().provideSinglePlace()
        let presenter = PlacePresenter(placeUseCase: placeUseCase, favoriteUseCase: useCase)
        return DetailView(presenter: presenter, place: place)
          }

}

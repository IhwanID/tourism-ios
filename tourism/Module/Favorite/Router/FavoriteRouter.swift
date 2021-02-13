//
//  FavoriteRouter.swift
//  tourism
//
//  Created by Ihwan ID on 24/11/20.
//

import Foundation
import SwiftUI
import TourismPlace

class FavoriteRouter {
    
    func makeDetailView(for place: PlaceDomainModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(place: place)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailView(presenter: presenter)
    }

}

//
//  FavoriteRouter.swift
//  tourism
//
//  Created by Ihwan ID on 24/11/20.
//

import Foundation
import SwiftUI

class FavoriteRouter {
    
    func makeDetailView(for place: Place) -> some View {
        let detailUseCase = Injection.init().provideDetail(place: place)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailView(presenter: presenter)
    }

}

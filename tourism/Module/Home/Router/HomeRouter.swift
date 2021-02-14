//
//  HomeRouter.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import Foundation
import SwiftUI
import TourismPlace
import Core

class HomeRouter {


    func makeDetailView(for place: PlaceDomainModel) -> some View {

        //define usecase for detail
       // let useCase: <#type#> = Injection.init().provideDetails()
        let detailUseCase = Injection.init().provideDetail(place: place)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailView(presenter: presenter, place: place)
    }

}

//
//  DetailInteractor.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import Foundation
import Combine
import TourismPlace

protocol DetailUseCase {
    
    func getPlace() -> PlaceDomainModel
    func updateFavoritePlace() -> AnyPublisher<PlaceDomainModel, Error>
}

class DetailInteractor: DetailUseCase {
    
    private let repository: PlaceRepositoryProtocol
    private let place: PlaceDomainModel
    
    required init(
        repository: PlaceRepositoryProtocol,
        place: PlaceDomainModel
    ) {
        self.repository = repository
        self.place = place
    }
    
    func getPlace() -> PlaceDomainModel {
        return place
    }
    
    func updateFavoritePlace() -> AnyPublisher<PlaceDomainModel, Error> {
        return repository.updateFavoritPlaces(by: place.id)
    }
}

//
//  FavoriteInteractor.swift
//  tourism
//
//  Created by Ihwan ID on 24/11/20.
//

import Foundation
import Combine
import TourismPlace

protocol FavoriteUseCase {
    
    func getFavoritePlaces() -> AnyPublisher<[PlaceDomainModel], Error>
    
}

class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: PlaceRepositoryProtocol
    
    required init(repository: PlaceRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoritePlaces() -> AnyPublisher<[PlaceDomainModel], Error> {
        return repository.getFavoritePlaces()
    }
    
}

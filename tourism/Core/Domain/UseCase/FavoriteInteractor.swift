//
//  FavoriteInteractor.swift
//  tourism
//
//  Created by Ihwan ID on 24/11/20.
//

import Foundation
import Combine

protocol FavoriteUseCase {
    
    func getFavoritePlaces() -> AnyPublisher<[Place], Error>
    
}

class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: PlaceRepositoryProtocol
    
    required init(repository: PlaceRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoritePlaces() -> AnyPublisher<[Place], Error> {
        return repository.getFavoritePlaces()
    }
    
}

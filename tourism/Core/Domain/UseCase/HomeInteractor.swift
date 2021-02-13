//
//  HomeInteractor.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import Foundation
import Combine
import TourismPlace

protocol HomeUseCase {

    func getPlaces() -> AnyPublisher<[PlaceDomainModel], Error>
}

class HomeInteractor: HomeUseCase {

    private let repository: PlaceRepositoryProtocol

    required init(repository: PlaceRepositoryProtocol) {
        self.repository = repository
    }

    func getPlaces() -> AnyPublisher<[PlaceDomainModel], Error> {
        return repository.getPlaces()
    }

}

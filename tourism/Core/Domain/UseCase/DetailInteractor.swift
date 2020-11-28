//
//  DetailInteractor.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import Foundation
import Combine

protocol DetailUseCase {

    func getPlace() -> Place
    func updateFavoritePlace() -> AnyPublisher<Place, Error>
}

class DetailInteractor: DetailUseCase {

    private let repository: PlaceRepositoryProtocol
    private let place: Place

    required init(
        repository: PlaceRepositoryProtocol,
        place: Place
    ) {
        self.repository = repository
        self.place = place
    }

    func getPlace() -> Place {
        return place
    }

    func updateFavoritePlace() -> AnyPublisher<Place, Error> {
        return repository.updateFavoritPlaces(by: place.id)
    }
}

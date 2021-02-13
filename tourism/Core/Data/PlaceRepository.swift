//
//  PlaceRepository.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import Foundation
import Combine
import TourismPlace

protocol PlaceRepositoryProtocol {

    func getPlaces() -> AnyPublisher<[PlaceDomainModel], Error>
    func getFavoritePlaces() -> AnyPublisher<[PlaceDomainModel], Error>
    func updateFavoritPlaces(by id: Int) -> AnyPublisher<PlaceDomainModel, Error>

}

final class PlaceRepository: NSObject {

    typealias PlaceInstance = (LocalDataSource, RemoteDataSource) -> PlaceRepository

    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocalDataSource

    private init(locale: LocalDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }

    static let sharedInstance: PlaceInstance = { localeRepo, remoteRepo in
        return PlaceRepository(locale: localeRepo, remote: remoteRepo)
    }

}

extension PlaceRepository: PlaceRepositoryProtocol {


    func getPlaces() -> AnyPublisher<[PlaceDomainModel], Error> {

        return self.locale.getPlaces()
            .flatMap { result -> AnyPublisher<[PlaceDomainModel], Error> in
                if result.isEmpty {
                    return self.remote.getPlaces()
                        .map { PlaceMapper.mapPlaceResponsesToEntities(input: $0) }
                        .flatMap { self.locale.addPlaces(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self.locale.getPlaces()
                            .map { PlaceMapper.mapPlaceEntitiesToDomains(input: $0) }
                        }
                        .eraseToAnyPublisher()
                } else {
                    return self.locale.getPlaces()
                        .map { PlaceMapper.mapPlaceEntitiesToDomains(input: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()

    }

    func getFavoritePlaces() -> AnyPublisher<[PlaceDomainModel], Error> {
        return self.locale.getFavoritePlaces()
            .map { PlaceMapper.mapPlaceEntitiesToDomains(input: $0) }
            .eraseToAnyPublisher()
    }

    func updateFavoritPlaces(
        by id: Int
    ) -> AnyPublisher<PlaceDomainModel, Error> {
        return self.locale.updateFavoritePlace(by: id)
            .map { PlaceMapper.mapDetailPlaceEntityToDomain(input: $0) }
            .eraseToAnyPublisher()
    }
}

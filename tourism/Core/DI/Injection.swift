//
//  Injection.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import Foundation
import RealmSwift
import Core
import TourismPlace
import UIKit

final class Injection: NSObject {

    private func provideRepository() -> PlaceRepositoryProtocol {
        let realm = try? Realm()

        let locale: LocalDataSource = LocalDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance

        return PlaceRepository.sharedInstance(locale, remote)
    }

    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }

    func provideDetail(place: PlaceDomainModel) -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository, place: place)
    }

    func provideFavorite() -> FavoriteUseCase {
        let repository = provideRepository()
        return FavoriteInteractor(repository: repository)
    }

    func providePlace<U: UseCase>() -> U where U.Request == Any, U.Response == [PlaceDomainModel] {

        let appDelegate = UIApplication.shared.delegate as! TourismAppDelegate

        let locale = GetPlacesLocaleDataSource(realm: appDelegate.realm)


        let remote = GetPlacesRemoteDataSource(endpoint: "https://tourism-api.dicoding.dev/list")

        let mapper = PlaceTransformer()

        let repository = GetPlacesRepository(
            localeDataSource: locale,
            remoteDataSource: remote,
            mapper: mapper)
        return Interactor(repository: repository) as! U
    }

}

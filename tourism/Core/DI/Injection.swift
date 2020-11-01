//
//  Injection.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import Foundation
import RealmSwift

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
  
  func provideDetail(place: Place) -> DetailUseCase {
    let repository = provideRepository()
    return DetailInteractor(repository: repository, place: place)
  }

}

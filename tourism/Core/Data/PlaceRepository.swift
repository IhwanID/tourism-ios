//
//  PlaceRepository.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import Foundation

protocol PlaceRepositoryProtocol {

  func getPlaces(result: @escaping (Result<[Place], Error>) -> Void)

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

  func getPlaces(
    result: @escaping (Result<[Place], Error>) -> Void
  ) {
    locale.getPlaces { localeResponses in
        
    }
  }
}

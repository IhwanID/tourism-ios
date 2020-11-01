//
//  HomeInteractor.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import Foundation

protocol HomeUseCase {

  func getPlaces(completion: @escaping (Result<[Place], Error>) -> Void)

}

class HomeInteractor: HomeUseCase {

  private let repository: PlaceRepositoryProtocol

  required init(repository: PlaceRepositoryProtocol) {
    self.repository = repository
  }

  func getPlaces(
    completion: @escaping (Result<[Place], Error>) -> Void
  ) {
    repository.getPlaces { result in
      completion(result)
    }
  }

}

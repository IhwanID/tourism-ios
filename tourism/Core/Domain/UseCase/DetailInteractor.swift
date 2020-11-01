//
//  DetailInteractor.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import Foundation

protocol DetailUseCase {

  func getPlace() -> Place

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

}

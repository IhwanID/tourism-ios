//
//  DetailPresenter.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import Foundation
import SwiftUI

class DetailPresenter: ObservableObject {

  private let detailUseCase: DetailUseCase

  @Published var place: Place
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false

  init(detailUseCase: DetailUseCase) {
    self.detailUseCase = detailUseCase
    place = detailUseCase.getPlace()
  }

}

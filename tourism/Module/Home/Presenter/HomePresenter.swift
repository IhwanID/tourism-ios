//
//  HomePresenter.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import Foundation
import SwiftUI

class HomePresenter: ObservableObject {

  private let router = HomeRouter()
  private let homeUseCase: HomeUseCase

  @Published var places: [Place] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false

  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
  }

  func getCategories() {
    loadingState = true
    homeUseCase.getPlaces { result in
      switch result {
      case .success(let places):
        DispatchQueue.main.async {
          self.loadingState = false
          self.places = places
        }
      case .failure(let error):
        DispatchQueue.main.async {
          self.loadingState = false
          self.errorMessage = error.localizedDescription
        }
      }
    }
  }

  func linkBuilder<Content: View>(
    for category: Place,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
    destination: router.makeDetailView(for: category)) { content() }
  }

}

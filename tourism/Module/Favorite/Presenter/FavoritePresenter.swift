//
//  FavoritePresenter.swift
//  tourism
//
//  Created by Ihwan ID on 24/11/20.
//

import SwiftUI
import Combine

class FavoritePresenter: ObservableObject {

  private var cancellables: Set<AnyCancellable> = []
  private let router = FavoriteRouter()
  private let favoriteUseCase: FavoriteUseCase

  @Published var places: [Place] = []
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  @Published var isError: Bool = false

  init(favoriteUseCase: FavoriteUseCase) {
    self.favoriteUseCase = favoriteUseCase
  }

  func getFavoriteMeals() {
    isLoading = true
    favoriteUseCase.getFavoritePlaces()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
          switch completion {
          case .failure(let error):
            self.errorMessage = error.localizedDescription
            self.isError = true
          case .finished:
            self.isLoading = false
          }
        }, receiveValue: { places in
          self.places = places
        })
        .store(in: &cancellables)
  }

  func linkBuilder<Content: View>(
    for places: Place,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
    destination: router.makeDetailView(for: places)) { content() }
  }

}

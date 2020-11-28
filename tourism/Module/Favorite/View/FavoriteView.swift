//
//  FavoriteView.swift
//  tourism
//
//  Created by Ihwan ID on 24/11/20.
//

import Foundation
import SwiftUI

struct FavoriteView: View {

  @ObservedObject var presenter: FavoritePresenter

  var body: some View {
    ZStack {

      if presenter.isLoading {
        loadingIndicator
      } else if presenter.isError {
        errorIndicator
      } else if presenter.places.count == 0 {
        emptyFavorites
      } else {
        content
      }
    }.onAppear {
      self.presenter.getFavoriteMeals()
    }.navigationBarTitle(
      Text("Favorite Meals"),
      displayMode: .automatic
    )
  }

}

extension FavoriteView {
  var loadingIndicator: some View {
    VStack {
      Text("Loading...")

    }
  }

  var errorIndicator: some View {
    EmptyView()
  }

  var emptyFavorites: some View {
    EmptyView()
  }

  var content: some View {
    ScrollView(
      .vertical,
      showsIndicators: false
    ) {
      ForEach(
        self.presenter.places,
        id: \.id
      ) { place in
        ZStack {
          self.presenter.linkBuilder(for: place) {
            FavoriteRow(place: place)
          }.buttonStyle(PlainButtonStyle())
        }

      }
    }
  }
}

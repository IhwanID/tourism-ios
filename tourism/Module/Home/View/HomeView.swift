//
//  HomeView.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter

    var body: some View {
        ZStack {
              if presenter.loadingState {
                VStack {
                  Text("Loading...")

                }
              } else {
                ScrollView(.vertical, showsIndicators: false) {
                  ForEach(
                    self.presenter.places,
                    id: \.id
                  ) { category in
                    ZStack {
                      self.presenter.linkBuilder(for: category) {
                      }.buttonStyle(PlainButtonStyle())
                    }.padding(8)
                  }
                }
              }
            }.onAppear {
              if self.presenter.places.count == 0 {
                self.presenter.getCategories()
              }
            }.navigationBarTitle(
              Text("Meals Apps"),
              displayMode: .automatic
            )
          }
    }

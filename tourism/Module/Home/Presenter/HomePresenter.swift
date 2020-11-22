//
//  HomePresenter.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import Foundation
import SwiftUI
import Combine

class HomePresenter: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase

    @Published var places: [Place] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false

    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }

    func getPlaces() {
        loadingState = true
        homeUseCase.getPlaces().receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { places in
                self.places = places
            })
            .store(in: &cancellables)
    }

    func linkBuilder<Content: View>(
        for place: Place,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(for: place)) { content() }
    }

}

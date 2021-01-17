//
//  DetailPresenter.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import Foundation
import SwiftUI
import Combine

class DetailPresenter: ObservableObject {

    private var cancellables: Set<AnyCancellable> = []
    private let detailUseCase: DetailUseCase

    @Published var place: Place
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false

    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
        place = detailUseCase.getPlace()
    }

    func updateFavoritePlace() {
        loadingState = true
        detailUseCase.updateFavoritePlace()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { place in
                self.place = place
            })
            .store(in: &cancellables)
    }

    
}

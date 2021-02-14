//
//  File.swift
//  
//
//  Created by Ihwan ID on 14/02/21.
//

import Foundation
import Combine
import Core

public class PlacePresenter<PlaceUseCase: UseCase, FavoriteUseCase: UseCase>: ObservableObject
where
    PlaceUseCase.Request == PlaceDomainModel, PlaceUseCase.Response == PlaceDomainModel,
    FavoriteUseCase.Request == PlaceDomainModel, FavoriteUseCase.Response == PlaceDomainModel
 {

    private var cancellables: Set<AnyCancellable> = []

    private let _placeUseCase: PlaceUseCase
    private let _favoriteUseCase: FavoriteUseCase

    @Published public var item: PlaceDomainModel?
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false

    public init(placeUseCase: PlaceUseCase, favoriteUseCase: FavoriteUseCase) {
        _placeUseCase = placeUseCase
        _favoriteUseCase = favoriteUseCase
    }
    public func getPlace(request: PlaceUseCase.Request) {
        isLoading = true
        _placeUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure (let error):
                    self.errorMessage = error.localizedDescription
                    self.isError = true
                    self.isLoading = false
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.item = item
            })
            .store(in: &cancellables)
    }

    public func updateFavoriteGame(request: FavoriteUseCase.Request) {
        _favoriteUseCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { item in
                self.item = item
            })
            .store(in: &cancellables)
    }
}

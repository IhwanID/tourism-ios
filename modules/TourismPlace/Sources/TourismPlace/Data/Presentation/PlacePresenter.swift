//
//  File.swift
//  
//
//  Created by Ihwan ID on 14/02/21.
//

import Foundation
import Combine
import Core

public class PlacePresenter<Request, Response, PlaceUseCase: UseCase, FavoriteUseCase: UseCase>: ObservableObject
where
    FavoriteUseCase.Request == Request, FavoriteUseCase.Response == Response,
    PlaceUseCase.Request == Request, PlaceUseCase.Response == Response
 {

    private var cancellables: Set<AnyCancellable> = []

    private let _placeUseCase: PlaceUseCase
    private let _favoriteUseCase: FavoriteUseCase

    @Published public var item: Response? 
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false

    public init(placeUseCase: PlaceUseCase, favoriteUseCase: FavoriteUseCase) {
        _favoriteUseCase = favoriteUseCase
        _placeUseCase = placeUseCase
    }

    public func getPlace(place: FavoriteUseCase.Request){
        self.isLoading = true
        _placeUseCase.execute(request: place)
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


    public func updateFavoritePlace(request: FavoriteUseCase.Request) {
        self.isLoading = true
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

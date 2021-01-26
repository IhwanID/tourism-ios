//
//  tourismTests.swift
//  tourismTests
//
//  Created by Ihwan ID on 17/01/21.
//

import XCTest
import Combine
@testable import tourism

class tourismTests: XCTestCase {



    func testFetchAllPlace(){
        let homeUseCase = Injection.init().provideHome()
        let placeExpectaion = expectation(description: "place")
        var cancellables: Set<AnyCancellable> = []
        var places: [Place] = []

        homeUseCase.getPlaces().receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in

            }, receiveValue: { data in
                places = data
                placeExpectaion.fulfill()
            })
            .store(in: &cancellables)


        waitForExpectations(timeout: 30) { (error) in
            print("total \(places.count)")
            XCTAssertNotNil(places)
            XCTAssertEqual(10, places.count)

          }

    }

//    func testFavoritePlace(){
//        let favoriteUseCase = Injection.init().provideFavorite()
//        let favoritePresenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)
//        let detailUseCase = Injection.init().provideDetail(place: Place(id: 1, name: "", desc: "", address: "", longitude: 0, latitude: 0, like: 0, image: ""))
//        let detailPresenter = DetailPresenter(detailUseCase: detailUseCase)
//        let favoriteExpectaion = expectation(description: "favorite")
//        DispatchQueue.main.async {
//            detailPresenter.updateFavoritePlace()
//
//            favoriteExpectaion.fulfill()
//        }
//
//        print(favoritePresenter.getFavoritePlaces())
//
//        
//        XCTAssertEqual(favoritePresenter.places.count, 0)
//        waitForExpectations(timeout: 30) { (error) in
//            XCTAssertEqual(favoritePresenter.places.count, 1)
//          }
//
//    }
    

}

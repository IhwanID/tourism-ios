//
//  tourismTests.swift
//  tourismTests
//
//  Created by Ihwan ID on 17/01/21.
//

import XCTest
@testable import tourism

class tourismTests: XCTestCase {



    func testFetchAllPlace(){
        let homeUseCase = Injection.init().provideHome()
        let homePresenter = HomePresenter(homeUseCase: homeUseCase)
        let placeExpectaion = expectation(description: "place")
        DispatchQueue.main.async {
            homePresenter.getPlaces()

            placeExpectaion.fulfill()
        }

        waitForExpectations(timeout: 30) { (error) in
            print("total \(homePresenter.places.count)")
            XCTAssertNotNil(homePresenter.places.count)
            XCTAssertEqual(10, homePresenter.places.count)

          }

    }

    func testFavoritePlace(){
        let favoriteUseCase = Injection.init().provideFavorite()
        let favoritePresenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)
        let detailUseCase = Injection.init().provideDetail(place: Place(id: 1, name: "", desc: "", address: "", longitude: 0, latitude: 0, like: 0, image: ""))
        let detailPresenter = DetailPresenter(detailUseCase: detailUseCase)
        let favoriteExpectaion = expectation(description: "favorite")
        DispatchQueue.main.async {
            detailPresenter.updateFavoritePlace()

            favoriteExpectaion.fulfill()
        }

        print(favoritePresenter.getFavoritePlaces())

        
        XCTAssertEqual(favoritePresenter.places.count, 0)
        waitForExpectations(timeout: 30) { (error) in
            XCTAssertEqual(favoritePresenter.places.count, 1)
          }

    }

}

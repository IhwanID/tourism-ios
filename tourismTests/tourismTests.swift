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
            XCTAssertNotNil(places)
            XCTAssertEqual(10, places.count)

          }

    }

    

}

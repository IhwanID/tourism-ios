import XCTest
@testable import TourismPlace

final class TourismPlaceTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(TourismPlace().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

//
//  RequestServiceTests.swift
//  Reciplease_AppTests
//
//  Created by Square on 28/02/2022.
//

import XCTest
@testable import Reciplease_App

class RequestServiceTests: XCTestCase {

    func testGetData_WhenNoDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = FakeServiceRecipe(fakeResponse: FakeResponse(response: nil, data: nil))
        let requestService = ServiceRecipes(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getData(ingredientQ: ["Chicken"]) { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getData method with no data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    // Ne passe pas
    func testGetData_WhenIncorrectResponseIsPassed_ThenShouldReturnFailedCallback() {
        let session = FakeServiceRecipe(fakeResponse: FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData))
        let requestService = ServiceRecipes(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getData(ingredientQ: ["Chicken"]) { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getData method with incorrect response failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetData_WhenUndecodableDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = FakeServiceRecipe(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData))
        let requestService = ServiceRecipes(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getData(ingredientQ: ["Chicken"]) { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getData method with undecodable data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetData_WhenCorrectDataIsPassed_ThenShouldReturnSuccededCallback() {
        let session = FakeServiceRecipe(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData))
        let requestService = ServiceRecipes(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getData(ingredientQ: ["Chicken"]) { result in
            guard case .success(let data) = result else {
                XCTFail("Test getData method with correct data failed.")
                return
            }

            XCTAssertTrue(data.hits[0].recipe.label == "Chicken Vesuvio")
    expectation.fulfill()
}
        wait(for: [expectation], timeout: 0.01)
    }
}

//
//  FakeServiceRecipes.swift
//  Reciplease_AppTests
//
//  Created by Square on 28/02/2022.
//

import Foundation
import Alamofire
@testable import Reciplease_App

struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
}

final class FakeServiceRecipe: AlamoSession {

    // MARK: - Properties

    private let fakeResponse: FakeResponse

    // MARK: - Initializer

    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    
    func requestData(url: URL, callback: @escaping (AFDataResponse<Any>) -> Void) {
        let dataResponse = AFDataResponse<Any>(request: nil, response: fakeResponse.response, data: fakeResponse.data, metrics: nil, serializationDuration: 0, result: .success("OK"))
        callback(dataResponse)
    }
}

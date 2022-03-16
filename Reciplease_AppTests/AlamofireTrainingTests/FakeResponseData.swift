//
//  FakeResponseData.swift
//  Reciplease_AppTests
//
//  Created by Square on 28/02/2022.
//

import Foundation

final class FakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://api.edamam.com/api/recipes/v2/?app_id=9f52414f&app_key=dacbb6b668204d9844630a65e6e5b718&q=chicken")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://api.edamam.com/api/recipes/v2/?app_id=9f52414f&app_key=dacbb6b668204d9844630a65e6e5b718&q=chicken")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class NetworkError: Error {}
    static let networkError = NetworkError()
    
    static var correctData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "ResponseRecipe", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let incorrectData = "erreur".data(using: .utf8)!
}

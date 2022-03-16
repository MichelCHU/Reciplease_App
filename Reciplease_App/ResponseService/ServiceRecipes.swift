//
//  ServiceRecipes.swift
//  Reciplease_App
//
//  Created by Square on 25/02/2022.
//

import Foundation
import Alamofire

final class ServiceRecipes {
    
    private let session: AlamoSession
    private let baseStringURL: String = "https://api.edamam.com/api/recipes/v2"
    init(session: AlamoSession = NetworkSession()) {
        self.session = session
    }
    
    func getData(ingredientQ: [String], callback: @escaping (Result<ResponseRecipe, NetworkError>) -> Void) {
        guard let ingredientsQ = ingredientQ.joined(separator: ",").addingPercentEncoding(withAllowedCharacters: .urlUserAllowed) else { return }
        
        guard let baseURL: URL = .init(string: baseStringURL) else { return }
        
        let url: URL = encode(with: baseURL, and: [("q","\(ingredientsQ)"),("app_id", "7c2d1063"),("app_key", "b14cf1a7c500dec0639ddfe275d50f85"), ("type","public")])
        
        #if DEBUG
        NetworkLogger(url: url).show()
        #endif
        
        session.requestData(url: url) { dataResponse in
            guard let data = dataResponse.data else {
                callback(.failure(.noData))
                return
            }
            guard dataResponse.response?.statusCode == 200 else {
                callback(.failure(.invalideResponse))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(ResponseRecipe.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            callback(.success(dataDecoded))
        }
    }
}

extension ServiceRecipes: URLEncodable {}

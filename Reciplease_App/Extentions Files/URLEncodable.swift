//
//  URLEncodable.swift
//  Reciplease_App
//
//  Created by Square on 25/02/2022.
//

import Foundation

protocol URLEncodable {
    func encode(with baseURL: URL, and parameters: [(String, Any)]?) -> URL
}

extension URLEncodable {
    
    func encode(with baseURL: URL, and parameters: [(String, Any)]?) -> URL {
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false),
              let parameters = parameters,
              !parameters.isEmpty else {
            return baseURL
        }
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0, value: "\($1)") }
        guard let url = urlComponents.url else { return baseURL }
        return url
    }
}

//
//  NetworkSession.swift
//  Reciplease_App
//
//  Created by Square on 26/02/2022.
//

import Foundation
import Alamofire

protocol AlamoSession {
    func requestData(url: URL, callback: @escaping (AFDataResponse<Any>) -> Void)
}

class NetworkSession: AlamoSession {
    func requestData(url: URL, callback: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url).responseJSON { dataResponse in
            callback(dataResponse)
        }
    }
}

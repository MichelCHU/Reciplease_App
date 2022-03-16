//
//  NetworkError.swift
//  Reciplease_App
//
//  Created by Square on 24/02/2022.
//

import Foundation

enum NetworkError: Error {
    case noData, invalideResponse, undecodableData
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .noData:
            return "Le service est momentanément insdisponible"
        case .invalideResponse:
            return "Erreur rencontrée lors de l'appel réseau"
        case .undecodableData:
            return "Les données rentrées sont incorrectes, impossible de charger des recettes"
        }
    }
}

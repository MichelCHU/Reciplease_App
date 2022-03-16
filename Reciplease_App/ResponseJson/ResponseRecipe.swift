// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct ResponseRecipe: Codable {
    let from, to, count: Int
    var links: WelcomeLinks
    var hits: [Hit]

    enum CodingKeys: String, CodingKey {
        case from, to, count
        case links = "_links"
        case hits
    }
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe
    let links: HitLinks

    enum CodingKeys: String, CodingKey {
        case recipe
        case links = "_links"
    }
}

// MARK: - HitLinks
struct HitLinks: Codable {
    let linksSelf: Next

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - Next
struct Next: Codable {
    let href: String
    let title: Title
}

enum Title: String, Codable {
    case nextPage = "Next page"
    case titleSelf = "Self"
}

// MARK: - Recipe
struct Recipe: Codable {
    let label: String?
    let image: String?
    let url: String?
    let yield: Int
    let ingredientLines: [String]
    let totalTime: Int

}

// MARK: - WelcomeLinks
struct WelcomeLinks: Codable {
    let next: Next
}

//
//  Brewery.swift
//  Umami
//
//  Created on 2025-01-05.
//

import Foundation

struct Brewery: Identifiable, Codable {
    let id: UUID
    let nameJapanese: String
    let nameEnglish: String
    let prefecture: String
    let region: String
    let established: Int?
    let description: String
    let imageURL: String
    let heroImageURL: String
    let sakeCount: Int
    let totalRatings: Int
    let website: String?
    let email: String?
    let phone: String?

    var displayName: String {
        nameEnglish.isEmpty ? nameJapanese : nameEnglish
    }

    var formattedEstablished: String {
        guard let year = established else { return "N/A" }
        return "Est. \(year)"
    }
}

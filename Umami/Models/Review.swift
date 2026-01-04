//
//  Review.swift
//  Umami
//
//  Created on 2025-01-05.
//

import Foundation

struct Review: Identifiable, Codable {
    let id: UUID
    let sakeId: UUID
    let userId: UUID
    let username: String
    let rating: Double
    let comment: String
    let tastingDate: Date
    let servingTemperature: String?
    let foodPairing: String?
    let location: String?
    let images: [String]
    let helpfulCount: Int
    let language: ReviewLanguage

    var formattedDate: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: tastingDate, relativeTo: Date())
    }
}

enum ReviewLanguage: String, Codable {
    case english = "EN"
    case japanese = "JP"
}

struct UserTastingNote: Identifiable, Codable {
    let id: UUID
    let sakeId: UUID
    let rating: Double
    let notes: String
    let date: Date
    let location: String?
    let servingTemp: String?
    let foodPairing: String?
    let isPrivate: Bool
}

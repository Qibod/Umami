//
//  UserProfile.swift
//  Umami
//
//  Created on 2025-01-05.
//

import Foundation

struct UserProfile: Codable {
    let id: UUID
    let username: String
    let displayName: String
    let email: String
    let avatarURL: String?
    let memberSince: Date
    let tasteProfile: TasteProfile
    let favoriteClassifications: [SakeClassification]
    let wishlist: [UUID]
    let favorites: [UUID]
    let myCellar: [UUID]
    let customLists: [SakeList]
    let totalRated: Int
    let totalReviewed: Int

    var memberSinceFormatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: memberSince)
    }
}

struct TasteProfile: Codable {
    var preferredSweetness: Int // 1-5
    var preferredAroma: Int // 1-5
    var preferredBody: Int // 1-5
    var adventureLevel: Int // 1-5 (1 = traditional, 5 = experimental)
    var priceSensitivity: PriceSensitivity
    var favoriteRegions: [String]
    var favoriteFoodPairings: [FoodCategory]
}

enum PriceSensitivity: String, Codable {
    case budget = "Budget"
    case moderate = "Moderate"
    case premium = "Premium"
    case luxury = "Luxury"
}

struct SakeList: Identifiable, Codable {
    let id: UUID
    let name: String
    let sakeIds: [UUID]
    let createdDate: Date
    let isPublic: Bool
}

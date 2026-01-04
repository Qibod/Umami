//
//  FoodPairing.swift
//  Umami
//
//  Created on 2025-01-05.
//

import Foundation

struct FoodPairing: Identifiable, Codable {
    let id: UUID
    let dishName: String
    let dishNameJapanese: String?
    let category: FoodCategory
    let imageURL: String
    let recommendedSakeIds: [UUID]
    let description: String

    var displayName: String {
        dishNameJapanese ?? dishName
    }
}

enum FoodCategory: String, Codable, CaseIterable {
    case sushi = "Sushi"
    case sashimi = "Sashimi"
    case tempura = "Tempura"
    case yakitori = "Yakitori"
    case ramen = "Ramen"
    case kaiseki = "Kaiseki"
    case izakaya = "Izakaya"
    case chinese = "Chinese"
    case korean = "Korean"
    case thai = "Thai"
    case italian = "Italian"
    case french = "French"
    case american = "American"
    case fusion = "Fusion"

    var icon: String {
        switch self {
        case .sushi: return "🍣"
        case .sashimi: return "🐟"
        case .tempura: return "🍤"
        case .yakitori: return "🍢"
        case .ramen: return "🍜"
        case .kaiseki: return "🍱"
        case .izakaya: return "🏮"
        case .chinese: return "🥟"
        case .korean: return "🍲"
        case .thai: return "🍛"
        case .italian: return "🍝"
        case .french: return "🥖"
        case .american: return "🍔"
        case .fusion: return "🌏"
        }
    }
}

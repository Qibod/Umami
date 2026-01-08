//
//  Sake.swift
//  Umami
//
//  Created on 2025-01-05.
//

import Foundation

struct Sake: Identifiable, Codable {
    let id: UUID
    let nameJapanese: String
    let nameEnglish: String
    let breweryId: UUID
    let breweryName: String
    let prefecture: String
    let classification: SakeClassification
    let riceVariety: String
    let polishRatio: Int // seimaibuai percentage
    let alcoholContent: Double
    let flavorProfile: FlavorProfile
    let imageURL: String
    let price: Double
    let rating: Double
    let reviewCount: Int
    let description: String
    let servingTemperature: [String]
    let availability: Availability

    var displayName: String {
        nameEnglish.isEmpty ? nameJapanese : nameEnglish
    }

    var prefectureJapanese: String {
        PrefectureHelper.getJapaneseName(for: prefecture)
    }

    func localizedName(for language: AppLanguage) -> String {
        switch language {
        case .english:
            return nameEnglish.isEmpty ? nameJapanese : nameEnglish
        case .japanese:
            return nameJapanese.isEmpty ? nameEnglish : nameJapanese
        }
    }

    func localizedPrefecture(for language: AppLanguage) -> String {
        switch language {
        case .english:
            return prefecture
        case .japanese:
            return prefectureJapanese
        }
    }

    var formattedPrice: String {
        String(format: "$%.2f", price)
    }

    var priceCategory: String {
        switch price {
        case 0..<30: return "$"
        case 30..<60: return "$$"
        case 60..<100: return "$$$"
        default: return "$$$$"
        }
    }
}

enum SakeClassification: String, Codable, CaseIterable {
    case junmai = "Junmai"
    case junmaiGinjo = "Junmai Ginjo"
    case junmaiDaiginjo = "Junmai Daiginjo"
    case honjozo = "Honjozo"
    case ginjo = "Ginjo"
    case daiginjo = "Daiginjo"
    case tokubetsuJunmai = "Tokubetsu Junmai"
    case tokubetsuHonjozo = "Tokubetsu Honjozo"
    case namazake = "Namazake"
    case nigori = "Nigori"
    case sparkling = "Sparkling"

    var japaneseLabel: String {
        switch self {
        case .junmai: return "純米"
        case .junmaiGinjo: return "純米吟醸"
        case .junmaiDaiginjo: return "純米大吟醸"
        case .honjozo: return "本醸造"
        case .ginjo: return "吟醸"
        case .daiginjo: return "大吟醸"
        case .tokubetsuJunmai: return "特別純米"
        case .tokubetsuHonjozo: return "特別本醸造"
        case .namazake: return "生酒"
        case .nigori: return "にごり酒"
        case .sparkling: return "スパークリング"
        }
    }
}

struct FlavorProfile: Codable {
    let sweetness: Int // 1-5 (1 = very dry, 5 = very sweet)
    let acidity: Int // 1-5
    let body: Int // 1-5 (1 = light, 5 = full)
    let umami: Int // 1-5
    let aromaIntensity: Int // 1-5

    var sweetnessDescription: String {
        switch sweetness {
        case 1: return "Very Dry"
        case 2: return "Dry"
        case 3: return "Balanced"
        case 4: return "Sweet"
        case 5: return "Very Sweet"
        default: return "Balanced"
        }
    }
}

enum Availability: String, Codable {
    case inStock = "In Stock"
    case rare = "Rare"
    case seasonal = "Seasonal"
    case limitedEdition = "Limited Edition"
    case outOfStock = "Out of Stock"
}

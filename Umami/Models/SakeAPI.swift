//
//  SakeAPI.swift
//  Umami
//
//  API-compatible models with snake_case mapping
//  Created on 2025-01-05.
//

import Foundation

// MARK: - API Sake Model (matches backend snake_case)
struct APISake: Codable {
    let id: UUID
    let nameJapanese: String
    let nameEnglish: String
    let breweryId: UUID
    let breweryName: String
    let prefecture: String
    let classification: String
    let riceVariety: String?
    let polishRatio: Int?
    let alcoholContent: Double
    let sweetness: Int
    let acidity: Int
    let body: Int
    let umami: Int
    let aromaIntensity: Int
    let smv: String?
    let acidityValue: Double?
    let imageUrl: String
    let price: Double
    let content: String
    let rating: Double
    let reviewCount: Int
    let description: String
    let servingTemperature: [String]
    let availability: String
    let isMock: Bool
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case nameJapanese = "name_japanese"
        case nameEnglish = "name_english"
        case breweryId = "brewery_id"
        case breweryName = "brewery_name"
        case prefecture
        case classification
        case riceVariety = "rice_variety"
        case polishRatio = "polish_ratio"
        case alcoholContent = "alcohol_content"
        case sweetness
        case acidity
        case body
        case umami
        case aromaIntensity = "aroma_intensity"
        case smv
        case acidityValue = "acidity_value"
        case imageUrl = "image_url"
        case price
        case content
        case rating
        case reviewCount = "review_count"
        case description
        case servingTemperature = "serving_temperature"
        case availability
        case isMock = "is_mock"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

    // Convert to app's Sake model
    func toSake() -> Sake {
        return Sake(
            id: id,
            nameJapanese: nameJapanese,
            nameEnglish: nameEnglish,
            breweryId: breweryId,
            breweryName: breweryName,
            prefecture: prefecture,
            classification: SakeClassification(rawValue: classification) ?? .junmai,
            riceVariety: riceVariety ?? "Unknown",
            polishRatio: polishRatio ?? 60,
            alcoholContent: alcoholContent,
            flavorProfile: FlavorProfile(
                sweetness: sweetness,
                acidity: acidity,
                body: body,
                umami: umami,
                aromaIntensity: aromaIntensity
            ),
            imageURL: imageUrl,
            price: price,
            rating: rating,
            reviewCount: reviewCount,
            description: description,
            servingTemperature: servingTemperature,
            availability: Availability(rawValue: availability) ?? .inStock
        )
    }
}

// MARK: - API Brewery Model
struct APIBrewery: Codable {
    let id: UUID
    let nameJapanese: String
    let nameEnglish: String
    let prefecture: String
    let region: String?
    let established: Int?
    let description: String
    let imageUrl: String?
    let heroImageUrl: String?
    let sakeCount: Int
    let totalRatings: Int
    let website: String?
    let email: String?
    let phone: String?
    let isMock: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case nameJapanese = "name_japanese"
        case nameEnglish = "name_english"
        case prefecture, region, established, description
        case imageUrl = "image_url"
        case heroImageUrl = "hero_image_url"
        case sakeCount = "sake_count"
        case totalRatings = "total_ratings"
        case website, email, phone
        case isMock = "is_mock"
    }

    // Convert to app's Brewery model
    func toBrewery() -> Brewery {
        return Brewery(
            id: id,
            nameJapanese: nameJapanese,
            nameEnglish: nameEnglish,
            prefecture: prefecture,
            region: region ?? "",
            established: established ?? 1900,
            description: description,
            imageURL: imageUrl ?? "",
            heroImageURL: heroImageUrl ?? "",
            sakeCount: sakeCount,
            totalRatings: totalRatings,
            website: website,
            email: email,
            phone: phone
        )
    }
}

// MARK: - API Food Pairing Model
struct APIFoodPairing: Codable {
    let id: UUID
    let dishName: String
    let dishNameJapanese: String?
    let category: String
    let imageUrl: String?
    let description: String

    enum CodingKeys: String, CodingKey {
        case id
        case dishName = "dish_name"
        case dishNameJapanese = "dish_name_japanese"
        case category
        case imageUrl = "image_url"
        case description
    }

    // Convert to app's FoodPairing model
    func toFoodPairing() -> FoodPairing {
        return FoodPairing(
            id: id,
            dishName: dishName,
            dishNameJapanese: dishNameJapanese ?? dishName,
            category: FoodCategory(rawValue: category) ?? .sushi,
            imageURL: imageUrl ?? "",
            recommendedSakeIds: [], // Would need separate API call
            description: description
        )
    }
}

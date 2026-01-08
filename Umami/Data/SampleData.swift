//
//  SampleData.swift
//  Umami
//
//  Created on 2025-01-05.
//

import Foundation

class SampleData {
    static let shared = SampleData()

    // MARK: - Sample Breweries
    let breweries: [Brewery] = [
        Brewery(
            id: UUID(uuidString: "11111111-1111-1111-1111-111111111111")!,
            nameJapanese: "旭酒造",
            nameEnglish: "Asahi Shuzo",
            prefecture: "Yamaguchi",
            region: "Chugoku",
            established: 1770,
            description: "Famous for Dassai, one of the most recognized sake brands worldwide.",
            imageURL: "brewery1",
            heroImageURL: "brewery1_hero",
            sakeCount: 12,
            totalRatings: 125678,
            website: "https://www.asahishuzo.ne.jp",
            email: "info@asahishuzo.ne.jp",
            phone: "+81-827-86-0120"
        ),
        Brewery(
            id: UUID(uuidString: "22222222-2222-2222-2222-222222222222")!,
            nameJapanese: "獺祭醸造元",
            nameEnglish: "Dassai Brewery",
            prefecture: "Yamaguchi",
            region: "Chugoku",
            established: 1948,
            description: "Specializing in premium junmai daiginjo sake using Yamada Nishiki rice.",
            imageURL: "brewery2",
            heroImageURL: "brewery2_hero",
            sakeCount: 8,
            totalRatings: 98432,
            website: nil,
            email: nil,
            phone: nil
        ),
        Brewery(
            id: UUID(uuidString: "33333333-3333-3333-3333-333333333333")!,
            nameJapanese: "黒龍酒造",
            nameEnglish: "Kokuryu Sake Brewing",
            prefecture: "Fukui",
            region: "Chubu",
            established: 1804,
            description: "Historic brewery known for elegant and refined sake.",
            imageURL: "brewery3",
            heroImageURL: "brewery3_hero",
            sakeCount: 15,
            totalRatings: 87654,
            website: "https://www.kokuryu.co.jp",
            email: "info@kokuryu.co.jp",
            phone: nil
        )
    ]

    // MARK: - Sample Sake
    let sakes: [Sake] = [
        Sake(
            id: UUID(uuidString: "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa")!,
            nameJapanese: "獺祭 純米大吟醸 磨き二割三分",
            nameEnglish: "Dassai 23",
            breweryId: UUID(uuidString: "11111111-1111-1111-1111-111111111111")!,
            breweryName: "Asahi Shuzo",
            prefecture: "Yamaguchi",
            classification: .junmaiDaiginjo,
            riceVariety: "Yamada Nishiki",
            polishRatio: 23,
            alcoholContent: 16.0,
            flavorProfile: FlavorProfile(sweetness: 3, acidity: 2, body: 4, umami: 4, aromaIntensity: 5),
            imageURL: "sake1",
            price: 185.00,
            rating: 4.6,
            reviewCount: 12589,
            description: "Ultra-premium junmai daiginjo with rice polished to 23%. Delicate, fruity aroma with hints of melon and apple.",
            servingTemperature: ["Chilled (5-10°C)", "Room temperature"],
            availability: .inStock
        ),
        Sake(
            id: UUID(uuidString: "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb")!,
            nameJapanese: "久保田 萬寿",
            nameEnglish: "Kubota Manju",
            breweryId: UUID(uuidString: "22222222-2222-2222-2222-222222222222")!,
            breweryName: "Asahi Shuzo",
            prefecture: "Niigata",
            classification: .junmaiDaiginjo,
            riceVariety: "Gohyakumangoku",
            polishRatio: 50,
            alcoholContent: 15.0,
            flavorProfile: FlavorProfile(sweetness: 2, acidity: 3, body: 3, umami: 3, aromaIntensity: 3),
            imageURL: "sake2",
            price: 75.00,
            rating: 4.5,
            reviewCount: 8432,
            description: "Elegant and smooth junmai daiginjo from Niigata. Well-balanced with subtle complexity.",
            servingTemperature: ["Chilled (5-10°C)"],
            availability: .inStock
        ),
        Sake(
            id: UUID(uuidString: "cccccccc-cccc-cccc-cccc-cccccccccccc")!,
            nameJapanese: "黒龍 純吟",
            nameEnglish: "Kokuryu Jungin",
            breweryId: UUID(uuidString: "33333333-3333-3333-3333-333333333333")!,
            breweryName: "Kokuryu Sake Brewing",
            prefecture: "Fukui",
            classification: .junmaiGinjo,
            riceVariety: "Yamada Nishiki",
            polishRatio: 55,
            alcoholContent: 15.5,
            flavorProfile: FlavorProfile(sweetness: 2, acidity: 2, body: 3, umami: 4, aromaIntensity: 3),
            imageURL: "sake3",
            price: 45.00,
            rating: 4.4,
            reviewCount: 5678,
            description: "Clean and crisp junmai ginjo. Perfect balance of umami and gentle acidity.",
            servingTemperature: ["Chilled (5-10°C)", "Room temperature"],
            availability: .inStock
        ),
        Sake(
            id: UUID(uuidString: "aaaa1111-bbbb-2222-cccc-333333333333")!,
            nameJapanese: "八海山 発泡にごり酒",
            nameEnglish: "Hakkaisan Sparkling Nigori",
            breweryId: UUID(uuidString: "22222222-2222-2222-2222-222222222222")!,
            breweryName: "Hakkaisan Brewery",
            prefecture: "Niigata",
            classification: .junmaiGinjo,
            riceVariety: "Gohyakumangoku",
            polishRatio: 60,
            alcoholContent: 14.5,
            flavorProfile: FlavorProfile(sweetness: 4, acidity: 3, body: 2, umami: 2, aromaIntensity: 4),
            imageURL: "hakkaisan_sparkling_transparent", // Updated to transparent asset
            price: 19.00,
            rating: 4.8,
            reviewCount: 42,
            description: "A refreshing sparkling sake. Lightly sweet and crisp with a soft nigori texture. Perfect for celebrations.",
            servingTemperature: ["Chilled (5-10°C)"],
            availability: .inStock
        ),
        Sake(
            id: UUID(uuidString: "dddddddd-dddd-dddd-dddd-dddddddddddd")!,
            nameJapanese: "獺祭 純米大吟醸 磨き三割九分",
            nameEnglish: "Dassai 39",
            breweryId: UUID(uuidString: "11111111-1111-1111-1111-111111111111")!,
            breweryName: "Asahi Shuzo",
            prefecture: "Yamaguchi",
            classification: .junmaiDaiginjo,
            riceVariety: "Yamada Nishiki",
            polishRatio: 39,
            alcoholContent: 16.0,
            flavorProfile: FlavorProfile(sweetness: 3, acidity: 2, body: 3, umami: 3, aromaIntensity: 4),
            imageURL: "sake4",
            price: 52.00,
            rating: 4.5,
            reviewCount: 9876,
            description: "Entry-level Dassai with excellent quality. Fruity and aromatic with smooth finish.",
            servingTemperature: ["Chilled (5-10°C)"],
            availability: .inStock
        ),
        Sake(
            id: UUID(uuidString: "eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee")!,
            nameJapanese: "八海山 純米吟醸",
            nameEnglish: "Hakkaisan Junmai Ginjo",
            breweryId: UUID(uuidString: "22222222-2222-2222-2222-222222222222")!,
            breweryName: "Hakkaisan Brewery",
            prefecture: "Niigata",
            classification: .junmaiGinjo,
            riceVariety: "Gohyakumangoku",
            polishRatio: 50,
            alcoholContent: 15.5,
            flavorProfile: FlavorProfile(sweetness: 2, acidity: 3, body: 2, umami: 3, aromaIntensity: 2),
            imageURL: "sake5",
            price: 38.00,
            rating: 4.3,
            reviewCount: 6543,
            description: "Clean and refined Niigata-style sake. Light body with delicate aroma.",
            servingTemperature: ["Chilled (5-10°C)", "Room temperature"],
            availability: .inStock
        ),
        Sake(
            id: UUID(uuidString: "ffffffff-ffff-ffff-ffff-ffffffffffff")!,
            nameJapanese: "十四代 本丸 秘伝玉返し",
            nameEnglish: "Juyondai Honmaru",
            breweryId: UUID(uuidString: "33333333-3333-3333-3333-333333333333")!,
            breweryName: "Takagi Shuzo",
            prefecture: "Yamagata",
            classification: .honjozo,
            riceVariety: "Yamada Nishiki",
            polishRatio: 60,
            alcoholContent: 15.0,
            flavorProfile: FlavorProfile(sweetness: 3, acidity: 2, body: 4, umami: 4, aromaIntensity: 4),
            imageURL: "sake6",
            price: 120.00,
            rating: 4.7,
            reviewCount: 3421,
            description: "Highly sought-after sake. Rich umami with fruity complexity and elegant finish.",
            servingTemperature: ["Chilled (5-10°C)", "Room temperature"],
            availability: .rare
        )
    ]

    // MARK: - Sample Food Pairings
    let foodPairings: [FoodPairing] = [
        FoodPairing(
            id: UUID(),
            dishName: "Sushi",
            dishNameJapanese: "寿司",
            category: .sushi,
            imageURL: "food_sushi",
            recommendedSakeIds: [
                UUID(uuidString: "bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb")!,
                UUID(uuidString: "eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee")!
            ],
            description: "Pair with clean, crisp sake that won't overpower the delicate fish flavors."
        ),
        FoodPairing(
            id: UUID(),
            dishName: "Sashimi",
            dishNameJapanese: "刺身",
            category: .sashimi,
            imageURL: "food_sashimi",
            recommendedSakeIds: [
                UUID(uuidString: "cccccccc-cccc-cccc-cccc-cccccccccccc")!
            ],
            description: "Light, dry sake complements the pure taste of raw fish."
        ),
        FoodPairing(
            id: UUID(),
            dishName: "Tempura",
            dishNameJapanese: "天ぷら",
            category: .tempura,
            imageURL: "food_tempura",
            recommendedSakeIds: [
                UUID(uuidString: "dddddddd-dddd-dddd-dddd-dddddddddddd")!
            ],
            description: "Aromatic sake cuts through the richness of fried food."
        ),
        FoodPairing(
            id: UUID(),
            dishName: "Yakitori",
            dishNameJapanese: "焼き鳥",
            category: .yakitori,
            imageURL: "food_yakitori",
            recommendedSakeIds: [
                UUID(uuidString: "ffffffff-ffff-ffff-ffff-ffffffffffff")!
            ],
            description: "Rich, umami-forward sake pairs perfectly with grilled chicken."
        )
    ]

    // MARK: - Helper Methods
    func getSakeById(_ id: UUID) -> Sake? {
        sakes.first { $0.id == id }
    }

    func getBreweryById(_ id: UUID) -> Brewery? {
        breweries.first { $0.id == id }
    }

    func getSakesByBrewery(_ breweryId: UUID) -> [Sake] {
        sakes.filter { $0.breweryId == breweryId }
    }
}

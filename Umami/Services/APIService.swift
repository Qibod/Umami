//
//  APIService.swift
//  Umami
//
//  Created on 2025-01-05.
//

import Foundation

class APIService {
    static let shared = APIService()

    // MARK: - Configuration
    // Change this to your backend URL
    // For local testing: "http://localhost:3000/api"
    // For production: "https://your-app.vercel.app/api"
    private let baseURL = "http://localhost:3000/api"

    private init() {}

    // MARK: - Sake Endpoints

    func fetchAllSake(
        classification: String? = nil,
        prefecture: String? = nil,
        minPrice: Double? = nil,
        maxPrice: Double? = nil,
        minRating: Double? = nil,
        search: String? = nil,
        sortBy: String = "rating",
        sortOrder: String = "desc",
        limit: Int = 50,
        offset: Int = 0
    ) async throws -> SakeResponse {
        var components = URLComponents(string: "\(baseURL)/sake")!
        var queryItems: [URLQueryItem] = []

        if let classification = classification {
            queryItems.append(URLQueryItem(name: "classification", value: classification))
        }
        if let prefecture = prefecture {
            queryItems.append(URLQueryItem(name: "prefecture", value: prefecture))
        }
        if let minPrice = minPrice {
            queryItems.append(URLQueryItem(name: "minPrice", value: String(minPrice)))
        }
        if let maxPrice = maxPrice {
            queryItems.append(URLQueryItem(name: "maxPrice", value: String(maxPrice)))
        }
        if let minRating = minRating {
            queryItems.append(URLQueryItem(name: "minRating", value: String(minRating)))
        }
        if let search = search {
            queryItems.append(URLQueryItem(name: "search", value: search))
        }

        queryItems.append(URLQueryItem(name: "sortBy", value: sortBy))
        queryItems.append(URLQueryItem(name: "sortOrder", value: sortOrder))
        queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
        queryItems.append(URLQueryItem(name: "offset", value: String(offset)))

        components.queryItems = queryItems

        let (data, _) = try await URLSession.shared.data(from: components.url!)
        let response = try JSONDecoder().decode(SakeResponse.self, from: data)
        return response
    }

    func fetchSake(id: UUID) async throws -> SakeDetailResponse {
        let url = URL(string: "\(baseURL)/sake/\(id.uuidString)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(SakeDetailResponse.self, from: data)
        return response
    }

    // MARK: - Brewery Endpoints

    func fetchAllBreweries(prefecture: String? = nil, limit: Int = 50, offset: Int = 0) async throws -> BreweryResponse {
        var components = URLComponents(string: "\(baseURL)/breweries")!
        var queryItems: [URLQueryItem] = []

        if let prefecture = prefecture {
            queryItems.append(URLQueryItem(name: "prefecture", value: prefecture))
        }
        queryItems.append(URLQueryItem(name: "limit", value: String(limit)))
        queryItems.append(URLQueryItem(name: "offset", value: String(offset)))

        components.queryItems = queryItems

        let (data, _) = try await URLSession.shared.data(from: components.url!)
        let response = try JSONDecoder().decode(BreweryResponse.self, from: data)
        return response
    }

    func fetchBrewery(id: UUID) async throws -> BreweryDetailResponse {
        let url = URL(string: "\(baseURL)/breweries/\(id.uuidString)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(BreweryDetailResponse.self, from: data)
        return response
    }

    func fetchBrewerySake(breweryId: UUID) async throws -> SakeResponse {
        let url = URL(string: "\(baseURL)/breweries/\(breweryId.uuidString)/sake")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(SakeResponse.self, from: data)
        return response
    }

    // MARK: - Food Pairing Endpoints

    func fetchFoodPairings() async throws -> FoodPairingResponse {
        let url = URL(string: "\(baseURL)/food-pairings")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(FoodPairingResponse.self, from: data)
        return response
    }

    // MARK: - Stats Endpoint

    func fetchStats() async throws -> StatsResponse {
        let url = URL(string: "\(baseURL)/stats")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(StatsResponse.self, from: data)
        return response
    }

    // MARK: - Helper function to get all classifications

    func fetchClassifications() async throws -> [String] {
        let url = URL(string: "\(baseURL)/classifications")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(ClassificationsResponse.self, from: data)
        return response.data
    }

    // MARK: - Helper function to get all prefectures

    func fetchPrefectures() async throws -> [String] {
        let url = URL(string: "\(baseURL)/prefectures")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(PrefecturesResponse.self, from: data)
        return response.data
    }
}

// MARK: - Response Models

struct SakeResponse: Codable {
    let data: [APISake]
    let pagination: Pagination?
}

struct SakeDetailResponse: Codable {
    let data: APISake
}

struct BreweryResponse: Codable {
    let data: [APIBrewery]
    let pagination: Pagination?
}

struct BreweryDetailResponse: Codable {
    let data: APIBrewery
}

struct FoodPairingResponse: Codable {
    let data: [APIFoodPairing]
}

struct StatsResponse: Codable {
    let data: Stats
}

struct Stats: Codable {
    let sake: Int
    let breweries: Int
    let reviews: Int
}

struct ClassificationsResponse: Codable {
    let data: [String]
}

struct PrefecturesResponse: Codable {
    let data: [String]
}

struct Pagination: Codable {
    let total: Int?
    let limit: Int
    let offset: Int
}

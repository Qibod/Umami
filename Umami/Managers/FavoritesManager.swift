//
//  FavoritesManager.swift
//  Umami
//
//  Created on 2025-01-06.
//

import Foundation
import SwiftUI
import Combine

class FavoritesManager: ObservableObject {
    static let shared = FavoritesManager()

    @Published var favoriteIds: Set<UUID> = []

    private let favoritesKey = "favorites"

    private init() {
        loadFavorites()
    }

    func toggleFavorite(_ sakeId: UUID) {
        if favoriteIds.contains(sakeId) {
            favoriteIds.remove(sakeId)
        } else {
            favoriteIds.insert(sakeId)
        }
        saveFavorites()
    }

    func isFavorite(_ sakeId: UUID) -> Bool {
        return favoriteIds.contains(sakeId)
    }

    private func saveFavorites() {
        let idStrings = favoriteIds.map { $0.uuidString }
        UserDefaults.standard.set(idStrings, forKey: favoritesKey)
    }

    private func loadFavorites() {
        guard let idStrings = UserDefaults.standard.array(forKey: favoritesKey) as? [String] else {
            return
        }
        favoriteIds = Set(idStrings.compactMap { UUID(uuidString: $0) })
    }
}

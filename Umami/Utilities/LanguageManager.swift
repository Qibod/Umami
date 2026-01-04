//
//  LanguageManager.swift
//  Umami
//
//  Created on 2025-01-05.
//

import Foundation
import SwiftUI
import Combine

enum AppLanguage: String, Codable, CaseIterable {
    case english = "en"
    case japanese = "ja"

    var displayName: String {
        switch self {
        case .english: return "English"
        case .japanese: return "日本語"
        }
    }

    var flag: String {
        switch self {
        case .english: return "🇺🇸"
        case .japanese: return "🇯🇵"
        }
    }
}

class LanguageManager: ObservableObject {
    static let shared = LanguageManager()

    @Published var currentLanguage: AppLanguage {
        didSet {
            UserDefaults.standard.set(currentLanguage.rawValue, forKey: "selectedLanguage")
        }
    }

    private init() {
        // Load saved language or use device default
        if let savedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage"),
           let language = AppLanguage(rawValue: savedLanguage) {
            currentLanguage = language
        } else {
            // Default to English, can be changed to detect device language
            currentLanguage = .english
        }
    }

    func toggleLanguage() {
        currentLanguage = currentLanguage == .english ? .japanese : .english
    }
}

// MARK: - Localized Strings
struct LocalizedStrings {
    static func get(_ key: String, language: AppLanguage) -> String {
        switch language {
        case .english:
            return englishStrings[key] ?? key
        case .japanese:
            return japaneseStrings[key] ?? key
        }
    }

    // English strings
    private static let englishStrings: [String: String] = [
        // Authentication
        "welcome": "Welcome to Umami",
        "welcomeSubtitle": "Discover the world of sake",
        "signInWithEmail": "Sign in with Email",
        "signInWithApple": "Sign in with Apple",
        "signInWithGoogle": "Sign in with Google",
        "continueAsGuest": "Continue as Guest",
        "orContinueWith": "or continue with",
        "bySigningIn": "By signing in, you agree to our Terms of Service and Privacy Policy",

        // Tab Bar
        "home": "Home",
        "shop": "Shop",
        "camera": "Camera",
        "mySake": "My Sake",
        "more": "More",

        // Home Page
        "searchAnySake": "Search any sake",
        "bestOffers": "Best offers for you",
        "bestOffersSubtitle": "Great value. Seamless service. Brilliant sake from Umami and our best merchants.",
        "bestsellers": "Bestsellers in Japan",
        "priceDrops": "Price drops",
        "highlyRated": "Highly rated",

        // Shop Page
        "sort": "Sort",
        "filter": "Filter",
        "showSake": "Show %@ sake",
        "clear": "Clear",

        // Filter options
        "type": "Type",
        "rating": "Rating",
        "price": "Price",
        "onlyShowsOffers": "Only shows offers",
        "prefecture": "Prefecture",
        "riceVariety": "Rice Variety",
        "showAll": "Show all",

        // More Page
        "exploreBreweries": "Explore Sake Breweries",
        "foodAndSake": "Food & Sake",
        "friendsFeed": "Friends Feed",
        "sakeAdventures": "Sake Adventures",
        "premiumBenefits": "My Premium Benefits",
        "helpSupport": "Help & Support",
        "settings": "Settings",
        "followers": "followers",
        "following": "following",

        // My Sake Page
        "triedScanned": "Tried the sake you scanned?",
        "triedScannedSubtitle": "Rate to keep track of what you liked (or didn't!) and build your personal taste profile",
        "latest": "Latest",
        "tasteProfile": "Your taste profile",
        "tasteProfileSubtitle": "Your taste profile keeps track of the sake you interact with on Umami to find perfect recommendations for your palate",
        "summary": "Summary",
        "edit": "Edit",
        "basedOnInput": "Based on your input",
        "sakeTried": "Sake Tried",
        "favorites": "Favorites",
        "wishlist": "Wishlist",
        "collections": "Collections",
        "myCellar": "My Cellar",

        // Sake Details
        "details": "Details",
        "flavorProfile": "Flavor Profile",
        "about": "About",
        "servingTemperature": "Serving Temperature",
        "recommendedPairings": "Recommended Food Pairings",
        "reviews": "Reviews",
        "seeAll": "See all",
        "addToCart": "Add to Cart",
        "rate": "Rate",

        // Flavor attributes
        "sweetness": "Sweetness",
        "acidity": "Acidity",
        "body": "Body",
        "umami": "Umami",
        "aroma": "Aroma",

        // Camera
        "positionBottle": "Position bottle in frame",
        "autoDetect": "Camera will auto-detect sake bottle",
        "recognizing": "Recognizing sake...",

        // Common
        "search": "Search",
        "done": "Done",
        "cancel": "Cancel",
        "save": "Save",
        "delete": "Delete",
        "share": "Share",
        "loading": "Loading...",
    ]

    // Japanese strings
    private static let japaneseStrings: [String: String] = [
        // Authentication
        "welcome": "Umamiへようこそ",
        "welcomeSubtitle": "日本酒の世界を発見する",
        "signInWithEmail": "メールでサインイン",
        "signInWithApple": "Appleでサインイン",
        "signInWithGoogle": "Googleでサインイン",
        "continueAsGuest": "ゲストとして続ける",
        "orContinueWith": "または次の方法で続行",
        "bySigningIn": "サインインすることで、利用規約とプライバシーポリシーに同意したことになります",

        // Tab Bar
        "home": "ホーム",
        "shop": "ショップ",
        "camera": "カメラ",
        "mySake": "マイ日本酒",
        "more": "もっと見る",

        // Home Page
        "searchAnySake": "日本酒を検索",
        "bestOffers": "おすすめのオファー",
        "bestOffersSubtitle": "お得な価格。シームレスなサービス。Umamiと提携店からの素晴らしい日本酒。",
        "bestsellers": "日本のベストセラー",
        "priceDrops": "値下げ商品",
        "highlyRated": "高評価",

        // Shop Page
        "sort": "並び替え",
        "filter": "フィルター",
        "showSake": "%@件の日本酒を表示",
        "clear": "クリア",

        // Filter options
        "type": "タイプ",
        "rating": "評価",
        "price": "価格",
        "onlyShowsOffers": "オファーのみ表示",
        "prefecture": "都道府県",
        "riceVariety": "米の品種",
        "showAll": "すべて表示",

        // More Page
        "exploreBreweries": "酒蔵を探索",
        "foodAndSake": "料理と日本酒",
        "friendsFeed": "友達のフィード",
        "sakeAdventures": "日本酒アドベンチャー",
        "premiumBenefits": "プレミアム特典",
        "helpSupport": "ヘルプとサポート",
        "settings": "設定",
        "followers": "フォロワー",
        "following": "フォロー中",

        // My Sake Page
        "triedScanned": "スキャンした日本酒を試しましたか？",
        "triedScannedSubtitle": "評価して、好きだったもの（または好きではなかったもの）を追跡し、個人的な味覚プロファイルを構築しましょう",
        "latest": "最新",
        "tasteProfile": "あなたの味覚プロファイル",
        "tasteProfileSubtitle": "味覚プロファイルは、Umamiで交流した日本酒を追跡し、あなたの好みに最適な推奨を見つけます",
        "summary": "概要",
        "edit": "編集",
        "basedOnInput": "あなたの入力に基づいて",
        "sakeTried": "試した日本酒",
        "favorites": "お気に入り",
        "wishlist": "ウィッシュリスト",
        "collections": "コレクション",
        "myCellar": "マイセラー",

        // Sake Details
        "details": "詳細",
        "flavorProfile": "フレーバープロファイル",
        "about": "について",
        "servingTemperature": "提供温度",
        "recommendedPairings": "おすすめの料理ペアリング",
        "reviews": "レビュー",
        "seeAll": "すべて見る",
        "addToCart": "カートに追加",
        "rate": "評価する",

        // Flavor attributes
        "sweetness": "甘味",
        "acidity": "酸味",
        "body": "ボディ",
        "umami": "旨味",
        "aroma": "香り",

        // Camera
        "positionBottle": "フレーム内にボトルを配置",
        "autoDetect": "カメラが日本酒ボトルを自動検出",
        "recognizing": "日本酒を認識中...",

        // Common
        "search": "検索",
        "done": "完了",
        "cancel": "キャンセル",
        "save": "保存",
        "delete": "削除",
        "share": "共有",
        "loading": "読み込み中...",
    ]
}

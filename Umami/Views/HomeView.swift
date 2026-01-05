//
//  HomeView.swift
//  Umami
//
//  Updated to use backend API
//  Created on 2025-01-05.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @State private var searchText = ""
    @State private var sakes: [Sake] = []
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: AppTheme.Spacing.lg) {
                    // Header with search and icons
                    headerSection

                    // Search bar
                    searchBar

                    if isLoading {
                        ProgressView("Loading sake...")
                            .padding()
                    } else if let error = errorMessage {
                        errorView(error)
                    } else {
                        // Best offers section
                        bestOffersSection

                        // Bestsellers section
                        bestsellersSection

                        // Price drops section
                        priceDropsSection

                        // Highly rated section
                        highlyRatedSection
                    }

                    Spacer(minLength: 80)
                }
                .padding(.top, AppTheme.Spacing.md)
            }
            .background(AppTheme.Colors.lightBackground)
            .task {
                await loadSakes()
            }
            .refreshable {
                await loadSakes()
            }
        }
    }

    // MARK: - Header Section
    private var headerSection: some View {
        HStack {
            Spacer()

            HStack(spacing: AppTheme.Spacing.md) {
                // Language toggle
                LanguageToggle()

                // Country flag
                Text(languageManager.currentLanguage == .english ? "🇺🇸" : "🇯🇵")
                    .font(.title2)

                // Shopping cart icon
                Image(systemName: "cart")
                    .font(.title3)
                    .foregroundColor(AppTheme.Colors.primary)

                // Notification bell
                Image(systemName: "bell")
                    .font(.title3)
                    .foregroundColor(AppTheme.Colors.primary)
            }
        }
        .padding(.horizontal, AppTheme.Spacing.lg)
    }

    // MARK: - Search Bar
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField(
                languageManager.currentLanguage == .english ? "Search any sake" : "日本酒を検索",
                text: $searchText
            )
            .textFieldStyle(PlainTextFieldStyle())
        }
        .padding(AppTheme.Spacing.md)
        .background(Color.white)
        .cornerRadius(AppTheme.CornerRadius.medium)
        .padding(.horizontal, AppTheme.Spacing.lg)
    }

    // MARK: - Best Offers Section
    private var bestOffersSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            sectionHeader(
                title: languageManager.currentLanguage == .english
                    ? "Best offers for you"
                    : "あなたへのベストオファー",
                subtitle: languageManager.currentLanguage == .english
                    ? "Great value. Seamless service. Brilliant sake from Umami and our best merchants."
                    : "お買い得。シームレスなサービス。Umamiと最高の商人からの素晴らしい日本酒。"
            )

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppTheme.Spacing.md) {
                    ForEach(Array(sakes.prefix(5))) { sake in
                        NavigationLink(destination: SakeDetailView(sake: sake)) {
                            SakeCard(sake: sake)
                                .frame(width: 200)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
            }
        }
    }

    // MARK: - Bestsellers Section
    private var bestsellersSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            sectionHeader(
                title: languageManager.currentLanguage == .english
                    ? "Bestsellers in Japan"
                    : "日本のベストセラー",
                subtitle: nil
            )

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppTheme.Spacing.md) {
                    ForEach(Array(sakes.dropFirst(5).prefix(5))) { sake in
                        NavigationLink(destination: SakeDetailView(sake: sake)) {
                            SakeCard(sake: sake)
                                .frame(width: 200)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
            }
        }
    }

    // MARK: - Price Drops Section
    private var priceDropsSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            sectionHeader(
                title: languageManager.currentLanguage == .english
                    ? "Price drops"
                    : "値下げ",
                subtitle: nil
            )

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppTheme.Spacing.md) {
                    ForEach(Array(sakes.dropFirst(10).prefix(5))) { sake in
                        NavigationLink(destination: SakeDetailView(sake: sake)) {
                            SakeCard(sake: sake)
                                .frame(width: 200)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
            }
        }
    }

    // MARK: - Highly Rated Section
    private var highlyRatedSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            sectionHeader(
                title: languageManager.currentLanguage == .english
                    ? "Highly rated"
                    : "高評価",
                subtitle: nil
            )

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppTheme.Spacing.md) {
                    ForEach(Array(sakes.sorted { $0.rating > $1.rating }.prefix(5))) { sake in
                        NavigationLink(destination: SakeDetailView(sake: sake)) {
                            SakeCard(sake: sake)
                                .frame(width: 200)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
            }
        }
    }

    // MARK: - Section Header
    private func sectionHeader(title: String, subtitle: String?) -> some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
            HStack {
                Text(title)
                    .font(AppTheme.Typography.title2)
                    .fontWeight(.bold)
                    .foregroundColor(AppTheme.Colors.textPrimary)

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }

            if let subtitle = subtitle {
                Text(subtitle)
                    .font(AppTheme.Typography.body)
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }
        }
        .padding(.horizontal, AppTheme.Spacing.lg)
    }

    // MARK: - Error View
    private func errorView(_ message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.orange)

            Text("Error Loading Data")
                .font(.title2)
                .fontWeight(.bold)

            Text(message)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Text("Make sure backend is running at http://localhost:3000")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button(action: {
                Task {
                    await loadSakes()
                }
            }) {
                Text("Retry")
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(AppTheme.Colors.primary)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }

    // MARK: - Load Sakes
    private func loadSakes() async {
        isLoading = true
        errorMessage = nil

        do {
            print("📡 Fetching sakes from API...")
            let response = try await APIService.shared.fetchAllSake(
                sortBy: "rating",
                sortOrder: "desc",
                limit: 50
            )

            print("✅ Received \(response.data.count) sakes from API")

            // Convert API models to app models
            sakes = response.data.map { $0.toSake() }

            print("✅ Converted to app models")
        } catch {
            errorMessage = error.localizedDescription
            print("❌ Error loading sakes: \(error)")
        }

        isLoading = false
    }
}

#Preview {
    HomeView()
        .environmentObject(LanguageManager())
}

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
    @State private var filteredSakes: [Sake] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var isSearching = false

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .top) {
                    // Scrollable content
                    ScrollView {
                        VStack(spacing: AppTheme.Spacing.lg) {
                            // Spacer for fixed header (icons + search bar)
                            Spacer()
                                .frame(height: 100)

                            if isLoading {
                                ProgressView("Loading sake...")
                                    .padding()
                            } else if let error = errorMessage {
                                errorView(error)
                            } else if isSearching && !searchText.isEmpty {
                                // Search results
                                searchResultsSection
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
                        .padding(.top, geometry.safeAreaInsets.top + 8)
                    }

                    // Fixed header section (stays at top)
                    VStack(spacing: 0) {
                        // Header with icons
                        headerSection
                            .padding(.vertical, 8)

                        // Search bar
                        searchBar
                            .padding(.bottom, 8)
                    }
                    .background(AppTheme.Colors.lightBackground) // Background for the header content itself
                }
            }
            // Extend the background color of the header into the safe area (notch),
            // while keeping the content safely below it.
            .background(AppTheme.Colors.lightBackground.ignoresSafeArea(edges: .top))
            .task {
                await loadSakes()
            }
            .refreshable {
                await loadSakes()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    // MARK: - Header Section
    private var headerSection: some View {
        HStack(alignment: .center) {
            // Minimalist Logo / Brand Name
            Text("UMAMI")
                .font(.system(size: 18, weight: .bold, design: .serif))
                .kerning(3) // Letter spacing
                .foregroundColor(AppTheme.Colors.textPrimary)

            Spacer()

            HStack(alignment: .center, spacing: 16) {
                // Language toggle (kept minimal)
                LanguageToggle()

                // Shopping cart - Thin icon
                Button(action: {}) {
                    Image(systemName: "bag")
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(AppTheme.Colors.textPrimary)
                }
            }
        }
        .frame(height: 44) // Fixed height for consistent alignment
        .padding(.horizontal, AppTheme.Spacing.lg)
    }

    // MARK: - Search Bar
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray.opacity(0.5))

            TextField(
                languageManager.currentLanguage == .english ? "Search sake..." : "日本酒を検索...",
                text: $searchText
            )
            .textFieldStyle(PlainTextFieldStyle())
            .font(.system(size: 14))
            .onChange(of: searchText) { oldValue, newValue in
                Task {
                    await performSearch(query: newValue)
                }
            }

            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                    filteredSakes = []
                    isSearching = false
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
            }
        }
        .padding(12)
        // Minimalist: Very subtle gray background, no border
        .background(Color.gray.opacity(0.05))
        .cornerRadius(30) // Pill shape
        .padding(.horizontal, AppTheme.Spacing.lg)
    }

    // MARK: - Best Offers Section
    private var bestOffersSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            sectionHeader(
                title: languageManager.currentLanguage == .english
                    ? "Curated for You" // More premium phrasing
                    : "あなたへの厳選",
                subtitle: nil // Subtitle often clutters
            )

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) { // Increased spacing for 'Ma'
                    ForEach(Array(sakes.prefix(5))) { sake in
                        NavigationLink(destination: SakeDetailView(sake: sake)) {
                            SakeCard(sake: sake)
                                .frame(width: 180)
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
                    ? "Japan's Finest"
                    : "日本の最高傑作",
                subtitle: nil
            )

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(Array(sakes.dropFirst(5).prefix(5))) { sake in
                        NavigationLink(destination: SakeDetailView(sake: sake)) {
                            SakeCard(sake: sake)
                                .frame(width: 180)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal, AppTheme.Spacing.lg)
            }
        }
    }

    // MARK: - Price Drops Section (Renamed to 'Discovery')
    private var priceDropsSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            sectionHeader(
                title: languageManager.currentLanguage == .english
                    ? "Rare Finds"
                    : "希少な発見",
                subtitle: nil
            )

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(Array(sakes.dropFirst(10).prefix(5))) { sake in
                        NavigationLink(destination: SakeDetailView(sake: sake)) {
                            SakeCard(sake: sake)
                                .frame(width: 180)
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
                    ? "Masterpieces"
                    : "名作",
                subtitle: nil
            )

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(Array(sakes.sorted { $0.rating > $1.rating }.prefix(5))) { sake in
                        NavigationLink(destination: SakeDetailView(sake: sake)) {
                            SakeCard(sake: sake)
                                .frame(width: 180)
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
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                // Use Serif font for headings (New York / Times style)
                .font(.system(size: 26, weight: .bold, design: .serif))
                .foregroundColor(AppTheme.Colors.textPrimary)

            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(Color.gray)
                    .lineLimit(1)
            }
        }
        .padding(.horizontal, AppTheme.Spacing.lg)
    }

    // MARK: - Search Results Section
    private var searchResultsSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            Text(languageManager.currentLanguage == .english
                ? "Search Results (\(filteredSakes.count))"
                : "検索結果 (\(filteredSakes.count))")
                .font(AppTheme.Typography.title2)
                .fontWeight(.bold)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .padding(.horizontal, AppTheme.Spacing.lg + AppTheme.Spacing.sm + AppTheme.Spacing.sm)

            if filteredSakes.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    Text(languageManager.currentLanguage == .english
                        ? "No sake found"
                        : "日本酒が見つかりません")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 60)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(filteredSakes) { sake in
                            NavigationLink(destination: SakeDetailView(sake: sake)) {
                                SakeCard(sake: sake)
                                    .frame(width: 180)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)
                }
            }
        }
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

    // MARK: - Search
    private func performSearch(query: String) async {
        guard !query.isEmpty else {
            isSearching = false
            filteredSakes = []
            return
        }

        isSearching = true

        do {
            print("🔍 Searching for: \(query)")
            let response = try await APIService.shared.fetchAllSake(
                search: query,
                sortBy: "rating",
                sortOrder: "desc",
                limit: 50
            )

            filteredSakes = response.data.map { $0.toSake() }
            print("✅ Found \(filteredSakes.count) results")
        } catch {
            print("❌ Search error: \(error)")
            filteredSakes = []
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(LanguageManager())
}

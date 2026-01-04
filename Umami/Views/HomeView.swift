//
//  HomeView.swift
//  Umami
//
//  Created on 2025-01-05.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @State private var searchText = ""
    private let sampleData = SampleData.shared

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: AppTheme.Spacing.lg) {
                    // Header with search and icons
                    headerSection

                    // Search bar
                    searchBar

                    // Best offers section
                    bestOffersSection

                    // Bestsellers section
                    bestsellersSection

                    // Price drops section
                    priceDropsSection

                    // Highly rated section
                    highlyRatedSection

                    Spacer(minLength: 80)
                }
                .padding(.top, AppTheme.Spacing.md)
            }
            .background(AppTheme.Colors.lightBackground)
        }
    }

    // MARK: - Header Section
    private var headerSection: some View {
        HStack {
            Spacer()

            HStack(spacing: AppTheme.Spacing.md) {
                // Language toggle
                LanguageToggle()

                Button(action: {}) {
                    Image(systemName: "cart")
                        .font(.title3)
                        .foregroundColor(AppTheme.Colors.textPrimary)
                }

                Button(action: {}) {
                    Image(systemName: "bell")
                        .font(.title3)
                        .foregroundColor(AppTheme.Colors.textPrimary)
                }
            }
            .padding(.horizontal, AppTheme.Spacing.md)
        }
    }

    // MARK: - Search Bar
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(AppTheme.Colors.textSecondary)

            TextField(LocalizedStrings.get("searchAnySake", language: languageManager.currentLanguage), text: $searchText)
                .font(AppTheme.Typography.body)
        }
        .padding(AppTheme.Spacing.md)
        .background(Color.white)
        .cornerRadius(AppTheme.CornerRadius.md)
        .padding(.horizontal, AppTheme.Spacing.md)
    }

    // MARK: - Best Offers Section
    private var bestOffersSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Best offers for you")
                        .font(AppTheme.Typography.title3)
                        .fontWeight(.bold)

                    Text("Great value. Seamless service. Brilliant sake from Umami and our best merchants.")
                        .font(AppTheme.Typography.caption)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                        .lineLimit(2)
                }

                Spacer()

                Button(action: {}) {
                    Image(systemName: "chevron.right")
                        .font(.body)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
            }
            .padding(.horizontal, AppTheme.Spacing.md)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppTheme.Spacing.md) {
                    ForEach(Array(sampleData.sakes.prefix(4).enumerated()), id: \.element.id) { index, sake in
                        SakeCard(sake: sake, showDiscount: true, discountPercentage: [12, 14, 13, 10][index])
                            .frame(width: 180)
                    }
                }
                .padding(.horizontal, AppTheme.Spacing.md)
            }
        }
    }

    // MARK: - Bestsellers Section
    private var bestsellersSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            HStack {
                Text("Bestsellers in Japan")
                    .font(AppTheme.Typography.title3)
                    .fontWeight(.bold)

                Spacer()

                Button(action: {}) {
                    Image(systemName: "chevron.right")
                        .font(.body)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
            }
            .padding(.horizontal, AppTheme.Spacing.md)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppTheme.Spacing.md) {
                    ForEach(sampleData.sakes) { sake in
                        SakeCard(sake: sake)
                            .frame(width: 180)
                    }
                }
                .padding(.horizontal, AppTheme.Spacing.md)
            }
        }
    }

    // MARK: - Price Drops Section
    private var priceDropsSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            HStack {
                Text("Price drops")
                    .font(AppTheme.Typography.title3)
                    .fontWeight(.bold)

                Spacer()

                Button(action: {}) {
                    Image(systemName: "chevron.right")
                        .font(.body)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
            }
            .padding(.horizontal, AppTheme.Spacing.md)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppTheme.Spacing.md) {
                    ForEach(Array(sampleData.sakes.enumerated()), id: \.element.id) { index, sake in
                        SakeCard(sake: sake, showDiscount: true, discountPercentage: [14, 13, 10, 15, 12, 9][index % 6])
                            .frame(width: 160)
                    }
                }
                .padding(.horizontal, AppTheme.Spacing.md)
            }
        }
    }

    // MARK: - Highly Rated Section
    private var highlyRatedSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            HStack {
                Text("Highly rated")
                    .font(AppTheme.Typography.title3)
                    .fontWeight(.bold)

                Spacer()

                Button(action: {}) {
                    Image(systemName: "chevron.right")
                        .font(.body)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
            }
            .padding(.horizontal, AppTheme.Spacing.md)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppTheme.Spacing.md) {
                    ForEach(sampleData.sakes.sorted(by: { $0.rating > $1.rating })) { sake in
                        SakeCard(sake: sake)
                            .frame(width: 180)
                    }
                }
                .padding(.horizontal, AppTheme.Spacing.md)
            }
        }
    }
}

#Preview {
    HomeView()
}

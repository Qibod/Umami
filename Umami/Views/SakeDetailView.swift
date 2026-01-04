//
//  SakeDetailView.swift
//  Umami
//
//  Created on 2025-01-05.
//

import SwiftUI

struct SakeDetailView: View {
    let sake: Sake
    @Environment(\.dismiss) var dismiss
    @State private var isBookmarked = false

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Hero image
                heroSection

                // Main content
                VStack(alignment: .leading, spacing: AppTheme.Spacing.lg) {
                    // Sake name and basic info
                    nameSection

                    // Rating and reviews
                    ratingSection

                    // Classification badge
                    classificationSection

                    Divider()

                    // Quick stats
                    quickStatsSection

                    Divider()

                    // Flavor profile
                    flavorProfileSection

                    Divider()

                    // Description
                    descriptionSection

                    Divider()

                    // Serving temperature
                    servingTempSection

                    Divider()

                    // Food pairings
                    foodPairingSection

                    Divider()

                    // Reviews section (placeholder)
                    reviewsSection

                    Spacer(minLength: 100)
                }
                .padding(AppTheme.Spacing.md)
            }
        }
        .ignoresSafeArea(edges: .top)
        .overlay(alignment: .topLeading) {
            // Back button
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Color.black.opacity(0.3))
                    .clipShape(Circle())
            }
            .padding(.leading, AppTheme.Spacing.md)
            .padding(.top, 50)
        }
        .overlay(alignment: .bottom) {
            // Bottom action bar
            bottomActionBar
        }
    }

    // MARK: - Hero Section
    private var heroSection: some View {
        ZStack(alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 0)
                .fill(
                    LinearGradient(
                        colors: [AppTheme.Colors.secondary, AppTheme.Colors.primary],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 400)
                .overlay(
                    Image(systemName: "photo")
                        .font(.system(size: 80))
                        .foregroundColor(.white.opacity(0.3))
                )
        }
    }

    // MARK: - Name Section
    private var nameSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(sake.breweryName)
                .font(AppTheme.Typography.callout)
                .foregroundColor(AppTheme.Colors.textSecondary)

            Text(sake.displayName)
                .font(AppTheme.Typography.title)
                .fontWeight(.bold)

            HStack(spacing: 6) {
                Text("🇯🇵")
                Text(sake.prefecture)
                    .font(AppTheme.Typography.subheadline)
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }
        }
    }

    // MARK: - Rating Section
    private var ratingSection: some View {
        HStack(spacing: AppTheme.Spacing.md) {
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .foregroundColor(AppTheme.Colors.starColor)
                Text(String(format: "%.1f", sake.rating))
                    .font(AppTheme.Typography.title2)
                    .fontWeight(.bold)
            }

            Text("(\(sake.reviewCount.formatted()) reviews)")
                .font(AppTheme.Typography.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)
        }
    }

    // MARK: - Classification Section
    private var classificationSection: some View {
        HStack {
            Text(sake.classification.rawValue)
                .font(AppTheme.Typography.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(AppTheme.Colors.primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(AppTheme.Colors.primary.opacity(0.1))
                .cornerRadius(AppTheme.CornerRadius.lg)

            Text(sake.classification.japaneseLabel)
                .font(AppTheme.Typography.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)
        }
    }

    // MARK: - Quick Stats Section
    private var quickStatsSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            Text("Details")
                .font(AppTheme.Typography.headline)
                .fontWeight(.semibold)

            VStack(spacing: AppTheme.Spacing.sm) {
                statRow(label: "Rice Variety", value: sake.riceVariety)
                statRow(label: "Polish Ratio", value: "\(sake.polishRatio)%")
                statRow(label: "Alcohol Content", value: "\(String(format: "%.1f", sake.alcoholContent))%")
                statRow(label: "Price", value: sake.formattedPrice)
                statRow(label: "Availability", value: sake.availability.rawValue)
            }
        }
    }

    // MARK: - Flavor Profile Section
    private var flavorProfileSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            Text("Flavor Profile")
                .font(AppTheme.Typography.headline)
                .fontWeight(.semibold)

            VStack(spacing: AppTheme.Spacing.sm) {
                flavorBar(label: "Sweetness", value: sake.flavorProfile.sweetness, max: 5)
                flavorBar(label: "Acidity", value: sake.flavorProfile.acidity, max: 5)
                flavorBar(label: "Body", value: sake.flavorProfile.body, max: 5)
                flavorBar(label: "Umami", value: sake.flavorProfile.umami, max: 5)
                flavorBar(label: "Aroma", value: sake.flavorProfile.aromaIntensity, max: 5)
            }
        }
    }

    // MARK: - Description Section
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            Text("About")
                .font(AppTheme.Typography.headline)
                .fontWeight(.semibold)

            Text(sake.description)
                .font(AppTheme.Typography.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .lineSpacing(4)
        }
    }

    // MARK: - Serving Temperature Section
    private var servingTempSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
            Text("Serving Temperature")
                .font(AppTheme.Typography.headline)
                .fontWeight(.semibold)

            ForEach(sake.servingTemperature, id: \.self) { temp in
                HStack {
                    Image(systemName: "thermometer.medium")
                        .foregroundColor(AppTheme.Colors.secondary)
                    Text(temp)
                        .font(AppTheme.Typography.body)
                }
            }
        }
    }

    // MARK: - Food Pairing Section
    private var foodPairingSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            Text("Recommended Food Pairings")
                .font(AppTheme.Typography.headline)
                .fontWeight(.semibold)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppTheme.Spacing.md) {
                    ForEach(["🍣 Sushi", "🍤 Tempura", "🐟 Sashimi", "🍢 Yakitori"], id: \.self) { pairing in
                        Text(pairing)
                            .font(AppTheme.Typography.subheadline)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(AppTheme.Colors.cardBackground)
                            .cornerRadius(AppTheme.CornerRadius.lg)
                    }
                }
            }
        }
    }

    // MARK: - Reviews Section
    private var reviewsSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            HStack {
                Text("Reviews")
                    .font(AppTheme.Typography.headline)
                    .fontWeight(.semibold)

                Spacer()

                Button("See all") {
                    // Show all reviews
                }
                .font(AppTheme.Typography.subheadline)
                .foregroundColor(AppTheme.Colors.primary)
            }

            Text("No reviews yet. Be the first to review!")
                .font(AppTheme.Typography.body)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .padding(.vertical, AppTheme.Spacing.lg)
        }
    }

    // MARK: - Bottom Action Bar
    private var bottomActionBar: some View {
        HStack(spacing: AppTheme.Spacing.md) {
            // Price
            VStack(alignment: .leading, spacing: 2) {
                Text("Price")
                    .font(AppTheme.Typography.caption)
                    .foregroundColor(AppTheme.Colors.textSecondary)
                Text(sake.formattedPrice)
                    .font(AppTheme.Typography.title3)
                    .fontWeight(.bold)
                    .foregroundColor(AppTheme.Colors.primary)
            }

            Spacer()

            // Bookmark button
            Button(action: { isBookmarked.toggle() }) {
                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                    .font(.title3)
                    .foregroundColor(isBookmarked ? AppTheme.Colors.primary : AppTheme.Colors.textSecondary)
                    .frame(width: 50, height: 50)
                    .background(AppTheme.Colors.cardBackground)
                    .clipShape(Circle())
            }

            // Add to cart button
            Button(action: {}) {
                HStack {
                    Image(systemName: "cart.fill")
                    Text("Add to Cart")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 14)
                .background(AppTheme.Colors.primary)
                .cornerRadius(AppTheme.CornerRadius.lg)
            }
        }
        .padding(AppTheme.Spacing.md)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -2)
    }

    // MARK: - Helper Views
    private func statRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(AppTheme.Typography.callout)
                .foregroundColor(AppTheme.Colors.textSecondary)

            Spacer()

            Text(value)
                .font(AppTheme.Typography.callout)
                .fontWeight(.semibold)
        }
    }

    private func flavorBar(label: String, value: Int, max: Int) -> some View {
        HStack {
            Text(label)
                .font(AppTheme.Typography.callout)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .frame(width: 100, alignment: .leading)

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(AppTheme.Colors.cardBackground)
                        .frame(height: 8)

                    RoundedRectangle(cornerRadius: 4)
                        .fill(AppTheme.Colors.primary)
                        .frame(width: geometry.size.width * (CGFloat(value) / CGFloat(max)), height: 8)
                }
            }
            .frame(height: 8)

            Text("\(value)/\(max)")
                .font(AppTheme.Typography.caption)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .frame(width: 40, alignment: .trailing)
        }
    }
}

#Preview {
    SakeDetailView(sake: SampleData.shared.sakes[0])
}

//
//  MySakeView.swift
//  Umami
//
//  Created on 2025-01-05.
//

import SwiftUI

struct MySakeView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @State private var showScannedPrompt = true
    private let sampleData = SampleData.shared

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: AppTheme.Spacing.lg) {
                    // Header
                    header

                    // Scanned sake prompt
                    if showScannedPrompt {
                        scannedPromptCard
                    }

                    // Latest section
                    latestSection

                    // Taste profile section
                    tasteProfileSection

                    // Statistics cards
                    statisticsSection

                    // Collections
                    collectionsSection

                    Spacer(minLength: 80)
                }
                .padding(.top, AppTheme.Spacing.md)
            }
            .background(AppTheme.Colors.lightBackground)
            .navigationBarHidden(true)
        }
    }

    // MARK: - Header
    private var header: some View {
        HStack {
            Text(LocalizedStrings.get("mySake", language: languageManager.currentLanguage))
                .font(AppTheme.Typography.title)
                .fontWeight(.bold)

            Spacer()

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

    // MARK: - Scanned Prompt Card
    private var scannedPromptCard: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Tried the sake you scanned?")
                    .font(AppTheme.Typography.callout)
                    .fontWeight(.semibold)

                Text("Rate to keep track of what you liked (or didn't!) and build your personal taste profile")
                    .font(AppTheme.Typography.caption)
                    .foregroundColor(AppTheme.Colors.textSecondary)
                    .lineLimit(2)

                Text("⭐")
                    .font(.title3)
            }

            Spacer()

            Button(action: { showScannedPrompt = false }) {
                Image(systemName: "xmark")
                    .font(.subheadline)
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }
        }
        .padding(AppTheme.Spacing.md)
        .background(AppTheme.Colors.cardBackground)
        .cornerRadius(AppTheme.CornerRadius.md)
        .padding(.horizontal, AppTheme.Spacing.md)
    }

    // MARK: - Latest Section
    private var latestSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            HStack {
                Text("Latest")
                    .font(AppTheme.Typography.title3)
                    .fontWeight(.bold)

                Spacer()

                Button(action: {}) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
            }
            .padding(.horizontal, AppTheme.Spacing.md)

            if let sake = sampleData.sakes.first {
                MySakeCard(sake: sake)
                    .padding(.horizontal, AppTheme.Spacing.md)
            }
        }
    }

    // MARK: - Taste Profile Section
    private var tasteProfileSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            Text("Your taste profile")
                .font(AppTheme.Typography.title2)
                .fontWeight(.bold)
                .padding(.horizontal, AppTheme.Spacing.md)

            Text("Your taste profile keeps track of the sake you interact with on Umami to find perfect recommendations for your palate")
                .font(AppTheme.Typography.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .padding(.horizontal, AppTheme.Spacing.md)

            // Summary section
            VStack(alignment: .leading, spacing: AppTheme.Spacing.sm) {
                HStack {
                    Text("Summary")
                        .font(AppTheme.Typography.headline)
                        .fontWeight(.semibold)

                    Spacer()

                    Button("Edit") {
                        // Edit action
                    }
                    .font(AppTheme.Typography.subheadline)
                    .foregroundColor(AppTheme.Colors.primary)
                }

                Text("Based on your input")
                    .font(AppTheme.Typography.caption)
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }
            .padding(AppTheme.Spacing.md)
            .background(Color.white)
            .cornerRadius(AppTheme.CornerRadius.md)
            .padding(.horizontal, AppTheme.Spacing.md)

            // Taste preference chart (placeholder)
            VStack(spacing: AppTheme.Spacing.md) {
                tastePreferenceRow(label: "Sweetness", value: 3)
                tastePreferenceRow(label: "Acidity", value: 4)
                tastePreferenceRow(label: "Body", value: 3)
                tastePreferenceRow(label: "Umami", value: 5)
            }
            .padding(AppTheme.Spacing.md)
            .background(Color.white)
            .cornerRadius(AppTheme.CornerRadius.md)
            .padding(.horizontal, AppTheme.Spacing.md)
        }
    }

    // MARK: - Statistics Section
    private var statisticsSection: some View {
        HStack(spacing: AppTheme.Spacing.md) {
            StatCard(title: "Sake Tried", value: "124", icon: "wineglass.fill")
            StatCard(title: "Favorites", value: "32", icon: "heart.fill")
            StatCard(title: "Wishlist", value: "18", icon: "bookmark.fill")
        }
        .padding(.horizontal, AppTheme.Spacing.md)
    }

    // MARK: - Collections Section
    private var collectionsSection: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
            Text("Collections")
                .font(AppTheme.Typography.title3)
                .fontWeight(.bold)
                .padding(.horizontal, AppTheme.Spacing.md)

            VStack(spacing: AppTheme.Spacing.sm) {
                CollectionRow(icon: "bookmark.fill", title: "Wishlist", count: 18, color: AppTheme.Colors.secondary)
                CollectionRow(icon: "heart.fill", title: "Favorites", count: 32, color: AppTheme.Colors.error)
                CollectionRow(icon: "archivebox.fill", title: "My Cellar", count: 12, color: AppTheme.Colors.kojiGold)
            }
            .padding(.horizontal, AppTheme.Spacing.md)
        }
    }

    // MARK: - Helper Views
    private func tastePreferenceRow(label: String, value: Int) -> some View {
        HStack {
            Text(label)
                .font(AppTheme.Typography.callout)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .frame(width: 100, alignment: .leading)

            HStack(spacing: 4) {
                ForEach(1...5, id: \.self) { index in
                    Circle()
                        .fill(index <= value ? AppTheme.Colors.primary : AppTheme.Colors.cardBackground)
                        .frame(width: 12, height: 12)
                }
            }

            Spacer()
        }
    }
}

// MARK: - My Sake Card
struct MySakeCard: View {
    let sake: Sake

    var body: some View {
        NavigationLink(destination: SakeDetailView(sake: sake)) {
            cardContent
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var cardContent: some View {
        HStack(spacing: AppTheme.Spacing.md) {
            // Image
            AsyncImage(url: URL(string: sake.imageURL)) { phase in
                switch phase {
                case .empty:
                    RoundedRectangle(cornerRadius: AppTheme.CornerRadius.sm)
                        .fill(AppTheme.Colors.cardBackground)
                        .frame(width: 80, height: 110)
                        .overlay(
                            ProgressView()
                        )
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 110)
                        .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.sm))
                case .failure:
                    RoundedRectangle(cornerRadius: AppTheme.CornerRadius.sm)
                        .fill(AppTheme.Colors.cardBackground)
                        .frame(width: 80, height: 110)
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundColor(AppTheme.Colors.textTertiary)
                        )
                @unknown default:
                    RoundedRectangle(cornerRadius: AppTheme.CornerRadius.sm)
                        .fill(AppTheme.Colors.cardBackground)
                        .frame(width: 80, height: 110)
                }
            }

            // Info
            VStack(alignment: .leading, spacing: 6) {
                Text(sake.breweryName)
                    .font(AppTheme.Typography.caption)
                    .foregroundColor(AppTheme.Colors.textSecondary)

                Text(sake.displayName)
                    .font(AppTheme.Typography.callout)
                    .fontWeight(.semibold)
                    .lineLimit(2)

                HStack(spacing: 4) {
                    Text("🇯🇵")
                        .font(.caption2)
                    Text(sake.prefecture)
                        .font(AppTheme.Typography.caption2)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }

                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(AppTheme.Colors.starColor)
                    Text(String(format: "%.1f", sake.rating))
                        .font(AppTheme.Typography.caption)
                        .fontWeight(.semibold)
                    Text("(\(sake.reviewCount.formatted()))")
                        .font(AppTheme.Typography.caption2)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }

                HStack(spacing: 4) {
                    Image(systemName: "tag.fill")
                        .font(.caption2)
                    Text(sake.formattedPrice)
                        .font(AppTheme.Typography.caption)
                        .fontWeight(.semibold)
                }
            }

            Spacer()

            // Actions
            VStack(spacing: AppTheme.Spacing.md) {
                Button(action: {}) {
                    Text("Rate")
                        .font(AppTheme.Typography.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(AppTheme.Colors.primary)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.lg)
                                .stroke(AppTheme.Colors.primary, lineWidth: 1.5)
                        )
                }

                HStack(spacing: 16) {
                    Button(action: {}) {
                        Image(systemName: "camera.fill")
                            .foregroundColor(AppTheme.Colors.textSecondary)
                    }

                    Button(action: {}) {
                        Image(systemName: "bookmark")
                            .foregroundColor(AppTheme.Colors.textSecondary)
                    }

                    Button(action: {}) {
                        Image(systemName: "ellipsis")
                            .foregroundColor(AppTheme.Colors.textSecondary)
                    }
                }
            }
        }
        .padding(AppTheme.Spacing.md)
        .background(Color.white)
        .cornerRadius(AppTheme.CornerRadius.md)
        .shadow(color: AppTheme.Shadows.card.color, radius: AppTheme.Shadows.card.radius, x: AppTheme.Shadows.card.x, y: AppTheme.Shadows.card.y)
    }
}

// MARK: - Stat Card
struct StatCard: View {
    let title: String
    let value: String
    let icon: String

    var body: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(AppTheme.Colors.primary)

            Text(value)
                .font(AppTheme.Typography.title2)
                .fontWeight(.bold)

            Text(title)
                .font(AppTheme.Typography.caption)
                .foregroundColor(AppTheme.Colors.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(AppTheme.Spacing.md)
        .background(Color.white)
        .cornerRadius(AppTheme.CornerRadius.md)
        .shadow(color: AppTheme.Shadows.card.color, radius: AppTheme.Shadows.card.radius, x: AppTheme.Shadows.card.x, y: AppTheme.Shadows.card.y)
    }
}

// MARK: - Collection Row
struct CollectionRow: View {
    let icon: String
    let title: String
    let count: Int
    let color: Color

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 30)

            Text(title)
                .font(AppTheme.Typography.callout)

            Spacer()

            Text("\(count)")
                .font(AppTheme.Typography.callout)
                .foregroundColor(AppTheme.Colors.textSecondary)

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(AppTheme.Colors.textSecondary)
        }
        .padding(AppTheme.Spacing.md)
        .background(Color.white)
        .cornerRadius(AppTheme.CornerRadius.md)
    }
}

#Preview {
    MySakeView()
        .environmentObject(LanguageManager())
}

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
            GeometryReader { geometry in
                ZStack(alignment: .top) {
                    // Scrollable content
                    ScrollView {
                        VStack(spacing: AppTheme.Spacing.lg) {
                            // Spacer for fixed header
                            Spacer()
                                .frame(height: 60)

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
                        .padding(.top, geometry.safeAreaInsets.top + 8)
                    }

                    // Fixed header section (stays at top)
                    VStack(spacing: 0) {
                        header
                            .padding(.vertical, 8)
                    }
                    .background(AppTheme.Colors.lightBackground)
                }
            }
            .background(AppTheme.Colors.lightBackground.ignoresSafeArea(edges: .top))
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

            // Taste preference chart with sake bottle visualization
            HStack(alignment: .center, spacing: AppTheme.Spacing.lg) {
                // Sake bottle and cup visualization
                HStack(alignment: .bottom, spacing: 12) {
                    sakeBottleVisualization(
                        sweetness: 0.10,
                        acidity: 0.30,
                        body: 0.25,
                        umami: 0.35
                    )
                    .frame(width: 80)

                    // Sake cup (ochoko)
                    sakeCupVisualization()
                        .frame(width: 40, height: 37.5)
                        .offset(y: -5)
                }
                .frame(width: 140)

                // Taste attributes
                VStack(spacing: AppTheme.Spacing.md) {
                    tasteAttributeRow(label: "Sweetness", color: Color(red: 0.98, green: 0.89, blue: 0.71), percentage: 0.10)
                    tasteAttributeRow(label: "Acidity", color: Color(red: 0.89, green: 0.76, blue: 0.76), percentage: 0.30)
                    tasteAttributeRow(label: "Body", color: Color(red: 0.82, green: 0.71, blue: 0.55), percentage: 0.25)
                    tasteAttributeRow(label: "Umami", color: Color(red: 0.45, green: 0.26, blue: 0.26), percentage: 0.35)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(AppTheme.Spacing.md)
            .background(Color(red: 0.98, green: 0.97, blue: 0.95))
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
    private func sakeBottleVisualization(sweetness: Double, acidity: Double, body: Double, umami: Double) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                // Bottle outline - traditional sake bottle shape
                SakeBottleShape()
                    .stroke(Color(red: 0.2, green: 0.2, blue: 0.2), lineWidth: 2.5)

                // Filled sections (from bottom to top: Umami, Body, Acidity, Sweetness)
                VStack(spacing: 0) {
                    Spacer()

                    // Umami (bottom layer - darker brown)
                    if umami > 0 {
                        Color(red: 0.45, green: 0.26, blue: 0.26)
                            .frame(height: geometry.size.height * 0.65 * umami)
                    }

                    // Body (warm tan/brown)
                    if body > 0 {
                        Color(red: 0.82, green: 0.71, blue: 0.55)
                            .frame(height: geometry.size.height * 0.65 * body)
                    }

                    // Acidity (soft dusty rose)
                    if acidity > 0 {
                        Color(red: 0.89, green: 0.76, blue: 0.76)
                            .frame(height: geometry.size.height * 0.65 * acidity)
                    }

                    // Sweetness (top layer - light cream)
                    if sweetness > 0 {
                        Color(red: 0.98, green: 0.89, blue: 0.71)
                            .frame(height: geometry.size.height * 0.65 * sweetness)
                    }
                }
                .clipShape(SakeBottleShape())
            }
        }
        .aspectRatio(0.45, contentMode: .fit)
    }

    private func sakeCupVisualization() -> some View {
        GeometryReader { geometry in
            ZStack {
                // Cup outline
                SakeCupShape()
                    .stroke(Color(red: 0.2, green: 0.2, blue: 0.2), lineWidth: 2)

                // White interior/ceramic look
                SakeCupShape()
                    .fill(Color(red: 0.95, green: 0.94, blue: 0.92))
            }
        }
    }

    private func tasteAttributeRow(label: String, color: Color, percentage: Double) -> some View {
        HStack(spacing: 8) {
            Circle()
                .fill(color)
                .frame(width: 16, height: 16)

            Text(label)
                .font(AppTheme.Typography.callout)
                .foregroundColor(AppTheme.Colors.textPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
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

// MARK: - Sake Bottle Shape
struct SakeBottleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.width
        let height = rect.height

        // Start from bottom center-left
        path.move(to: CGPoint(x: width * 0.3, y: height))

        // Left side of body - gently curves outward
        path.addQuadCurve(
            to: CGPoint(x: width * 0.15, y: height * 0.5),
            control: CGPoint(x: width * 0.15, y: height * 0.8)
        )

        // Curve inward toward neck
        path.addQuadCurve(
            to: CGPoint(x: width * 0.35, y: height * 0.185),
            control: CGPoint(x: width * 0.2, y: height * 0.35)
        )

        // Left side of neck (straight narrow part)
        path.addLine(to: CGPoint(x: width * 0.38, y: height * 0.12))

        // Flare out at the top (left side) - even wider opening, from 0.1 instead of 0.2 (25% wider)
        path.addQuadCurve(
            to: CGPoint(x: width * 0.1, y: height * 0.02),
            control: CGPoint(x: width * 0.22, y: height * 0.05)
        )

        // Top opening - even wider, from 0.1 to 0.9 instead of 0.2 to 0.8 (25% wider)
        path.addLine(to: CGPoint(x: width * 0.9, y: height * 0.02))

        // Flare out at the top (right side) - even wider opening, to 0.9 instead of 0.8
        path.addQuadCurve(
            to: CGPoint(x: width * 0.62, y: height * 0.12),
            control: CGPoint(x: width * 0.78, y: height * 0.05)
        )

        // Right side of neck (straight narrow part)
        path.addLine(to: CGPoint(x: width * 0.65, y: height * 0.185))

        // Curve outward toward body
        path.addQuadCurve(
            to: CGPoint(x: width * 0.85, y: height * 0.5),
            control: CGPoint(x: width * 0.8, y: height * 0.35)
        )

        // Right side of body - gently curves inward
        path.addQuadCurve(
            to: CGPoint(x: width * 0.7, y: height),
            control: CGPoint(x: width * 0.85, y: height * 0.8)
        )

        // Bottom
        path.closeSubpath()

        return path
    }
}

// MARK: - Sake Cup Shape (Ochoko)
struct SakeCupShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let width = rect.width
        let height = rect.height

        // Start from bottom left (flat-ish base area)
        path.move(to: CGPoint(x: width * 0.25, y: height))

        // Gentle curve at bottom left
        path.addQuadCurve(
            to: CGPoint(x: width * 0.15, y: height * 0.85),
            control: CGPoint(x: width * 0.18, y: height * 0.95)
        )

        // Left side curves outward to widest point
        path.addQuadCurve(
            to: CGPoint(x: width * 0.0, y: height * 0.25),
            control: CGPoint(x: width * 0.0, y: height * 0.55)
        )

        // Upper left curves to rim
        path.addQuadCurve(
            to: CGPoint(x: width * 0.05, y: height * 0.0),
            control: CGPoint(x: width * 0.0, y: height * 0.1)
        )

        // Top opening
        path.addLine(to: CGPoint(x: width * 0.95, y: height * 0.0))

        // Upper right curves from rim
        path.addQuadCurve(
            to: CGPoint(x: width * 1.0, y: height * 0.25),
            control: CGPoint(x: width * 1.0, y: height * 0.1)
        )

        // Right side curves outward then down to base
        path.addQuadCurve(
            to: CGPoint(x: width * 0.85, y: height * 0.85),
            control: CGPoint(x: width * 1.0, y: height * 0.55)
        )

        // Gentle curve at bottom right
        path.addQuadCurve(
            to: CGPoint(x: width * 0.75, y: height),
            control: CGPoint(x: width * 0.82, y: height * 0.95)
        )

        // Bottom base
        path.addLine(to: CGPoint(x: width * 0.25, y: height))

        // Close the path
        path.closeSubpath()

        return path
    }
}

#Preview {
    MySakeView()
        .environmentObject(LanguageManager())
}

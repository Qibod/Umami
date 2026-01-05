//
//  SakeCard.swift
//  Umami
//
//  Created on 2025-01-05.
//

import SwiftUI

struct SakeCard: View {
    let sake: Sake
    var showDiscount: Bool = false
    var discountPercentage: Int = 0

    var body: some View {
        NavigationLink(destination: SakeDetailView(sake: sake)) {
            cardContent
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var cardContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Image with discount badge
            ZStack(alignment: .topLeading) {
                // Async image loading from URL
                AsyncImage(url: URL(string: sake.imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        RoundedRectangle(cornerRadius: AppTheme.CornerRadius.md)
                            .fill(AppTheme.Colors.cardBackground)
                            .aspectRatio(0.75, contentMode: .fit)
                            .overlay(
                                ProgressView()
                            )
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity)
                            .aspectRatio(0.75, contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.md))
                    case .failure:
                        RoundedRectangle(cornerRadius: AppTheme.CornerRadius.md)
                            .fill(AppTheme.Colors.cardBackground)
                            .aspectRatio(0.75, contentMode: .fit)
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                    .foregroundColor(AppTheme.Colors.textTertiary)
                            )
                    @unknown default:
                        RoundedRectangle(cornerRadius: AppTheme.CornerRadius.md)
                            .fill(AppTheme.Colors.cardBackground)
                            .aspectRatio(0.75, contentMode: .fit)
                    }
                }

                if showDiscount && discountPercentage > 0 {
                    Text("-\(discountPercentage)%")
                        .font(AppTheme.Typography.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(AppTheme.Colors.error)
                        .cornerRadius(AppTheme.CornerRadius.sm)
                        .padding(8)
                }
            }

            // Sake info
            VStack(alignment: .leading, spacing: 4) {
                // Brewery name
                Text(sake.breweryName)
                    .font(AppTheme.Typography.caption)
                    .foregroundColor(AppTheme.Colors.textSecondary)
                    .lineLimit(1)

                // Sake name
                Text(sake.displayName)
                    .font(AppTheme.Typography.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(AppTheme.Colors.textPrimary)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)

                // Prefecture with flag
                HStack(spacing: 4) {
                    Text("🇯🇵")
                        .font(.caption)
                    Text(sake.prefecture)
                        .font(AppTheme.Typography.caption2)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }

                // Rating
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(AppTheme.Colors.starColor)
                    Text(String(format: "%.1f", sake.rating))
                        .font(AppTheme.Typography.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(AppTheme.Colors.textPrimary)
                    Text("(\(sake.reviewCount.formatted()))")
                        .font(AppTheme.Typography.caption2)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
            }

            Spacer(minLength: 0)

            // Price and action
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(sake.formattedPrice)
                        .font(AppTheme.Typography.callout)
                        .fontWeight(.bold)
                        .foregroundColor(AppTheme.Colors.primary)

                    if showDiscount && discountPercentage > 0 {
                        Text("$\(String(format: "%.2f", sake.price * 1.15))")
                            .font(AppTheme.Typography.caption2)
                            .foregroundColor(AppTheme.Colors.textTertiary)
                            .strikethrough()
                    }
                }

                Spacer()

                // Bookmark button
                Button(action: {}) {
                    Image(systemName: "bookmark")
                        .font(.body)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }

                // Add to cart button
                Button(action: {}) {
                    Image(systemName: "cart.fill")
                        .font(.body)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(AppTheme.Colors.primary)
                        .clipShape(Circle())
                }
            }
        }
        .padding(AppTheme.Spacing.sm)
        .background(Color.white)
        .cornerRadius(AppTheme.CornerRadius.md)
        .shadow(color: AppTheme.Shadows.card.color, radius: AppTheme.Shadows.card.radius, x: AppTheme.Shadows.card.x, y: AppTheme.Shadows.card.y)
    }
}

// List-style sake card (for shop page)
struct SakeListCard: View {
    let sake: Sake
    var showDiscount: Bool = false
    var discountPercentage: Int = 0

    var body: some View {
        NavigationLink(destination: SakeDetailView(sake: sake)) {
            cardContent
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var cardContent: some View {
        HStack(spacing: AppTheme.Spacing.md) {
            // Image with discount badge
            ZStack(alignment: .topLeading) {
                // Async image loading from URL
                AsyncImage(url: URL(string: sake.imageUrl)) { phase in
                    switch phase {
                    case .empty:
                        RoundedRectangle(cornerRadius: AppTheme.CornerRadius.md)
                            .fill(AppTheme.Colors.cardBackground)
                            .frame(width: 100, height: 140)
                            .overlay(
                                ProgressView()
                            )
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 140)
                            .clipShape(RoundedRectangle(cornerRadius: AppTheme.CornerRadius.md))
                    case .failure:
                        RoundedRectangle(cornerRadius: AppTheme.CornerRadius.md)
                            .fill(AppTheme.Colors.cardBackground)
                            .frame(width: 100, height: 140)
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.title)
                                    .foregroundColor(AppTheme.Colors.textTertiary)
                            )
                    @unknown default:
                        RoundedRectangle(cornerRadius: AppTheme.CornerRadius.md)
                            .fill(AppTheme.Colors.cardBackground)
                            .frame(width: 100, height: 140)
                    }
                }

                if showDiscount && discountPercentage > 0 {
                    Text("-\(discountPercentage)%")
                        .font(AppTheme.Typography.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .background(AppTheme.Colors.error)
                        .cornerRadius(AppTheme.CornerRadius.sm)
                        .padding(6)
                }
            }

            // Sake info
            VStack(alignment: .leading, spacing: 6) {
                // Brewery name
                Text(sake.breweryName)
                    .font(AppTheme.Typography.caption)
                    .foregroundColor(AppTheme.Colors.textSecondary)

                // Sake name
                Text(sake.displayName)
                    .font(AppTheme.Typography.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(AppTheme.Colors.textPrimary)
                    .lineLimit(2)

                // Prefecture
                HStack(spacing: 4) {
                    Text("🇯🇵")
                        .font(.caption2)
                    Text(sake.prefecture)
                        .font(AppTheme.Typography.caption2)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }

                // Rating
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

                Spacer()

                // Price
                HStack(spacing: 8) {
                    Text(sake.formattedPrice)
                        .font(AppTheme.Typography.callout)
                        .fontWeight(.bold)
                        .foregroundColor(AppTheme.Colors.primary)

                    if showDiscount && discountPercentage > 0 {
                        Text("$\(String(format: "%.2f", sake.price * 1.15))")
                            .font(AppTheme.Typography.caption2)
                            .foregroundColor(AppTheme.Colors.textTertiary)
                            .strikethrough()
                    }
                }
            }

            Spacer()

            // Actions
            VStack(spacing: AppTheme.Spacing.md) {
                Button(action: {}) {
                    Image(systemName: "bookmark")
                        .font(.body)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }

                Spacer()

                Button(action: {}) {
                    Image(systemName: "cart.fill")
                        .font(.body)
                        .foregroundColor(.white)
                        .padding(12)
                        .background(AppTheme.Colors.primary)
                        .clipShape(Circle())
                }
            }
        }
        .padding(AppTheme.Spacing.md)
        .background(Color.white)
        .cornerRadius(AppTheme.CornerRadius.md)
        .shadow(color: AppTheme.Shadows.card.color, radius: AppTheme.Shadows.card.radius, x: AppTheme.Shadows.card.x, y: AppTheme.Shadows.card.y)
    }
}

#Preview {
    VStack(spacing: 20) {
        SakeCard(sake: SampleData.shared.sakes[0], showDiscount: true, discountPercentage: 13)
            .frame(width: 180)

        SakeListCard(sake: SampleData.shared.sakes[1], showDiscount: true, discountPercentage: 10)
    }
    .padding()
}

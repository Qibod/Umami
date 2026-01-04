//
//  MoreView.swift
//  Umami
//
//  Created on 2025-01-05.
//

import SwiftUI

struct MoreView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    // Profile header
                    profileHeader

                    // Menu sections
                    VStack(spacing: AppTheme.Spacing.md) {
                        menuItem(icon: "building.2.fill", title: "Explore Sake Breweries", destination: BreweriesView())
                        menuItem(icon: "fork.knife", title: "Food & Sake", destination: FoodPairingView())
                        menuItem(icon: "person.2.fill", title: "Friends Feed")
                        menuItem(icon: "map.fill", title: "Sake Adventures")

                        Divider()
                            .padding(.vertical, AppTheme.Spacing.sm)

                        menuItem(icon: "crown.fill", title: "My Premium Benefits")
                        menuItem(icon: "questionmark.circle.fill", title: "Help & Support")
                        menuItem(icon: "gearshape.fill", title: "Settings")
                    }
                    .padding(AppTheme.Spacing.md)

                    Spacer(minLength: 80)
                }
            }
            .background(AppTheme.Colors.lightBackground)
            .navigationBarHidden(true)
        }
    }

    // MARK: - Profile Header
    private var profileHeader: some View {
        VStack(spacing: AppTheme.Spacing.md) {
            HStack {
                Spacer()

                Button(action: {}) {
                    Image(systemName: "gearshape")
                        .font(.title3)
                        .foregroundColor(AppTheme.Colors.textPrimary)
                }
            }
            .padding(.horizontal, AppTheme.Spacing.md)

            // Profile image and info
            VStack(spacing: AppTheme.Spacing.sm) {
                ZStack {
                    Circle()
                        .fill(AppTheme.Colors.cardBackground)
                        .frame(width: 80, height: 80)

                    Image(systemName: "person.fill")
                        .font(.largeTitle)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }

                Text("Sake Enthusiast")
                    .font(AppTheme.Typography.headline)
                    .fontWeight(.semibold)

                HStack(spacing: 4) {
                    Text("Premium member")
                        .font(AppTheme.Typography.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(Color.black)
                        .cornerRadius(AppTheme.CornerRadius.sm)
                }
            }

            // Followers/Following
            HStack(spacing: AppTheme.Spacing.xl) {
                VStack(spacing: 4) {
                    Text("0")
                        .font(AppTheme.Typography.headline)
                        .fontWeight(.bold)
                    Text("followers")
                        .font(AppTheme.Typography.caption)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }

                Rectangle()
                    .fill(AppTheme.Colors.cardBackground)
                    .frame(width: 1, height: 30)

                VStack(spacing: 4) {
                    Text("0")
                        .font(AppTheme.Typography.headline)
                        .fontWeight(.bold)
                    Text("following")
                        .font(AppTheme.Typography.caption)
                        .foregroundColor(AppTheme.Colors.textSecondary)
                }
            }
        }
        .padding(.vertical, AppTheme.Spacing.lg)
        .background(Color.white)
    }

    // MARK: - Menu Item
    @ViewBuilder
    private func menuItem<Destination: View>(icon: String, title: String, destination: Destination) -> some View {
        NavigationLink(destination: destination) {
            HStack(spacing: AppTheme.Spacing.md) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(AppTheme.Colors.textPrimary)
                    .frame(width: 30)

                Text(title)
                    .font(AppTheme.Typography.callout)
                    .foregroundColor(AppTheme.Colors.textPrimary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }
            .padding(AppTheme.Spacing.md)
            .background(Color.white)
            .cornerRadius(AppTheme.CornerRadius.md)
        }
    }

    @ViewBuilder
    private func menuItem(icon: String, title: String) -> some View {
        Button(action: {}) {
            HStack(spacing: AppTheme.Spacing.md) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(AppTheme.Colors.textPrimary)
                    .frame(width: 30)

                Text(title)
                    .font(AppTheme.Typography.callout)
                    .foregroundColor(AppTheme.Colors.textPrimary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(AppTheme.Colors.textSecondary)
            }
            .padding(AppTheme.Spacing.md)
            .background(Color.white)
            .cornerRadius(AppTheme.CornerRadius.md)
        }
    }
}

// MARK: - Breweries View
struct BreweriesView: View {
    @State private var searchText = ""
    private let sampleData = SampleData.shared

    var body: some View {
        ScrollView {
            VStack(spacing: AppTheme.Spacing.md) {
                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(AppTheme.Colors.textSecondary)

                    TextField("Search breweries", text: $searchText)
                        .font(AppTheme.Typography.body)

                    Spacer()

                    Button(action: {}) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .foregroundColor(AppTheme.Colors.textPrimary)
                    }
                }
                .padding(AppTheme.Spacing.md)
                .background(Color.white)
                .cornerRadius(AppTheme.CornerRadius.md)
                .padding(.horizontal, AppTheme.Spacing.md)
                .padding(.top, AppTheme.Spacing.md)

                // Breweries list
                ForEach(sampleData.breweries) { brewery in
                    BreweryCard(brewery: brewery)
                        .padding(.horizontal, AppTheme.Spacing.md)
                }

                Spacer(minLength: 80)
            }
        }
        .background(AppTheme.Colors.lightBackground)
        .navigationTitle("Sake Breweries")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Brewery Card
struct BreweryCard: View {
    let brewery: Brewery

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Hero image
            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.md)
                .fill(
                    LinearGradient(
                        colors: [AppTheme.Colors.primary.opacity(0.8), AppTheme.Colors.secondary.opacity(0.8)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 180)
                .overlay(
                    VStack {
                        Spacer()

                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(brewery.displayName)
                                    .font(AppTheme.Typography.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)

                                HStack(spacing: 4) {
                                    Text("🇯🇵")
                                    Text("\(brewery.prefecture), \(brewery.region)")
                                        .font(AppTheme.Typography.subheadline)
                                        .foregroundColor(.white.opacity(0.9))
                                }

                                Text("\(brewery.sakeCount) sake · \(brewery.totalRatings.formatted()) ratings total")
                                    .font(AppTheme.Typography.caption)
                                    .foregroundColor(.white.opacity(0.8))
                            }

                            Spacer()
                        }
                        .padding(AppTheme.Spacing.md)
                    }
                )

            // Description
            Text(brewery.description)
                .font(AppTheme.Typography.subheadline)
                .foregroundColor(AppTheme.Colors.textSecondary)
                .lineLimit(3)
                .padding(AppTheme.Spacing.md)
        }
        .background(Color.white)
        .cornerRadius(AppTheme.CornerRadius.md)
        .shadow(color: AppTheme.Shadows.card.color, radius: AppTheme.Shadows.card.radius, x: AppTheme.Shadows.card.x, y: AppTheme.Shadows.card.y)
    }
}

// MARK: - Food Pairing View
struct FoodPairingView: View {
    @State private var searchText = ""
    private let sampleData = SampleData.shared

    var body: some View {
        ScrollView {
            VStack(spacing: AppTheme.Spacing.lg) {
                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(AppTheme.Colors.textSecondary)

                    TextField("Search by dish", text: $searchText)
                        .font(AppTheme.Typography.body)
                }
                .padding(AppTheme.Spacing.md)
                .background(Color.white)
                .cornerRadius(AppTheme.CornerRadius.md)
                .padding(.horizontal, AppTheme.Spacing.md)
                .padding(.top, AppTheme.Spacing.md)

                // Recent section
                VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                    Text("Recent")
                        .font(AppTheme.Typography.headline)
                        .fontWeight(.semibold)
                        .padding(.horizontal, AppTheme.Spacing.md)

                    if let firstPairing = sampleData.foodPairings.first {
                        FoodPairingRow(pairing: firstPairing)
                            .padding(.horizontal, AppTheme.Spacing.md)
                    }
                }

                // Categories by letter
                ForEach(["J", "S", "T", "R"], id: \.self) { letter in
                    VStack(alignment: .leading, spacing: AppTheme.Spacing.md) {
                        Text(letter)
                            .font(AppTheme.Typography.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal, AppTheme.Spacing.md)

                        ForEach(sampleData.foodPairings.filter { $0.dishName.hasPrefix(letter) }) { pairing in
                            FoodPairingRow(pairing: pairing)
                                .padding(.horizontal, AppTheme.Spacing.md)
                        }
                    }
                }

                Spacer(minLength: 80)
            }
        }
        .background(AppTheme.Colors.lightBackground)
        .navigationTitle("Food pairing search")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Food Pairing Row
struct FoodPairingRow: View {
    let pairing: FoodPairing

    var body: some View {
        HStack {
            Text(pairing.displayName)
                .font(AppTheme.Typography.callout)
                .foregroundColor(AppTheme.Colors.textPrimary)

            Spacer()

            // Image placeholder
            RoundedRectangle(cornerRadius: AppTheme.CornerRadius.sm)
                .fill(AppTheme.Colors.cardBackground)
                .frame(width: 60, height: 60)
                .overlay(
                    Text(pairing.category.icon)
                        .font(.title)
                )
        }
        .padding(AppTheme.Spacing.md)
        .background(Color.white)
        .cornerRadius(AppTheme.CornerRadius.md)
    }
}

#Preview {
    MoreView()
}

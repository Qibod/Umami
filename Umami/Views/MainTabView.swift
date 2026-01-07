//
//  MainTabView.swift
//  Umami
//
//  Created on 2025-01-05.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var languageManager: LanguageManager
    @State private var selectedTab = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView()
                    .environmentObject(languageManager)
                    .tag(0)

                ShopView()
                    .environmentObject(languageManager)
                    .tag(1)

                CameraView()
                    .tag(2)

                MySakeView()
                    .environmentObject(languageManager)
                    .tag(3)

                MoreView()
                    .environmentObject(languageManager)
                    .tag(4)
            }

            // Custom Tab Bar
            CustomTabBar(selectedTab: $selectedTab)
                .environmentObject(languageManager)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct CustomTabBar: View {
    @EnvironmentObject var languageManager: LanguageManager
    @Binding var selectedTab: Int

    var body: some View {
        ZStack {
            // Background - Minimalist white with subtle shadow (Glassmorphism effect)
            HStack(spacing: 0) {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .frame(height: 70)
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: -5)
            }

            HStack(spacing: 0) {
                // Home
                TabBarButton(
                    icon: "house", // "house" instead of "house.fill" for lighter look
                    selectedIcon: "house.fill",
                    title: LocalizedStrings.get("home", language: languageManager.currentLanguage),
                    isSelected: selectedTab == 0,
                    action: { selectedTab = 0 }
                )

                // Shop
                TabBarButton(
                    icon: "square.grid.2x2",
                    selectedIcon: "square.grid.2x2.fill",
                    title: LocalizedStrings.get("shop", language: languageManager.currentLanguage),
                    isSelected: selectedTab == 1,
                    action: { selectedTab = 1 }
                )

                // Camera - Floating Minimalist Red Circle (Sun of Japan)
                Button(action: { selectedTab = 2 }) {
                    ZStack {
                        // White halo for separation
                        Circle()
                            .fill(Color.white)
                            .frame(width: 70, height: 70)
                            // Subtle shadow
                            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)

                        // The Red Sun
                        Circle()
                            .fill(AppTheme.Colors.primary) // Umami Red
                            .frame(width: 58, height: 58)

                        Image(systemName: "camera")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                }
                .offset(y: -25) // Floating higher

                // My Sake
                TabBarButton(
                    icon: "wineglass",
                    selectedIcon: "wineglass.fill",
                    title: LocalizedStrings.get("mySake", language: languageManager.currentLanguage),
                    isSelected: selectedTab == 3,
                    action: { selectedTab = 3 }
                )

                // More
                TabBarButton(
                    icon: "ellipsis",
                    selectedIcon: "ellipsis",
                    title: LocalizedStrings.get("more", language: languageManager.currentLanguage),
                    isSelected: selectedTab == 4,
                    action: { selectedTab = 4 }
                )
            }
            .padding(.bottom, 8)
        }
        .frame(height: 70)
    }
}

struct TabBarButton: View {
    let icon: String
    let selectedIcon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: isSelected ? selectedIcon : icon)
                    .font(.system(size: 22)) // Slightly larger, thinner
                    .fontWeight(isSelected ? .semibold : .light)
                
                Text(title)
                    .font(.system(size: 10, weight: isSelected ? .medium : .regular))
            }
            // Minimalist colors: Dark Grey vs Umami Red
            .foregroundColor(isSelected ? AppTheme.Colors.primary : Color.gray.opacity(0.8))
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(LanguageManager())
}

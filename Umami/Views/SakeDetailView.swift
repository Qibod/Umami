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
    @EnvironmentObject var languageManager: LanguageManager
    @State private var isBookmarked = false
    @State private var bottleScale: CGFloat = 0.8
    @State private var bottleOpacity: Double = 0.0
    @State private var ratingScale: CGFloat = 0.8
    @State private var ratingOpacity: Double = 0.0

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // LAYER 1: SCENIC BACKGROUND (Fixed)
                AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1468581264429-2548ef9eb732?q=80&w=3270&auto=format&fit=crop")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.35) // Reduced by 10% (from 0.45 to 0.35)
                            .clipShape(RibbonCurve()) // Custom wave shape
                    } else {
                        Rectangle()
                            .fill(Color.blue.opacity(0.2))
                            .frame(height: geometry.size.height * 0.35)
                            .clipShape(RibbonCurve())
                    }
                }
                .ignoresSafeArea()

                // LAYER 2: FIXED OBJECTS (Bottle Left, Rating Right)
                HStack(alignment: .bottom, spacing: 0) {
                    // LEFT COLUMN: BOTTLE & BUTTONS
                    VStack(spacing: 0) {
                        Spacer()

                        SakeImage(url: "hakkaisan_sparkling_transparent")
                            .frame(width: 375, height: 600)
                            .shadow(color: Color.black.opacity(0.35), radius: 25, x: 5, y: 10)
                            .offset(x: -20, y: -220) // Moved UP by 220 pixels
                            .scaleEffect(bottleScale)
                            .opacity(bottleOpacity)

                        Spacer()
                    }
                    .frame(width: geometry.size.width * 0.65)
                    // Removed bottom padding since we now align from top via top spacer
                    
                    // RIGHT COLUMN: RATING BADGE
                    VStack {
                        Spacer()
                            .frame(height: geometry.size.height * 0.20) // Moved up 15% higher
                        
                        // Rating Circle
                        VStack(spacing: 2) {
                            Text(String(format: "%.1f", sake.rating))
                                .font(.system(size: 24, weight: .black, design: .serif))
                                .foregroundColor(AppTheme.Colors.primary)
                            
                            HStack(spacing: 1) {
                                ForEach(0..<5) { _ in
                                    Image(systemName: "star.fill")
                                        .font(.system(size: 8))
                                        .foregroundColor(AppTheme.Colors.starColor)
                                }
                            }
                            
                            Text("\(sake.reviewCount) reviews")
                                .font(.system(size: 8))
                                .foregroundColor(.gray)
                                .padding(.top, 4)
                        }
                        .frame(width: 90, height: 90)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 5)
                        .scaleEffect(ratingScale)
                        .opacity(ratingOpacity)
                        
                        Spacer()
                    }
                    .frame(width: geometry.size.width * 0.35)
                    .frame(maxHeight: .infinity, alignment: .top)
                }
                .zIndex(1)

                // LAYER 3: SCROLLABLE SHEET (Starts BELOW Bottle via Spacer)
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        // Transparent Spacer - Pushes sheet down to reveal Layer 2 (Bottle)
                        // Positioned below the bottle
                        Color.clear
                            .frame(height: geometry.size.height * 0.45)
                        
                        // The White Sheet with translucent top
                        VStack(alignment: .leading, spacing: 24) {

                            // ACTION BUTTONS at top
                            HStack(spacing: 12) {
                                Button(action: {}) {
                                    Label("Rate", systemImage: "star")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Color.white)
                                        .clipShape(Capsule())
                                        .overlay(Capsule().stroke(Color.gray.opacity(0.3), lineWidth: 1))
                                        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                                }

                                Button(action: {}) {
                                    Label("Actions", systemImage: "list.bullet")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Color.white)
                                        .clipShape(Capsule())
                                        .overlay(Capsule().stroke(Color.gray.opacity(0.3), lineWidth: 1))
                                        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                                }
                                Spacer()
                            }

                            // SAKE NAME
                            
                            // Header Info
                            VStack(alignment: .leading, spacing: 8) {
                                Text(languageManager.currentLanguage == .english ? sake.nameEnglish : sake.nameJapanese)
                                    .font(.system(size: 22, weight: .bold)) // Sans-serif, reduced size (~Location + 40%)
                                    .foregroundColor(AppTheme.Colors.textPrimary)
                                    .fixedSize(horizontal: false, vertical: true)
                                
                                HStack(spacing: 6) {
                                    Image(systemName: "mappin.and.ellipse")
                                        .foregroundColor(AppTheme.Colors.primary)
                                    Text("\(languageManager.currentLanguage == .english ? sake.prefecture : sake.prefectureJapanese), \(languageManager.currentLanguage == .english ? "Japan" : "日本")")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            Divider()
                            
                            // Description
                            VStack(alignment: .leading, spacing: 12) {
                                Text("The Story")
                                    .font(.system(size: 18, weight: .semibold, design: .serif))
                                
                                Text(sake.description)
                                    .font(.system(size: 16))
                                    .lineSpacing(6)
                                    .foregroundColor(AppTheme.Colors.textSecondary)
                            }
                            
                            // Stats
                            quickStatsGrid
                            
                            // Pairings
                            foodPairingSection
                            
                            Spacer(minLength: 120)
                        }
                        .padding(.horizontal, 32)
                        .padding(.top, 16)
                        .padding(.bottom, 32)
                        .frame(maxWidth: .infinity)
                        .background(
                            GeometryReader { geo in
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: Color.white.opacity(0.0), location: 0.0),
                                        .init(color: Color.white, location: 0.15)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            }
                        )
                        .clipShape(RoundedCorner(radius: 35, corners: [.topLeft, .topRight]))
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
                    }
                }
                .zIndex(2)
                .ignoresSafeArea(edges: .bottom)

                // LAYER 4: NAVIGATION
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.black)
                            .padding(10)
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                    }
                    Spacer()
                    Button(action: { isBookmarked.toggle() }) {
                        Image(systemName: isBookmarked ? "heart.fill" : "heart")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(isBookmarked ? .red : .black)
                            .padding(10)
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 50)
                .zIndex(3)
                
                // LAYER 5: STICKY BUTTON
                VStack {
                    Spacer()
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(sake.formattedPrice)
                                .font(.system(size: 24, weight: .bold, design: .serif))
                                .foregroundColor(AppTheme.Colors.primary)
                            Text("Imported from Japan")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Button(action: {}) {
                            Text("Add to Cart")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 30)
                                .padding(.vertical, 16)
                                .background(AppTheme.Colors.primary)
                                .clipShape(Capsule())
                                .shadow(color: AppTheme.Colors.primary.opacity(0.3), radius: 10, x: 0, y: 5)
                        }
                    }
                    .padding(20)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: -5)
                    .padding(.bottom, geometry.safeAreaInsets.bottom > 0 ? 0 : 20)
                }
                .zIndex(3)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .toolbar(.hidden, for: .navigationBar) // Hide default nav bar
        .toolbar(.hidden, for: .tabBar) // Hide main tab bar
        .onAppear {
            // Animate bottle and rating in with a spring effect
            withAnimation(.spring(response: 0.8, dampingFraction: 0.7)) {
                bottleScale = 1.0
                bottleOpacity = 1.0
            }

            // Rating appears slightly after bottle
            withAnimation(.spring(response: 0.8, dampingFraction: 0.7).delay(0.1)) {
                ratingScale = 1.0
                ratingOpacity = 1.0
            }
        }
    }
    
    // MARK: - Components
    
    private var quickStatsGrid: some View {
        HStack(spacing: 12) {
            statBadge(icon: "drop.fill", title: "Alcohol", value: "\(Int(sake.alcoholContent))%")
            statBadge(icon: "leaf.fill", title: "Polishing", value: "\(sake.polishRatio)%")
            statBadge(icon: "sparkles", title: "Type", value: "Junmai")
        }
    }
    
    private func statBadge(icon: String, title: String, value: String) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(AppTheme.Colors.primary)
            
            Text(value)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(AppTheme.Colors.textPrimary)
            
            Text(title)
                .font(.system(size: 10))
                .foregroundColor(.gray)
                .textCase(.uppercase)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
    
    private var foodPairingSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Best Served With")
                .font(.system(size: 16, weight: .semibold, design: .serif))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(["🍣 Sushi", "🐟 Sashimi", "🍤 Tempura"], id: \.self) { pair in
                        HStack(spacing: 6) {
                            Text(pair)
                                .font(.system(size: 14, weight: .medium))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        )
                        .cornerRadius(20)
                    }
                }
            }
        }
    }
}

// MARK: - Helper Structs

/// Smart Image View that handles local vs remote images and rendering content mode
struct SakeImage: View {
    let url: String
    
    var body: some View {
        if url.starts(with: "http") {
            AsyncImage(url: URL(string: url)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    // Placeholder while loading
                    Color.clear
                }
            }
        } else {
            // Local Image
            // We expect a transparent PNG in assets
            Image(url)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    SakeDetailView(sake: SampleData.shared.sakes[0])
        .environmentObject(LanguageManager())
}

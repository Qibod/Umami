//
//  AppTheme.swift
//  Umami
//
//  Created on 2025-01-05.
//

import SwiftUI

struct AppTheme {
    // MARK: - Colors
    struct Colors {
        // Primary brand color - inspired by sake and Japanese aesthetics
        static let primary = Color(hex: "8B1538") // Deep burgundy/sake red
        static let secondary = Color(hex: "2E5077") // Sake blue

        // Backgrounds
        static let background = Color(hex: "FFFFFF")
        static let cardBackground = Color(hex: "F5F5F0") // Warm gray
        static let lightBackground = Color(hex: "FAFAFA")

        // Text
        static let textPrimary = Color(hex: "1A1A1A")
        static let textSecondary = Color(hex: "666666")
        static let textTertiary = Color(hex: "999999")

        // Accent colors
        static let accent = Color(hex: "D4AF37") // Gold
        static let success = Color(hex: "0F9960")
        static let warning = Color(hex: "F29D49")
        static let error = Color(hex: "DB3737")

        // Rating star
        static let starColor = Color(hex: "FF6B35")

        // Sake type colors (earthy tones)
        static let sakeRiceBeige = Color(hex: "E8DCC4")
        static let kojiGold = Color(hex: "C9A96E")
        static let cedarBrown = Color(hex: "8B7355")
    }

    // MARK: - Typography
    struct Typography {
        static let largeTitle = Font.system(size: 34, weight: .bold, design: .default)
        static let title = Font.system(size: 28, weight: .bold, design: .default)
        static let title2 = Font.system(size: 22, weight: .bold, design: .default)
        static let title3 = Font.system(size: 20, weight: .semibold, design: .default)
        static let headline = Font.system(size: 17, weight: .semibold, design: .default)
        static let body = Font.system(size: 17, weight: .regular, design: .default)
        static let callout = Font.system(size: 16, weight: .regular, design: .default)
        static let subheadline = Font.system(size: 15, weight: .regular, design: .default)
        static let footnote = Font.system(size: 13, weight: .regular, design: .default)
        static let caption = Font.system(size: 12, weight: .regular, design: .default)
        static let caption2 = Font.system(size: 11, weight: .regular, design: .default)
    }

    // MARK: - Spacing
    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
    }

    // MARK: - Corner Radius
    struct CornerRadius {
        static let sm: CGFloat = 8
        static let md: CGFloat = 12
        static let lg: CGFloat = 16
        static let xl: CGFloat = 20
    }

    // MARK: - Shadow
    struct Shadows {
        static let card = Shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
        static let elevated = Shadow(color: Color.black.opacity(0.12), radius: 16, x: 0, y: 4)
    }

    struct Shadow {
        let color: Color
        let radius: CGFloat
        let x: CGFloat
        let y: CGFloat
    }
}

// MARK: - Color Extension for Hex
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

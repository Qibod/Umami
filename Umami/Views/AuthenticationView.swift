//
//  AuthenticationView.swift
//  Umami
//
//  Created on 2025-01-05.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject private var languageManager = LanguageManager.shared
    @Binding var isAuthenticated: Bool
    @State private var showLanguageMenu = false

    var body: some View {
        ZStack {
            // Background
            Color.white.ignoresSafeArea()

            ScrollView {
                VStack(spacing: AppTheme.Spacing.xl) {
                    Spacer()
                        .frame(height: 40)

                    // Language toggle at top
                    HStack {
                        Spacer()

                        Button(action: { showLanguageMenu = true }) {
                            HStack(spacing: 6) {
                                Text(languageManager.currentLanguage.flag)
                                Text(languageManager.currentLanguage.displayName)
                                    .font(AppTheme.Typography.subheadline)
                                    .foregroundColor(AppTheme.Colors.textSecondary)
                                Image(systemName: "chevron.down")
                                    .font(.caption)
                                    .foregroundColor(AppTheme.Colors.textSecondary)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(AppTheme.Colors.cardBackground)
                            .cornerRadius(AppTheme.CornerRadius.lg)
                        }
                    }
                    .padding(.horizontal, AppTheme.Spacing.md)

                    // Logo and branding
                    VStack(spacing: AppTheme.Spacing.lg) {
                        // Logo
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [AppTheme.Colors.primary.opacity(0.1), AppTheme.Colors.secondary.opacity(0.1)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 120, height: 120)

                            Image(systemName: "cup.and.saucer.fill")
                                .font(.system(size: 50))
                                .foregroundColor(AppTheme.Colors.primary)
                        }

                        // Title
                        VStack(spacing: AppTheme.Spacing.sm) {
                            Text(LocalizedStrings.get("welcome", language: languageManager.currentLanguage))
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(AppTheme.Colors.textPrimary)

                            Text(LocalizedStrings.get("welcomeSubtitle", language: languageManager.currentLanguage))
                                .font(AppTheme.Typography.callout)
                                .foregroundColor(AppTheme.Colors.textSecondary)
                        }
                    }
                    .padding(.top, 40)

                    Spacer()
                        .frame(height: 60)

                    // Authentication buttons
                    VStack(spacing: AppTheme.Spacing.md) {
                        // Sign in with Email
                        Button(action: {
                            // Email sign in action
                            isAuthenticated = true
                        }) {
                            HStack {
                                Image(systemName: "envelope.fill")
                                    .font(.title3)
                                Text(LocalizedStrings.get("signInWithEmail", language: languageManager.currentLanguage))
                                    .font(AppTheme.Typography.headline)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(AppTheme.Colors.primary)
                            .cornerRadius(AppTheme.CornerRadius.md)
                        }

                        // Divider
                        HStack {
                            Rectangle()
                                .fill(AppTheme.Colors.cardBackground)
                                .frame(height: 1)

                            Text(LocalizedStrings.get("orContinueWith", language: languageManager.currentLanguage))
                                .font(AppTheme.Typography.caption)
                                .foregroundColor(AppTheme.Colors.textSecondary)
                                .padding(.horizontal, 12)

                            Rectangle()
                                .fill(AppTheme.Colors.cardBackground)
                                .frame(height: 1)
                        }
                        .padding(.vertical, AppTheme.Spacing.sm)

                        // Sign in with Apple
                        Button(action: {
                            // Apple sign in action
                            isAuthenticated = true
                        }) {
                            HStack {
                                Image(systemName: "apple.logo")
                                    .font(.title3)
                                Text(LocalizedStrings.get("signInWithApple", language: languageManager.currentLanguage))
                                    .font(AppTheme.Typography.headline)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.black)
                            .cornerRadius(AppTheme.CornerRadius.md)
                        }

                        // Sign in with Google
                        Button(action: {
                            // Google sign in action
                            isAuthenticated = true
                        }) {
                            HStack {
                                Image(systemName: "globe")
                                    .font(.title3)
                                Text(LocalizedStrings.get("signInWithGoogle", language: languageManager.currentLanguage))
                                    .font(AppTheme.Typography.headline)
                            }
                            .foregroundColor(AppTheme.Colors.textPrimary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.white)
                            .cornerRadius(AppTheme.CornerRadius.md)
                            .overlay(
                                RoundedRectangle(cornerRadius: AppTheme.CornerRadius.md)
                                    .stroke(AppTheme.Colors.cardBackground, lineWidth: 1.5)
                            )
                        }

                        // Continue as Guest
                        Button(action: {
                            // Guest mode
                            isAuthenticated = true
                        }) {
                            Text(LocalizedStrings.get("continueAsGuest", language: languageManager.currentLanguage))
                                .font(AppTheme.Typography.callout)
                                .foregroundColor(AppTheme.Colors.primary)
                                .padding(.vertical, 12)
                        }
                    }
                    .padding(.horizontal, AppTheme.Spacing.lg)

                    Spacer()
                        .frame(height: 40)

                    // Terms and Privacy
                    Text(LocalizedStrings.get("bySigningIn", language: languageManager.currentLanguage))
                        .font(AppTheme.Typography.caption)
                        .foregroundColor(AppTheme.Colors.textTertiary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, AppTheme.Spacing.xl)

                    Spacer()
                }
            }
        }
        .actionSheet(isPresented: $showLanguageMenu) {
            ActionSheet(
                title: Text("Select Language / 言語を選択"),
                buttons: [
                    .default(Text("🇺🇸 English")) {
                        languageManager.currentLanguage = .english
                    },
                    .default(Text("🇯🇵 日本語")) {
                        languageManager.currentLanguage = .japanese
                    },
                    .cancel()
                ]
            )
        }
    }
}

#Preview {
    AuthenticationView(isAuthenticated: .constant(false))
}

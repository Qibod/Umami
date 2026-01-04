//
//  SplashView.swift
//  Umami
//
//  Created on 2025-01-05.
//

import SwiftUI

struct SplashView: View {
    @State private var isAnimating = false
    @State private var showText = false

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [AppTheme.Colors.primary, AppTheme.Colors.secondary],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: AppTheme.Spacing.xl) {
                Spacer()

                // Logo
                ZStack {
                    // Outer circle
                    Circle()
                        .stroke(Color.white.opacity(0.3), lineWidth: 3)
                        .frame(width: 140, height: 140)
                        .scaleEffect(isAnimating ? 1.1 : 1.0)
                        .opacity(isAnimating ? 0 : 1)

                    // Inner circle with sake cup icon
                    Circle()
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 120, height: 120)

                    // Sake cup icon (using wineglass as placeholder)
                    Image(systemName: "cup.and.saucer.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                        .scaleEffect(isAnimating ? 1.0 : 0.8)
                }
                .scaleEffect(isAnimating ? 1.0 : 0.8)
                .opacity(isAnimating ? 1 : 0)

                // App name
                VStack(spacing: AppTheme.Spacing.sm) {
                    Text("UMAMI")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .tracking(8)
                        .opacity(showText ? 1 : 0)
                        .offset(y: showText ? 0 : 20)

                    Text("旨味")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                        .opacity(showText ? 1 : 0)
                        .offset(y: showText ? 0 : 20)

                    Text("Discover the World of Sake")
                        .font(AppTheme.Typography.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                        .opacity(showText ? 1 : 0)
                        .offset(y: showText ? 0 : 20)
                }

                Spacer()

                // Loading indicator
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.2)
                    .opacity(showText ? 1 : 0)
                    .padding(.bottom, 60)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                isAnimating = true
            }

            withAnimation(.easeOut(duration: 0.6).delay(0.3)) {
                showText = true
            }

            // Simulate loading for 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                // Transition handled by parent view
            }
        }
    }
}

#Preview {
    SplashView()
}

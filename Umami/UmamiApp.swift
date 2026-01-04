//
//  UmamiApp.swift
//  Umami
//
//  Created by Vijay R on 1/4/26.
//

import SwiftUI

@main
struct UmamiApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var languageManager = LanguageManager.shared

    var body: some Scene {
        WindowGroup {
            ZStack {
                switch appState.currentPhase {
                case .splash:
                    SplashView()
                case .authentication:
                    AuthenticationView(isAuthenticated: $appState.isAuthenticated)
                        .onChange(of: appState.isAuthenticated) { _, newValue in
                            if newValue {
                                withAnimation {
                                    appState.signIn()
                                }
                            }
                        }
                case .main:
                    MainTabView()
                        .environmentObject(languageManager)
                        .transition(.opacity)
                }
            }
        }
    }
}

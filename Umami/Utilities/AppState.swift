//
//  AppState.swift
//  Umami
//
//  Created on 2025-01-05.
//

import Foundation
import SwiftUI
import Combine

enum AppPhase {
    case splash
    case authentication
    case main
}

class AppState: ObservableObject {
    @Published var currentPhase: AppPhase = .splash
    @Published var isAuthenticated: Bool = false

    init() {
        // Check if user is already authenticated
        checkAuthenticationStatus()
    }

    private func checkAuthenticationStatus() {
        // Check UserDefaults or Keychain for saved authentication
        if UserDefaults.standard.bool(forKey: "isAuthenticated") {
            isAuthenticated = true
        }

        // Show splash for 2 seconds, then move to appropriate screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if self.isAuthenticated {
                self.currentPhase = .main
            } else {
                self.currentPhase = .authentication
            }
        }
    }

    func signIn() {
        isAuthenticated = true
        UserDefaults.standard.set(true, forKey: "isAuthenticated")
        currentPhase = .main
    }

    func signOut() {
        isAuthenticated = false
        UserDefaults.standard.set(false, forKey: "isAuthenticated")
        currentPhase = .authentication
    }
}

//
//  LanguageToggle.swift
//  Umami
//
//  Created on 2025-01-05.
//

import SwiftUI

struct LanguageToggle: View {
    @EnvironmentObject var languageManager: LanguageManager

    var body: some View {
        Button(action: {
            // Toggle between languages
            languageManager.currentLanguage = languageManager.currentLanguage == .english ? .japanese : .english
        }) {
            Text(languageManager.currentLanguage == .english ? "🇬🇧" : "🇯🇵")
                .font(.title2)
                .frame(minWidth: 44, minHeight: 44) // iOS minimum tap target
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    LanguageToggle()
}

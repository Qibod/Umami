//
//  LanguageToggle.swift
//  Umami
//
//  Created on 2025-01-05.
//

import SwiftUI

struct LanguageToggle: View {
    @ObservedObject var languageManager = LanguageManager.shared
    @State private var showLanguageMenu = false

    var body: some View {
        Button(action: { showLanguageMenu = true }) {
            HStack(spacing: 4) {
                Text(languageManager.currentLanguage.flag)
                    .font(.caption)
            }
            .padding(8)
            .background(AppTheme.Colors.cardBackground.opacity(0.5))
            .clipShape(Circle())
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
    LanguageToggle()
}

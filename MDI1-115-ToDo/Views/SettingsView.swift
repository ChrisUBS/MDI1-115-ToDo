//
//  SettingsView.swift
//  ToDo
//
//  Created by Christian Bonilla on 18/12/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @EnvironmentObject var languageManager: LanguageManager
    @Environment(\.dismiss) private var dismiss

    let languages = [
//        ("System", nil),
        ("English", "en"),
        ("Français", "fr"),
        ("Español (LatAm)", "es-419")
    ]

    var body: some View {
        NavigationStack {
            Form {
                // MARK: - Appearance
                Section("Appearance") {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                        .accessibilityIdentifier("darkModeToggle")
                }

                // MARK: - Language
                Section("Language") {
                    Picker("App Language", selection: $languageManager.languageCode) {
                        ForEach(languages, id: \.1) { name, code in
                            Text(name).tag(code)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    .accessibilityIdentifier("languagePicker")
                }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

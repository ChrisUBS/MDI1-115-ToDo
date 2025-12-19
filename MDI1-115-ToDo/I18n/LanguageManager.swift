//
//  LanguageManager.swift
//  ToDo
//
//  Created by Christian Bonilla on 18/12/25.
//

import SwiftUI
import Combine

final class LanguageManager: ObservableObject {
    @AppStorage("appLanguage") var languageCode: String = Locale.current.identifier

    var locale: Locale {
        Locale(identifier: languageCode)
    }
}

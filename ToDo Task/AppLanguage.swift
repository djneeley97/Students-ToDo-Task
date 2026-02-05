//
//  AppLanguages.swift
//  ToDo Task
//
//  Created by daniel neeley on 2/2/26.
//

import Foundation

enum AppLanguage: String, CaseIterable, Identifiable {
    case english  = "en"
    case spanish  = "es"
    case russian  = "ru"
    case swedish  = "sv"

    var id: String { rawValue }

    var flag: String {
        switch self {
        case .english: return "🇺🇸"
        case .spanish: return "🇪🇸"
        case .russian: return "🇷🇺"
        case .swedish: return "🇸🇪"
        }
    }

    var locale: Locale {
        Locale(identifier: rawValue)
    }
}

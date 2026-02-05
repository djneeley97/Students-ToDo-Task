//
//  ToDo_TaskApp.swift
//  ToDo Task
//
//  Created by Gabriela Sanchez on 09/12/25.
//

import SwiftUI

@main
struct ToDoApp: App {

    @AppStorage("appLanguage") private var appLanguage: AppLanguage = .english

    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environment(\.locale, appLanguage.locale)
        }
    }
}


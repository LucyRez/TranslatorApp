//
//  TranslatorApp.swift
//  Translator
//
//  Created by Ludmila Rezunic on 30.03.2021.
//

import SwiftUI

@main
struct TranslatorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
           TranslatorView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

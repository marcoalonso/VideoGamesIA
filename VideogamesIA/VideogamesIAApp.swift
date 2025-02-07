//
//  VideogamesIAApp.swift
//  VideogamesIA
//
//  Created by Marco Alonso Rodriguez on 07/02/25.
//

import SwiftUI
import CoreData

@main
struct VideogamesIAApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

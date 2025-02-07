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
       let gameViewModel = GameViewModel()

    var body: some Scene {
        WindowGroup {
            GameTabView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(gameViewModel)
        }
    }
}

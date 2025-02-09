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
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    let persistenceController = PersistenceController.shared

    let repository: GameRepository
    let service: GameService
    let gameViewModel: GameViewModel

    init() {
        let context = persistenceController.container.viewContext
        self.repository = GameRepository(context: context)
        self.service = GameService()
        self.gameViewModel = GameViewModel(repository: repository, service: service)
    }

    var body: some Scene {
        WindowGroup {
            GameTabView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(gameViewModel)
        }
    }
}


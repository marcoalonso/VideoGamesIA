//
//  MockGameViewModel.swift
//  VideogamesIAInt
//
//  Created by Marco Alonso Rodriguez on 07/02/25.
//

import Foundation

class MockGameViewModel: ObservableObject {
    @Published var games: [Game] = MockData.sampleGames

    func loadGames() {
        // No realiza una llamada real, simplemente utiliza los datos de prueba
    }
}

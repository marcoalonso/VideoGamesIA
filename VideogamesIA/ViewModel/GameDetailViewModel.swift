//
//  GameDetailViewModel.swift
//  VideogamesIA
//
//  Created by Marco Alonso Rodriguez on 08/02/25.
//

import Foundation

class GameDetailViewModel: ObservableObject {
    @Published var game: Game?
    @Published var isAnimating = false
    @Published var safariURL: URL?
    @Published var showDeleteConfirmation = false

    let repository: GameRepositoryProtocol
    private let gameID: Int

    init(repository: GameRepositoryProtocol, gameID: Int) {
        self.repository = repository
        self.gameID = gameID
        self.reloadGame()
    }

    func reloadGame() {
        game = repository.fetchMappedGames().first(where: { $0.id == gameID })
    }

    func deleteGame() {
        if let game = game {
            repository.deleteGame(byID: game.id)
            self.game = nil
        }
    }
}




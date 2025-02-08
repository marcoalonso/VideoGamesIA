//
//  GameEditViewModel.swift
//  VideogamesIA
//
//  Created by Marco Alonso Rodriguez on 08/02/25.
//

import Foundation

class GameEditViewModel: ObservableObject {
    let repository: GameRepositoryProtocol

    init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }

    func updateGame(game: Game,
                    newTitle: String,
                    newGenre: String,
                    newPlatform: String,
                    newReleaseDate: String,
                    newDeveloper: String,
                    newPublisher: String,
                    newDescription: String) {
        
        repository.updateGame(
            id: game.id,
            title: newTitle,
            genre: newGenre,
            platform: newPlatform,
            releaseDate: newReleaseDate,
            developer: newDeveloper,
            publisher: newPublisher,
            description: newDescription
        )
    }
}

//
//  GameRepositoryProtocol.swift
//  VideogamesIA
//
//  Created by Marco Alonso Rodriguez on 08/02/25.
//

import Foundation

protocol GameRepositoryProtocol {
    /// Returns a list of game entities (`GameEntity`) from CoreData.
    func fetchGames() -> [GameEntity]

    /// Returns a list of mapped games (`Game`) from entities stored in CoreData.
    func fetchMappedGames() -> [Game]

    /// Saves a game from a `GameDTO` object.
    /// - Parameter dto: The `GameDTO` object containing the data to save.
    func saveGame(from dto: GameDTO)

    /// Remove all CoreData games.
    func deleteAllGames()

    /// Deletes a CoreData game given its ID.
    /// - Parameter id: The ID of the game to be deleted.
    func deleteGame(byID id: Int)

    /// Updates a game's data in CoreData.
    /// - Parameters:
    /// - id: The game's ID.
    /// - title: The new title.
    /// - genre: The new genre.
    /// - platform: The new platform.
    /// - releasedate: The new release date.
    /// - developer: The new developer.
    /// - publisher: The new publisher.
    /// - description: The new description.
    func updateGame(id: Int, title: String, genre: String, platform: String, releaseDate: String, developer: String, publisher: String, description: String)
}


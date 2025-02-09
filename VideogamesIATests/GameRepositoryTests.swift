//
//  GameRepositoryTests.swift
//  VideogamesIATests
//
//  Created by Marco Alonso Rodriguez on 08/02/25.
//

import XCTest
import CoreData
@testable import VideogamesIA

final class GameRepositoryTests: XCTestCase {
    
    var repository: GameRepository!
    var testContext: NSManagedObjectContext!

    override func setUp() {
        super.setUp()
        
        let persistentContainer = NSPersistentContainer(name: "VideogamesIA")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [description]

        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                XCTFail("Failed to set up in-memory Core Data store: \(error)")
            }
        }

        testContext = persistentContainer.viewContext
        repository = GameRepository(context: testContext)
    }

    override func tearDown() {
        repository = nil
        testContext = nil
        super.tearDown()
    }

    func testSaveGame() {
        // Arrange
        let sampleDTO = GameDTO(
            id: 1,
            title: "Sample Game",
            thumbnail: "https://example.com/image.jpg",
            shortDescription: "A sample game",
            gameURL: "https://example.com/game",
            genre: "Adventure",
            platform: "PC",
            publisher: "Sample Publisher",
            developer: "Sample Developer",
            releaseDate: "2024-06-22",
            profileURL: "https://example.com/profile"
        )

        // Act
        repository.saveGame(from: sampleDTO)

        // Assert
        let savedGames = repository.fetchMappedGames()
        XCTAssertEqual(savedGames.count, 1)
        XCTAssertEqual(savedGames.first?.title, "Sample Game")
    }

    func testFetchGames() {
        // Arrange
        insertSampleGame(id: 1, title: "Sample Game")

        // Act
        let games = repository.fetchMappedGames()

        // Assert
        XCTAssertEqual(games.count, 1)
        XCTAssertEqual(games.first?.title, "Sample Game")
    }

    func testDeleteAllGames() {
        // Arrange
        insertSampleGame(id: 1, title: "Sample Game")
        insertSampleGame(id: 2, title: "Another Game")

        // Act
        repository.deleteAllGames()

        // Assert
        let games = repository.fetchMappedGames()
        XCTAssertTrue(games.isEmpty)
    }

    func testDeleteGameByID() {
        // Arrange
        insertSampleGame(id: 1, title: "Sample Game")
        insertSampleGame(id: 2, title: "Another Game")

        // Act
        repository.deleteGame(byID: 1)

        // Assert
        let games = repository.fetchMappedGames()
        XCTAssertEqual(games.count, 1)
        XCTAssertEqual(games.first?.title, "Another Game")
    }

    func testUpdateGame() {
        // Arrange
        insertSampleGame(id: 1, title: "Old Title")

        // Act
        repository.updateGame(
            id: 1,
            title: "Updated Title",
            genre: "Updated Genre",
            platform: "Updated Platform",
            releaseDate: "2024-06-23",
            developer: "Updated Developer",
            publisher: "Updated Publisher",
            description: "Updated Description"
        )

        // Assert
        let games = repository.fetchMappedGames()
        XCTAssertEqual(games.count, 1)
        XCTAssertEqual(games.first?.title, "Updated Title")
        XCTAssertEqual(games.first?.genre, "Updated Genre")
    }

    /// Helper for inserting a game into Core Data during testing
    private func insertSampleGame(id: Int, title: String) {
        let gameEntity = GameEntity(context: testContext)
        gameEntity.id = Int32(id)
        gameEntity.title = title
        gameEntity.thumbnail = "https://example.com/image.jpg"
        gameEntity.shortDesc = "A sample game"
        gameEntity.gameURL = "https://example.com/game"
        gameEntity.genre = "Adventure"
        gameEntity.platform = "PC"
        gameEntity.publisher = "Sample Publisher"
        gameEntity.developer = "Sample Developer"
        gameEntity.releaseDate = "2024-06-22"
        gameEntity.profileURL = "https://example.com/profile"

        do {
            try testContext.save()
        } catch {
            XCTFail("Failed to save sample game: \(error)")
        }
    }
}

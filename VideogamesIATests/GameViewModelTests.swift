//
//  GameViewModelTests.swift
//  VideogamesIATests
//
//  Created by Marco Alonso Rodriguez on 08/02/25.
//

import XCTest
import Combine
@testable import VideogamesIA

final class GameViewModelTests: XCTestCase {
    
    var viewModel: GameViewModel!
    var mockRepository: MockGameRepository!
    var mockService: MockGameService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRepository = MockGameRepository()
        mockService = MockGameService()
        viewModel = GameViewModel(repository: mockRepository, service: mockService)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        mockService = nil
        cancellables = nil
        super.tearDown()
    }

    func testLoadGamesFromAPI_Success() {
        // Arrange
        mockService.mockGames = MockGameRepository.sampleGames.map { GameMapper.toDTO(from: $0) }

        // Act
        let expectation = self.expectation(description: "Games loaded from API")
        viewModel.loadGamesFromAPI()

        // Assert
        viewModel.$games
            .sink { games in
                if !games.isEmpty {
                    XCTAssertEqual(games.count, 3)
                    XCTAssertEqual(games.first?.title, "Tarisland")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 2.0)
    }


    func testLoadGamesFromAPI_Failure() {
        // Arrange
        mockService.shouldFail = true

        // Act
        let expectation = self.expectation(description: "Error handling on API failure")
        viewModel.loadGamesFromAPI()

        // Assert
        viewModel.$errorMessage
            .sink { errorMessage in
                if let errorMessage = errorMessage {
                    XCTAssertEqual(errorMessage, VideoGameNetworkError.requestFailed.localizedDescription)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        waitForExpectations(timeout: 2.0)
    }

    func testDeleteAllGames() {
        // Arrange
        mockRepository.gamesStorage = MockGameRepository.sampleGames

        // Act
        viewModel.deleteAllGames()

        // Assert
        XCTAssertTrue(mockRepository.fetchMappedGames().isEmpty)
    }

}


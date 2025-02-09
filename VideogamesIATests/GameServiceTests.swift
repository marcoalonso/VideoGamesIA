//
//  GameServiceTests.swift
//  VideogamesIATests
//
//  Created by Marco Alonso Rodriguez on 08/02/25.
//


import XCTest
import Combine
@testable import VideogamesIA

final class GameServiceTests: XCTestCase {
    
    var service: GameService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        service = GameService(session: session)
        cancellables = []
    }

    override func tearDown() {
        service = nil
        cancellables = nil
        super.tearDown()
    }

    func testResponseStatusCodeIsSuccess() {
        // Arrange
        MockURLProtocol.responseData = validSampleData
        MockURLProtocol.responseStatusCode = 200

        let expectation = self.expectation(description: "Received valid HTTP response")

        // Act
        service.fetchGames()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTFail("Expected success, but received failure.")
                case .finished:
                    expectation.fulfill()
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        waitForExpectations(timeout: 2.0)
    }

    func testDataIsDecodedToGameDTO() {
        // Arrange
        MockURLProtocol.responseData = validSampleData

        let expectation = self.expectation(description: "Decoded data to GameDTO successfully")

        // Act
        service.fetchGames()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success but got error: \(error)")
                }
            }, receiveValue: { games in
                // Assert
                XCTAssertEqual(games.count, 1)
                XCTAssertEqual(games.first?.title, "Sample Game")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 2.0)
    }

    func testCombinePublishesDataSuccessfully() {
        // Arrange: Configuramos datos válidos
        MockURLProtocol.responseData = validSampleData

        let expectation = self.expectation(description: "Combine published data successfully")

        // Act
        service.fetchGames()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected successful completion")
                }
            }, receiveValue: { games in
                // Assert
                XCTAssertFalse(games.isEmpty, "Expected non-empty games array")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 2.0)
    }

    private var validSampleData: Data {
        """
        [
            {
                "id": 1,
                "title": "Sample Game",
                "thumbnail": "https://example.com/image.jpg",
                "short_description": "A sample game description.",
                "game_url": "https://example.com/game",
                "genre": "Adventure",
                "platform": "PC",
                "publisher": "Sample Publisher",
                "developer": "Sample Developer",
                "release_date": "2024-01-01",
                "freetogame_profile_url": "https://example.com/profile"
            }
        ]
        """.data(using: .utf8)!
    }
}




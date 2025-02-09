//
//  MockGameService.swift
//  VideogamesIA
//
//  Created by Marco Alonso Rodriguez on 08/02/25.
//

import Foundation
import Combine

final class MockGameService: GameServiceProtocol {

    // Propiedades para simular diferentes resultados
    var shouldFail: Bool = false
    var mockGames: [GameDTO] = MockGameService.sampleGameDTOs

    // Simulación del método `fetchGames`
    func fetchGames() -> AnyPublisher<[GameDTO], VideoGameNetworkError> {
        if shouldFail {
            return Fail(error: VideoGameNetworkError.requestFailed)
                .eraseToAnyPublisher()
        } else {
            return Just(mockGames)
                .setFailureType(to: VideoGameNetworkError.self)
                .eraseToAnyPublisher()
        }
    }

    // Datos de ejemplo
    static let sampleGameDTOs: [GameDTO] = [
        GameDTO(
            id: 582,
            title: "Tarisland",
            thumbnail: "https://www.freetogame.com/g/582/thumbnail.jpg",
            shortDescription: "A cross-platform MMORPG developed by Level Infinite and Published by Tencent.",
            gameURL: "https://www.freetogame.com/open/tarisland",
            genre: "MMORPG",
            platform: "PC",
            publisher: "Tencent",
            developer: "Level Infinite",
            releaseDate: "2024-06-22",
            profileURL: "https://www.freetogame.com/tarisland"
        ),
        GameDTO(
            id: 540,
            title: "Overwatch 2",
            thumbnail: "https://www.freetogame.com/g/540/thumbnail.jpg",
            shortDescription: "A hero-focused first-person team shooter from Blizzard Entertainment.",
            gameURL: "https://www.freetogame.com/open/overwatch-2",
            genre: "Shooter",
            platform: "PC",
            publisher: "Activision Blizzard",
            developer: "Blizzard Entertainment",
            releaseDate: "2022-10-04",
            profileURL: "https://www.freetogame.com/overwatch-2"
        ),
        GameDTO(
            id: 516,
            title: "PUBG: BATTLEGROUNDS",
            thumbnail: "https://www.freetogame.com/g/516/thumbnail.jpg",
            shortDescription: "Get into the action in one of the longest running battle royale games PUBG Battlegrounds.",
            gameURL: "https://www.freetogame.com/open/pubg",
            genre: "Shooter",
            platform: "PC",
            publisher: "KRAFTON, Inc.",
            developer: "KRAFTON, Inc.",
            releaseDate: "2022-01-12",
            profileURL: "https://www.freetogame.com/pubg"
        )
    ]
}

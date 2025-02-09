//
//  MockGameService.swift
//  VideogamesIA
//
//  Created by Marco Alonso Rodriguez on 08/02/25.
//

import Foundation
import Combine

class MockGameService: GameServiceProtocol {
    func fetchGames() -> AnyPublisher<[GameDTO], VideoGameNetworkError> {
        let sampleDTO = GameDTO(id: 1, title: "Sample Game", thumbnail: "", shortDescription: "A sample game", gameURL: "", genre: "Adventure", platform: "PC", publisher: "Sample Publisher", developer: "Sample Developer", releaseDate: "2024-06-22", profileURL: "")
        return Just([sampleDTO])
            .setFailureType(to: VideoGameNetworkError.self)
            .eraseToAnyPublisher()
    }
}

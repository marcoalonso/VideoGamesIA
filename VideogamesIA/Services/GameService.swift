//
//  GameService.swift
//  VideogamesIAInt
//
//  Created by Marco Alonso Rodriguez on 07/02/25.
//

import Foundation
import Combine

class GameService {
    func fetchGames() -> AnyPublisher<[GameDTO], VideoGameNetworkError> {
        guard let url = URL(string: "https://www.freetogame.com/api/games") else {
            return Fail(error: VideoGameNetworkError.invalidURL).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { _ in VideoGameNetworkError.requestFailed }
            .tryMap { output in
                guard let response = output.response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    throw VideoGameNetworkError.serverError(statusCode: (output.response as? HTTPURLResponse)?.statusCode ?? 0)
                }
                return output.data
            }
            .decode(type: [GameDTO].self, decoder: JSONDecoder())
            .mapError { error in
                if let decodingError = error as? DecodingError {
                    return VideoGameNetworkError.decodingError
                } else if let networkError = error as? VideoGameNetworkError {
                    return networkError
                } else {
                    return VideoGameNetworkError.unknownError
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}



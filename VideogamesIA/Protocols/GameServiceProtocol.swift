//
//  GameServiceProtocol.swift
//  VideogamesIA
//
//  Created by Marco Alonso Rodriguez on 08/02/25.
//

import Foundation
import Combine

protocol GameServiceProtocol {
    /// This function makes an asynchronous network request to retrieve video game data
    /// - Returns: a publisher that emits an array of GameDTO objects or a VideoGameNetworkError.
    func fetchGames() -> AnyPublisher<[GameDTO], VideoGameNetworkError>
}

//
//  GameViewModel.swift
//  VideogamesIAInt
//
//  Created by Marco Alonso Rodriguez on 07/02/25.
//
import Foundation
import Combine
import CoreData

class GameViewModel: ObservableObject {
    @Published var games: [Game] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    let repository: GameRepositoryProtocol
    private let service: GameServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(repository: GameRepositoryProtocol, service: GameServiceProtocol) {
        self.repository = repository
        self.service = service
    }

    func loadGames() {
        let cachedGames = repository.fetchMappedGames()

        if cachedGames.isEmpty {
            loadGamesFromAPI()
        } else {
            games = cachedGames
        }
    }

    func loadGamesFromAPI() {
        isLoading = true

        service.fetchGames()
            .sink(receiveCompletion: { [weak self] completion in
                print("Debug: completion \(completion)")
                DispatchQueue.main.async {
                    self?.isLoading = false
                    switch completion {
                    case .failure(let error):
                        self?.handleError(error)
                    case .finished:
                        break
                    }
                }
            }, receiveValue: { [weak self] gameDTOs in
                DispatchQueue.main.async {
                    guard let self = self else { return }

                    self.repository.deleteAllGames()
                    gameDTOs.forEach { dto in
                        self.repository.saveGame(from: dto)
                    }
                    
                    self.games = self.repository.fetchMappedGames()
                    self.errorMessage = nil
                }
            })
            .store(in: &cancellables)
    }

    private func handleError(_ error: VideoGameNetworkError) {
        errorMessage = error.localizedDescription
    }
    
    func deleteAllGames() {
        repository.deleteAllGames()
        games.removeAll()
    }
}

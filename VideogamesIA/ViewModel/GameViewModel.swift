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
    
    private let service = GameService()
    private let repository = GameRepository()
    private var cancellables = Set<AnyCancellable>()

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
                print("Debug: gameDTOs \(gameDTOs.count)")
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
        print("Error: \(error.localizedDescription)")
    }

    func deleteGame(_ game: Game) {
        repository.deleteGame(byID: game.id)
        games = repository.fetchMappedGames()
    }

    func deleteAllGames() {
        repository.deleteAllGames()
        games.removeAll()
    }

    func searchGames(byTitle title: String) {
        games = repository.fetchMappedGames().filter {
            $0.title.lowercased().contains(title.lowercased())
        }
    }
}

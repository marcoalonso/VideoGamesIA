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
        isLoading = true

        service.fetchGames()
            .sink(receiveCompletion: { [weak self] completion in
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

    func searchGames(byTitle title: String) {
        let filteredGames = repository.fetchMappedGames().filter {
            $0.title.lowercased().contains(title.lowercased())
        }
        games = filteredGames
    }
}

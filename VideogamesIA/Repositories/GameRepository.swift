//
//  GameRepository.swift
//  VideogamesIAInt
//
//  Created by Marco Alonso Rodriguez on 07/02/25.
//

import CoreData

class GameRepository {
    private let context = PersistenceController.shared.container.viewContext

    func fetchGames() -> [GameEntity] {
        let request: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch games: \(error.localizedDescription)")
            return []
        }
    }

    func fetchMappedGames() -> [Game] {
        let entities = fetchGames()
        return GameMapper.fromEntities(entities)
    }
    
    func saveGame(from dto: GameDTO) {
        _ = GameMapper.fromDTOToEntity(dto, context: context)
        
        do {
            print("Debug: dto saved! \(dto)")
            try context.save()
        } catch {
            print("Failed to save game: \(error.localizedDescription)")
        }
    }
}

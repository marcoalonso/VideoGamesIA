//
//  GameRepository.swift
//  VideogamesIAInt
//
//  Created by Marco Alonso Rodriguez on 07/02/25.
//

import CoreData

class GameRepository: GameRepositoryProtocol {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

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
    
    func deleteAllGames() {
        let request: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()

        do {
            let games = try context.fetch(request)
            for game in games {
                context.delete(game)
            }
            try context.save()
            print("Debug: deleteAllGames!")
        } catch {
            print("Failed to delete all games: \(error.localizedDescription)")
        }
    }

    
    func deleteGame(byID id: Int) {
        let request: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let gamesToDelete = try context.fetch(request)
            for game in gamesToDelete {
                context.delete(game)
            }
            try context.save()
        } catch {
            print("Failed to delete game: \(error.localizedDescription)")
        }
    }
    
    func updateGame(id: Int, title: String, genre: String, platform: String, releaseDate: String, developer: String, publisher: String, description: String) {
        let request: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            if let gameEntity = try context.fetch(request).first {
                gameEntity.title = title
                gameEntity.genre = genre
                gameEntity.platform = platform
                gameEntity.releaseDate = releaseDate
                gameEntity.developer = developer
                gameEntity.publisher = publisher
                gameEntity.shortDesc = description
                try context.save()
            }
        } catch {
            print("Failed to update game: \(error)")
        }
    }

}

//
//  GameMapper.swift
//  VideogamesIAInt
//
//  Created by Marco Alonso Rodriguez on 07/02/25.
//

import Foundation
import CoreData

struct GameMapper {
    static func fromDTO(_ dto: GameDTO) -> Game {
        return Game(
            id: dto.id,
            title: dto.title,
            thumbnail: dto.thumbnail,
            description: dto.shortDescription,
            gameURL: dto.gameURL,
            genre: dto.genre,
            platform: dto.platform,
            publisher: dto.publisher,
            developer: dto.developer,
            releaseDate: dto.releaseDate,
            profileURL: dto.profileURL
        )
    }
    
    static func fromDTOToEntity(_ dto: GameDTO, context: NSManagedObjectContext) -> GameEntity {
        let entity = GameEntity(context: context)
        entity.id = Int32(dto.id)
        entity.title = dto.title
        entity.thumbnail = dto.thumbnail
        entity.shortDesc = dto.shortDescription
        entity.gameURL = dto.gameURL
        entity.genre = dto.genre
        entity.platform = dto.platform
        entity.publisher = dto.publisher
        entity.developer = dto.developer
        entity.releaseDate = dto.releaseDate
        entity.profileURL = dto.profileURL
        return entity
    }

    static func fromEntity(_ entity: GameEntity) -> Game {
        return Game(
            id: Int(entity.id),
            title: entity.title ?? "",
            thumbnail: entity.thumbnail ?? "",
            description: entity.shortDesc ?? "",
            gameURL: entity.gameURL ?? "",
            genre: entity.genre ?? "",
            platform: entity.platform ?? "",
            publisher: entity.publisher ?? "",
            developer: entity.developer ?? "",
            releaseDate: entity.releaseDate ?? "",
            profileURL: entity.profileURL ?? ""
        )
    }

    static func fromEntities(_ entities: [GameEntity]) -> [Game] {
        return entities.map { fromEntity($0) }
    }
    
    static func toDTO(from game: Game) -> GameDTO {
        return GameDTO(
            id: game.id,
            title: game.title,
            thumbnail: game.thumbnail,
            shortDescription: game.description,
            gameURL: game.gameURL,
            genre: game.genre,
            platform: game.platform,
            publisher: game.publisher,
            developer: game.developer,
            releaseDate: game.releaseDate,
            profileURL: game.profileURL
        )
    }
}

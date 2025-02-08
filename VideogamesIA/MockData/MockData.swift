//
//  MockData.swift
//  VideogamesIAInt
//
//  Created by Marco Alonso Rodriguez on 07/02/25.
//

import Foundation

struct MockData {
    static let sampleGames: [Game] = [
        Game(
            id: 582,
            title: "Tarisland",
            thumbnail: "https://www.freetogame.com/g/582/thumbnail.jpg",
            description: "A cross-platform MMORPG developed by Level Infinite and Published by Tencent.",
            gameURL: "https://www.freetogame.com/open/tarisland",
            genre: "MMORPG",
            platform: "PC (Windows)",
            publisher: "Tencent",
            developer: "Level Infinite",
            releaseDate: "2024-06-22",
            profileURL: "https://www.freetogame.com/tarisland"
        ),
        Game(
            id: 540,
            title: "Overwatch 2",
            thumbnail: "https://www.freetogame.com/g/540/thumbnail.jpg",
            description: "A hero-focused first-person team shooter from Blizzard Entertainment.",
            gameURL: "https://www.freetogame.com/open/overwatch-2",
            genre: "Shooter",
            platform: "PC (Windows)",
            publisher: "Activision Blizzard",
            developer: "Blizzard Entertainment",
            releaseDate: "2022-10-04",
            profileURL: "https://www.freetogame.com/overwatch-2"
        ),
        Game(
            id: 516,
            title: "PUBG: BATTLEGROUNDS",
            thumbnail: "https://www.freetogame.com/g/516/thumbnail.jpg",
            description: "Get into the action in one of the longest running battle royale games PUBG Battlegrounds.",
            gameURL: "https://www.freetogame.com/open/pubg",
            genre: "Shooter",
            platform: "PC (Windows)",
            publisher: "KRAFTON, Inc.",
            developer: "KRAFTON, Inc.",
            releaseDate: "2022-01-12",
            profileURL: "https://www.freetogame.com/pubg"
        )
    ]
}

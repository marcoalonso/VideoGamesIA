//
//  Game.swift
//  VideogamesIAInt
//
//  Created by Marco Alonso Rodriguez on 07/02/25.
//

import Foundation

struct Game: Identifiable {
    let id: Int
    let title: String
    let thumbnail: String
    let description: String
    let gameURL: String
    let genre: String
    let platform: String
    let publisher: String
    let developer: String
    let releaseDate: String
    let profileURL: String
}


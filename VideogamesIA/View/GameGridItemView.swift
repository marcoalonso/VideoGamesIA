//
//  GameGridItemView.swift
//  VideogamesIA
//
//  Created by Marco Alonso Rodriguez on 07/02/25.
//

import SwiftUI

enum SearchFilter {
    case byTitle
    case byCategory
}

struct GameGridItemView: View {
    let game: Game

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: game.thumbnail)) { image in
                image.resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text(game.title)
                .font(.caption)
                .lineLimit(1)
                .multilineTextAlignment(.center)
        }
        .frame(width: 110)
    }
}


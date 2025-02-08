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
    var showGenre: Bool = false
    var imageSize: CGSize = CGSize(width: 120, height: 120)
    var containerWidth: CGFloat = 140

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: game.thumbnail)) { image in
                image.resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: imageSize.width, height: imageSize.height)
            .clipShape(RoundedRectangle(cornerRadius: 12))

            Text(game.title)
                .font(.system(size: 10).bold())
                .lineLimit(1)
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
            
            if showGenre {
                Text(game.genre)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .multilineTextAlignment(.center)
            }

        }
        .frame(width: containerWidth)
    }
}

struct GameGridItemView_Previews: PreviewProvider {
    static var previews: some View {
        GameGridItemView(
            game: Game(
                id: 1,
                title: "Tarisland",
                thumbnail: "https://www.freetogame.com/g/582/thumbnail.jpg",
                description: "A cross-platform MMORPG developed by Tencent.",
                gameURL: "https://www.freetogame.com/open/tarisland",
                genre: "MMORPG",
                platform: "PC",
                publisher: "Tencent",
                developer: "Level Infinite",
                releaseDate: "2024-06-22",
                profileURL: "https://www.freetogame.com/tarisland"
            ),
            imageSize: CGSize(width: 100, height: 100),
            containerWidth: 120
        )
    }
}
   


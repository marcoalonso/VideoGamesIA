//
//  GameRowView.swift
//  VideogamesIAInt
//
//  Created by Marco Alonso Rodriguez on 07/02/25.
//

import SwiftUI

struct GameRowView: View {
    let game: Game

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: game.thumbnail)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)
            .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(game.title)
                    .font(.headline)
                Text(game.genre)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct GameRowView_Previews: PreviewProvider {
    static var previews: some View {
        GameRowView(game: MockData.sampleGames[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

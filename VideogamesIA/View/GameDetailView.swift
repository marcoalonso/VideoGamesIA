//
//  GameDetailView.swift
//  VideogamesIAInt
//
//  Created by Marco Alonso Rodriguez on 07/02/25.
//

import SwiftUI

struct GameDetailView: View {
    let game: Game

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: game.thumbnail)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)
                .cornerRadius(12)

                Text(game.title)
                    .font(.largeTitle)
                    .bold()

                Text("Genre: \(game.genre)")
                    .font(.headline)
                    .foregroundColor(.secondary)

                Text("Platform: \(game.platform)")
                    .font(.headline)
                    .foregroundColor(.secondary)

                Text("Publisher: \(game.publisher)")
                    .font(.subheadline)

                Text("Developer: \(game.developer)")
                    .font(.subheadline)

                Text("Release Date: \(game.releaseDate)")
                    .font(.subheadline)

                Text(game.description)
                    .padding(.top)

                Link("View More", destination: URL(string: game.profileURL)!)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(.top)
            }
            .padding()
        }
        .navigationTitle("Game Detail")
    }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(game: MockData.sampleGames[0])
    }
}

//
//  GameListView.swift
//  VideogamesIAInt
//
//  Created by Marco Alonso Rodriguez on 07/02/25.
//

import SwiftUI

struct GameListView: View {
    @EnvironmentObject var viewModel: GameViewModel

    var body: some View {
        NavigationView {
            VStack {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                        .multilineTextAlignment(.center)
                }

                if viewModel.games.isEmpty && viewModel.errorMessage == nil {
                    ProgressView("Loading games...")
                        .padding()
                } else {
                    List(viewModel.games) { game in
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
            }
            .navigationTitle("Games")
            .onAppear {
                viewModel.loadGames()
            }
        }
    }
}

struct GameListView_Previews: PreviewProvider {
    static var previews: some View {
        GameListView()
            .environmentObject(GameViewModel())
    }
}

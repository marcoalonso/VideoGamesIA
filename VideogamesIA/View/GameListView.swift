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

                if viewModel.isLoading {
                    ProgressView("Loading games...")
                        .padding()
                } else if viewModel.games.isEmpty {
                    VStack {
                        Text("No games available.")
                            .foregroundColor(.gray)
                            .padding()

                        Image(systemName: "tray")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                            .padding()
                    }
                } else {
                    List {
                        ForEach(viewModel.games) { game in
                            NavigationLink(destination: GameDetailView(game: game)) {
                                GameRowView(game: game)
                            }
                        }
                    }
                    .refreshable {
                        viewModel.loadGamesFromAPI()
                    }
                }
            }
            .navigationTitle("Videogames")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.loadGamesFromAPI()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .font(.title2)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        viewModel.deleteAllGames()
                    }) {
                        Image(systemName: "trash")
                            .font(.title2)
                    }
                }
            }
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

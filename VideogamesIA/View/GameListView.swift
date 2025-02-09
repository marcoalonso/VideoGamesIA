//
//  GameListView.swift
//  VideogamesIAInt
//
//  Created by Marco Alonso Rodriguez on 07/02/25.
//

import SwiftUI

struct GameListView: View {
    @EnvironmentObject var viewModel: GameViewModel

    let gridColumns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

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
                    ScrollView {
                        LazyVGrid(columns: gridColumns, spacing: 16) {
                            ForEach(viewModel.games) { game in
                                NavigationLink(
                                    destination: GameDetailView(game: game, repository: viewModel.repository)
                                        
                                ) {
                                    GameGridItemView(game: game, imageSize: CGSize(width: 180, height: 140), containerWidth: 160)
                                }
                            }
                        }
                        .padding()
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
                            .font(.title3)
                            .foregroundStyle(.green)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        viewModel.deleteAllGames()
                    }) {
                        Image(systemName: "trash")
                            .font(.title3)
                            .foregroundStyle(.red)
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
            .environmentObject(
                GameViewModel(repository: MockGameRepository(),
                              service: MockGameService()))
    }
}

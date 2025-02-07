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
                        NavigationLink(destination: GameDetailView(game: game)) {
                            GameRowView(game: game)
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

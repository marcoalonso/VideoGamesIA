//
//  GameDetailView.swift
//  VideogamesIAInt
//
//  Created by Marco Alonso Rodriguez on 07/02/25.
//

import SwiftUI

struct GameDetailView: View {
    @EnvironmentObject var viewModel: GameViewModel
    let game: Game
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: game.thumbnail)) { image in
                image.resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 200)
            
            Text(game.title)
                .font(.largeTitle)
                .bold()
                .padding()
            
            Text(game.description)
                .padding()
            
            Spacer()
            
            Button("Delete Game") {
                viewModel.deleteGame(game)
            }
            .foregroundColor(.red)
            .padding()
        }
        .navigationTitle(game.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(game: MockData.sampleGames[0])
    }
}

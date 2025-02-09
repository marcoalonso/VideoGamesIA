//
//  GameEditView.swift
//  VideogamesIA
//
//  Created by Marco Alonso Rodriguez on 07/02/25.
//

import SwiftUI

struct GameEditView: View {
    @EnvironmentObject var viewModel: GameEditViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String
    @State private var genre: String
    @State private var platform: String
    @State private var releaseDate: String
    @State private var developer: String
    @State private var publisher: String
    @State private var description: String

    let game: Game

    init(game: Game) {
        self.game = game
        _title = State(initialValue: game.title)
        _genre = State(initialValue: game.genre)
        _platform = State(initialValue: game.platform)
        _releaseDate = State(initialValue: game.releaseDate)
        _developer = State(initialValue: game.developer)
        _publisher = State(initialValue: game.publisher)
        _description = State(initialValue: game.description)
    }

    var body: some View {
        Form {
            Section(header: Text("Details")) {
                LabeledTextField(label: "Title", placeholder: "Enter title", text: $title)
                LabeledTextField(label: "Genre", placeholder: "Enter genre", text: $genre)
                LabeledTextField(label: "Platform", placeholder: "Enter platform", text: $platform)
                LabeledTextField(label: "Release Date", placeholder: "Enter release date", text: $releaseDate)
                LabeledTextField(label: "Developer", placeholder: "Enter developer", text: $developer)
                LabeledTextField(label: "Publisher", placeholder: "Enter publisher", text: $publisher)
            }
            
            Section(header: Text("Description")) {
                TextEditor(text: $description)
                    .frame(height: 150)
            }

            Button(action: {
                saveChanges()
            }) {
                Label("Save Changes", systemImage: "checkmark")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
        }
        .navigationTitle("Edit Game")
    }

    private func saveChanges() {
        viewModel.updateGame(
            game: game,
            newTitle: title,
            newGenre: genre,
            newPlatform: platform,
            newReleaseDate: releaseDate,
            newDeveloper: developer,
            newPublisher: publisher,
            newDescription: description
        )
        presentationMode.wrappedValue.dismiss()
    }
}


#Preview {
    GameEditView(game: MockData.sampleGames[0])
}

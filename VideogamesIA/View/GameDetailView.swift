//
//  GameDetailView.swift
//  VideogamesIAInt
//
//  Created by Marco Alonso Rodriguez on 07/02/25.
//

import SwiftUI
import SafariServices

struct GameDetailView: View {
    @StateObject private var viewModel: GameDetailViewModel
    @Environment(\.dismiss) var dismiss
    let gameID: Int
    
    init(game: Game, repository: GameRepositoryProtocol) {
        _viewModel = StateObject(wrappedValue:
                                    GameDetailViewModel(repository: repository,
                                                        gameID: game.id))
        self.gameID = game.id
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                if let game = viewModel.game {
                    AsyncImage(url: URL(string: game.thumbnail)) { image in
                        image.resizable()
                            .scaledToFill()
                            .frame(height: 220)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(radius: 6)
                            .padding(.horizontal, 12)
                            .scaleEffect(viewModel.isAnimating ? 1 : 0.75)
                            .animation(.easeInOut(duration: 0.5), value: viewModel.isAnimating)
                            .onAppear {
                                withAnimation {
                                    viewModel.isAnimating = true
                                }
                            }
                    } placeholder: {
                        ProgressView()
                    }
                    
                    VStack(spacing: 8) {
                        GameDetailInfoRow(iconName: "tag", text: "Genre: \(game.genre)")
                        GameDetailInfoRow(iconName: "desktopcomputer", text: "Platform: \(game.platform)")
                        GameDetailInfoRow(iconName: "calendar", text: "Release Date: \(game.releaseDate)")
                        GameDetailInfoRow(iconName: "person.circle", text: "Developer: \(game.developer)")
                        GameDetailInfoRow(iconName: "building.2", text: "Publisher: \(game.publisher)")
                        
                        Button(action: {
                            viewModel.safariURL = URL(string: game.profileURL)
                        }) {
                            GameDetailInfoRow(iconName: "inset.filled.rectangle.and.person.filled", text: "Profile Website")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)
                    
                    Text(game.description)
                        .font(.body)
                        .padding()
                    
                    Button(action: {
                        viewModel.safariURL = URL(string: game.gameURL)
                    }) {
                        Label("Visit Website", systemImage: "safari")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 1))
                    }
                    .padding(.horizontal)
                    
                    NavigationLink(destination: GameEditView(game: game).environmentObject(GameEditViewModel(repository: viewModel.repository))) {
                        Label("Edit Game", systemImage: "pencil")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        viewModel.showDeleteConfirmation = true
                    }) {
                        Label("Delete Game", systemImage: "trash")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    .alert("Delete Game", isPresented: $viewModel.showDeleteConfirmation) {
                        Button("Cancel", role: .cancel) {}
                        Button("Delete", role: .destructive) {
                            viewModel.deleteGame()
                            dismiss()
                        }
                    } message: {
                        Text("Are you sure you want to delete this game?")
                    }
                } else {
                    ProgressView("Loading game details...")
                        .padding()
                }
            }
            .padding()
        }
        .navigationTitle(viewModel.game?.title ?? "Game Detail")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $viewModel.safariURL) { url in
            SafariView(url: url)
        }
        .onAppear {
            viewModel.reloadGame()
        }
    }
}



struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(game: MockData.sampleGames[2],
                       repository: MockGameRepository())
    }
}


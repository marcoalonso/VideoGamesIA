//
//  GameDetailView.swift
//  VideogamesIAInt
//
//  Created by Marco Alonso Rodriguez on 07/02/25.
//

import SwiftUI
import SafariServices

struct GameDetailView: View {
    @EnvironmentObject var viewModel: GameViewModel
    let game: Game
    @State private var isAnimating = false
    @State private var showWebView = false
    @State private var showDeleteConfirmation = false

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: game.thumbnail)) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 6)
                        .padding(.horizontal, 12)
                        .scaleEffect(isAnimating ? 1 : 0.75)
                        .animation(.easeInOut(duration: 0.5), value: isAnimating)
                        .onAppear {
                            withAnimation {
                                isAnimating = true
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
                }
                .padding(.horizontal)

                Text(game.description)
                    .font(.body)
                    .padding()

                HStack {
                    Button(action: {
                        showWebView = true
                    }) {
                        Label("Visit Website", systemImage: "safari")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 1))
                    }
                    .padding()

                    Button(action: {
                        showDeleteConfirmation = true
                    }) {
                        Label("Delete Game", systemImage: "trash")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(8)
                    }
                }
            }
            .padding(.horizontal, 12)
            .alert("Delete Game", isPresented: $showDeleteConfirmation) {
                Button("Cancel", role: .cancel) {}
                Button("Delete", role: .destructive) {
                    deleteGame()
                }
            } message: {
                Text("Are you sure you want to delete this game?")
            }
        }
        .navigationTitle(game.title)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showWebView) {
            SafariView(url: URL(string: game.gameURL)!)
        }
    }
    
    private func deleteGame() {
        viewModel.deleteGame(game)
    }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(game: Game(
            id: 1,
            title: "Tarisland",
            thumbnail: "https://www.freetogame.com/g/582/thumbnail.jpg",
            description: "A cross-platform MMORPG developed by Tencent.",
            gameURL: "https://www.freetogame.com/open/tarisland",
            genre: "MMORPG",
            platform: "PC (Windows)",
            publisher: "Tencent",
            developer: "Level Infinite",
            releaseDate: "2024-06-22",
            profileURL: "https://www.freetogame.com/tarisland"
        ))
        .environmentObject(GameViewModel())
    }
}


//
//  GameSearchView.swift
//  VideoGamesIAInt
//
//  Created by Marco Alonso Rodriguez on 07/02/25.
//

import SwiftUI

struct GameSearchView: View {
    @EnvironmentObject var viewModel: GameViewModel
    @State private var searchText: String = ""
    @State private var selectedFilter: SearchFilter = .byTitle

    let gridColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            VStack {
                Picker("Search Filter", selection: $selectedFilter) {
                    Text("By Title").tag(SearchFilter.byTitle)
                    Text("By Category").tag(SearchFilter.byCategory)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                TextField("Search by \(selectedFilter == .byTitle ? "games" : "categories")", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if searchText.isEmpty {
                    Image(.search)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                } else {
                    ScrollView {
                        LazyVGrid(columns: gridColumns, spacing: 16) {
                            ForEach(filteredSuggestions, id: \.id) { game in
                                NavigationLink(destination: GameDetailView(game: game, repository: viewModel.repository)) {
                                    GameGridItemView(game: game, showGenre: selectedFilter == .byCategory)
                                        .transition(.scale.combined(with: .opacity))
                                }
                                .animation(.easeInOut(duration: 0.3), value: filteredSuggestions)
                            }
                        }
                        .padding()
                    }
                }

                Spacer()
            }
            .onAppear(perform: {
                searchText = ""
            })
            .navigationTitle("Search Videogames")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var filteredSuggestions: [Game] {
        switch selectedFilter {
        case .byTitle:
            return viewModel.games.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        case .byCategory:
            return viewModel.games.filter { $0.genre.lowercased().contains(searchText.lowercased()) }
        }
    }
}

struct GameSearchView_Previews: PreviewProvider {
    static var previews: some View {
        GameSearchView()
            .environmentObject(
                GameViewModel(repository: MockGameRepository(),
                              service: MockGameService()))
    }
}

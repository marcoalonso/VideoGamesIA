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
                } else {
                    List(filteredSuggestions, id: \.id) { game in
                        NavigationLink(destination: GameDetailView(game: game)) {
                            GameRowView(game: game)
                        }
                    }
                }
                
                Spacer()
            }
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

enum SearchFilter {
    case byTitle
    case byCategory
}

struct GameSearchView_Previews: PreviewProvider {
    static var previews: some View {
        GameSearchView()
            .environmentObject(GameViewModel())
    }
}

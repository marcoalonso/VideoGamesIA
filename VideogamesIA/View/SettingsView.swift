//
//  ConfiguracionView.swift
//  GasTracky
//
//  Created by Marco Alonso on 04/11/24.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @AppStorage("useFaceID") private var useFaceID: Bool = false
    @State private var showSafariView = false
    @State private var showDeleteConfirmation = false
    @EnvironmentObject var viewModel: GameViewModel

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Preferences")) {
                    Toggle("Dark mode", isOn: $isDarkMode)
                        .onChange(of: isDarkMode) { _, _ in
                            updateAppearance()
                        }
                }

                Section(header: Text("Developer")) {
                    Button(action: {
                        showSafariView = true
                    }) {
                        HStack {
                            Image(systemName: "person.circle")
                                .foregroundColor(.blue)
                            Text("Marco Alonso Rodriguez")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .sheet(isPresented: $showSafariView) {
            SafariView(url: URL(string: "https://github.com/marcoalonso")!)
        }
    }

    private func updateAppearance() {
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
    }
}


#Preview {
    SettingsView()
}
    

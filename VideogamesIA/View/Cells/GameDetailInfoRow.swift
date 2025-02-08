//
//  GameDetailInfoRow.swift
//  VideogamesIA
//
//  Created by Marco Alonso Rodriguez on 07/02/25.
//

import SwiftUI

struct GameDetailInfoRow: View {
    let iconName: String
    let text: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.blue)
            Text(text)
                .font(.subheadline)
            Spacer()
        }
    }
}

#Preview {
    GameDetailInfoRow(iconName: "person.circle", text: "Marco Alonso")
}

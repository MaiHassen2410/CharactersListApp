//
//  CharacterCard.swift
//  CharactersListApp
//
//  Created by Mai Hassen on 04/12/2024.
//

import SwiftUI


struct CharacterCard: View {
    let character: Character

    var body: some View {
        HStack(spacing: 16) {
            // Character Image
            AsyncImage(url: URL(string: character.image)) { image in
                image.resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .shadow(radius: 6)
            } placeholder: {
                ProgressView()
                    .frame(width: 85, height: 85)
            }
            .frame(width: 85, height: 85)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.darkBlue, lineWidth: 2))

            // Character Text Info
            VStack(alignment: .leading, spacing: 8) {
                Text(character.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.darkBlue)
                    .lineLimit(1)

                Text(character.species)
                    .font(.subheadline)
                    .foregroundColor(.darkBlue)
            }

            Spacer()
        }
        .padding(40)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    // Set background color based on the character's status
                    Utilities.shared.getBackgroundColor(for: character.status)
                )
                .shadow(radius: 8)
                .padding()
        )
      
    }


}

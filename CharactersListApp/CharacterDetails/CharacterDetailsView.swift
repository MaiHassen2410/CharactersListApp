//
//  CharacterDetailsView.swift
//  CharactersListApp
//
//  Created by Mai Hassen on 04/12/2024.
//

import SwiftUI



struct CharacterDetailView: View {
    @StateObject private var viewModel: CharacterDetailsViewModel

    init(viewModel: CharacterDetailsViewModel) {
           _viewModel = StateObject(wrappedValue: viewModel)
       }
 
    var body: some View {
        VStack(alignment: .leading,spacing: 16) {
            // Full-Width Image with Rounded Corners
            AsyncImage(url: URL(string: viewModel.character.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity) // Full width
                    .frame(height: 300) // Adjust height as needed
                    .clipped() // Ensures content stays within the frame
                    .cornerRadius(25) // Rounded corners
            } placeholder: {
                ProgressView()
                    .frame(height: 300)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(25)
            }
            .padding(.horizontal)

            // Name and Status in a Row
            nameAndStatusRow

            // Species and Gender
            Text("\(viewModel.character.species) • \(viewModel.character.gender)")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.horizontal)

            // Location Row
            locationRow
            Spacer()
        }
        .padding(.top)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        
        }
   
    var nameAndStatusRow: some View {
        HStack () {
            Text(viewModel.character.name)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.black)
            
        Spacer()
            
            Text(viewModel.character.status)
                .font(.subheadline)
                .foregroundColor(.black)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Utilities.shared.getBackgroundColor(for: viewModel.character.status))
                )
        }
        .padding(.horizontal)
    }
    
    var locationRow: some View {
        HStack {
            Text("Location:")
                .font(.headline)
                .foregroundColor(.black)

           

            Text("Earth") // Replace with actual location data if available
                .font(.body)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
    
}

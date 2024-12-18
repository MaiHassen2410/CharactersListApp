//
//  FilterView.swift
//  CharactersListApp
//
//  Created by Mai Hassen on 03/12/2024.
//

import SwiftUI

struct FilterView: View {
    @ObservedObject var viewModel: CharacterListViewModel
    
    var body: some View {
        HStack(spacing: 10) {
            FilterButton(title: "All", isSelected: viewModel.selectedFilter == .all) {
                viewModel.selectedFilter = .all
            }
            FilterButton(title: "Alive", isSelected: viewModel.selectedFilter == .alive) {
                viewModel.selectedFilter = .alive
            }
            FilterButton(title: "Dead", isSelected: viewModel.selectedFilter == .dead) {
                viewModel.selectedFilter = .dead
            }
            FilterButton(title: "Unknown", isSelected: viewModel.selectedFilter == .unknown) {
                viewModel.selectedFilter = .unknown
            }
        }
      
        .frame(maxWidth: .infinity, alignment: .leading) // Align the content to the leading edge
        .frame(maxHeight: .infinity, alignment: .center)
                  .padding([.trailing, .bottom], 5) // Remove padding from the trailing and bottom sides
                  .padding([.leading, .top], 12) // Ensure no padding from leading and top
           
               
    }
}


struct FilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    @State private var cornerRadius: CGFloat = 20 // Corner radius dynamically calculated

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(isSelected ? .white : .accentColor)
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background(isSelected ? Color.accentColor : Color.white)
                .cornerRadius(cornerRadius)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                .scaleEffect(isSelected ? 1.05 : 1.0)
                .animation(.easeInOut(duration: 0.2), value: isSelected)  
                .overlay( // Add border with rounded corners
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color.accentColor, lineWidth: 1)
                )
        }
        .buttonStyle(PlainButtonStyle()) // Disable the default button styling
        .frame(height: 40)

    }
}





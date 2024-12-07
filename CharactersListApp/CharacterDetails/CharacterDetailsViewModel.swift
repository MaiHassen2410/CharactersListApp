//
//  CharacterDetailsViewModel.swift
//  CharactersListApp
//
//  Created by Mai Hassen on 04/12/2024.
//

import Foundation
class CharacterDetailsViewModel : ObservableObject{
    let character: Character

    init(character: Character) {
        self.character = character
    }
}

//
//  Character.swift
//  CharactersListApp
//
//  Created by Mai Hassen on 03/12/2024.
//

import Foundation

struct ResponseWrapper<T: Codable>: Codable {
    let results: [T]
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
}

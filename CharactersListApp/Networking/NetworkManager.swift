//
//  NetworkManager.swift
//  CharactersListApp
//
//  Created by Mai Hassen on 03/12/2024.
//

import Foundation
import Moya


class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    let provider = MoyaProvider<RickAndMortyAPI>()
}

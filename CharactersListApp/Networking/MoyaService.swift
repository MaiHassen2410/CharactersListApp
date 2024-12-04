//
//  MoyaService.swift
//  CharactersListApp
//
//  Created by Mai Hassen on 03/12/2024.
//

import Foundation
import Moya


enum RickAndMortyAPI {
    case getCharacters(page: Int)
}

extension RickAndMortyAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://rickandmortyapi.com/api")!
    }

    var path: String {
        switch self {
        case .getCharacters:
            return "/character"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .getCharacters(let page):
            return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}

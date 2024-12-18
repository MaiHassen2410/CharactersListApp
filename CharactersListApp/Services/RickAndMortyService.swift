//
//  CharacterService.swift
//  CharactersListApp
//
//  Created by Mai Hassen on 03/12/2024.
//

import Foundation
import Moya
import Combine

 protocol RickAndMortyServiceProtocol {
    func fetchCharacters(page: Int) -> AnyPublisher<ResponseWrapper<Character>, Error>
}

// RickAndMortyService.swift
 class RickAndMortyService: RickAndMortyServiceProtocol {
    private let provider: MoyaProvider<RickAndMortyAPI>
    
    init(provider: MoyaProvider<RickAndMortyAPI> = MoyaProvider<RickAndMortyAPI>()) {
        self.provider = provider
    }

    func fetchCharacters(page: Int) -> AnyPublisher<ResponseWrapper<Character>, Error> {
        return Future { [weak self] promise in
            guard let self = self else {
                promise(.failure(NSError(domain: "Service deallocated", code: -1, userInfo: nil)))
                return
            }
            
            self.provider.request(.getCharacters(page: page)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decodedData = try JSONDecoder().decode(ResponseWrapper<Character>.self, from: response.data)
                        promise(.success(decodedData))
                    } catch {
                        promise(.failure(error))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

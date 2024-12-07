//
//  MockRickAndMortyService.swift
//  CharactersListAppTests
//
//  Created by Mai Hassen on 07/12/2024.
//

import Foundation
import Combine
@testable import CharactersListApp

// Mock service implementation
class MockRickAndMortyService: RickAndMortyServiceProtocol {
    private let mockData: ResponseWrapper<Character>
    
    init(mockData: ResponseWrapper<Character>) {
        self.mockData = mockData
    }

    func fetchCharacters(page: Int) -> AnyPublisher<ResponseWrapper<Character>, Error> {
        return Just(mockData)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

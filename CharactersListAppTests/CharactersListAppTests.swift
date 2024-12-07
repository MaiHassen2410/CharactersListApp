//
//  CharactersListAppTests.swift
//  CharactersListAppTests
//
//  Created by Mai Hassen on 03/12/2024.
//

import XCTest
@testable import CharactersListApp
import Combine

class CharacterListViewModelTests: XCTestCase {
    var viewModel: CharacterListViewModel!
    var mockService: MockRickAndMortyService!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        // Create mock data
        let mockCharactersJSON = ResponseWrapper<Character>(results: [
            Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", gender: "Male", image: ""),
            Character(id: 2, name: "Morty Smith", status: "Alive", species: "Human", gender: "Male", image: "")
        ])

        // Use mock service that conforms to the protocol
        mockService = MockRickAndMortyService(mockData: mockCharactersJSON)
        viewModel = CharacterListViewModel(service: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testFetchCharacters() {
        let expectation = XCTestExpectation(description: "Characters fetched")

        // Trigger the fetch
        viewModel.fetchCharacters()

        // Observe the characters published
        viewModel.$characters
            .dropFirst()  // Drop the initial empty state
            .sink { characters in
                // Verify the fetched characters
                XCTAssertEqual(characters.count, 2)
                XCTAssertEqual(characters.first?.name, "Rick Sanchez")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
    }
}


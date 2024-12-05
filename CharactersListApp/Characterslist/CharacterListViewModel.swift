//
//  CharacterListViewModel.swift
//  CharactersListApp
//
//  Created by Mai Hassen on 03/12/2024.
//


import Moya
import Foundation
import Combine

class CharacterListViewModel: ObservableObject {
    private let service: RickAndMortyService
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var characters: [Character] = []
    @Published var filteredCharacters: [Character] = []
    @Published var selectedFilter: CharacterStatus = .all

    // A Combine subject for character selection
    let characterSelected = PassthroughSubject<Character, Never>()
    
    private var currentPage = 1

    init(service: RickAndMortyService) {
        self.service = service
        bindFilterToCharacters()
    }

    func fetchCharacters() {
        service.fetchCharacters(page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching characters: \(error)")
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.characters.append(contentsOf: response.results)
                self.currentPage += 1
                self.updateFilteredCharacters()
            })
            .store(in: &cancellables)
    }

    private func bindFilterToCharacters() {
        $selectedFilter
            .combineLatest($characters)
            .map { filter, allCharacters in
                switch filter {
                case .all:
                    return allCharacters
                default:
                    return allCharacters.filter { $0.status.lowercased() == filter.rawValue.lowercased() }
                }
            }
            .assign(to: &$filteredCharacters)
    }

    private func updateFilteredCharacters() {
        filteredCharacters = characters.filter {
            selectedFilter == .all || $0.status.lowercased() == selectedFilter.rawValue.lowercased()
        }
    }

}

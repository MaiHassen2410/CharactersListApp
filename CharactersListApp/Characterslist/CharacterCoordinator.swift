//
//  CharacterCoordinator.swift
//  CharactersListApp
//
//  Created by Mai Hassen on 03/12/2024.
//

import Foundation
import UIKit
import Combine

class CharacterCoordinator: Coordinator {
    var navigationController: UINavigationController
    private var cancellables = Set<AnyCancellable>()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = CharacterListViewModel(service: RickAndMortyService())
        let listViewController = CharacterListViewController(viewModel: viewModel, coordinator: DetailsCoordinator(navigationController: navigationController))
        navigationController.pushViewController(listViewController, animated: true)

        // Subscribe to characterSelected
        viewModel.characterSelected
            .sink { [weak self] character in
                self?.openDetails(for: character)
            }
            .store(in: &cancellables)
    }

    func openDetails(for character: Character) {
        let detailsCoordinator = DetailsCoordinator(navigationController: navigationController)
        detailsCoordinator.start(with: character)
    }
}

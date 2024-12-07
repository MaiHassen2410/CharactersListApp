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
    internal var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = CharacterListViewModel(service: RickAndMortyService())
        let listViewController = CharacterListViewController(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(listViewController, animated: true)
    }

    func openDetails(for character: Character) {
        let detailsCoordinator = DetailsCoordinator(navigationController: navigationController)
        addChildCoordinator(detailsCoordinator)

        detailsCoordinator.completionPublisher
            .sink { [weak self, weak detailsCoordinator] _ in
                guard let self = self, let detailsCoordinator = detailsCoordinator else { return }
                self.removeChildCoordinator(detailsCoordinator)
            }
            .store(in: &cancellables)
        detailsCoordinator.start(with: character)
    }
}

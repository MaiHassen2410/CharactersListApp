//
//  DetailsCoordinator.swift
//  CharactersListApp
//
//  Created by Mai Hassen on 04/12/2024.
//

import Foundation
import UIKit
import SwiftUI
import Combine

class DetailsCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    private var cancellables = Set<AnyCancellable>()

    /// Publisher to notify when this coordinator is finished
     let completionPublisher = PassthroughSubject<Void, Never>()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        // Empty start method (No operation for the base start)
    }

    func start(with character: Character) {
        let viewModel = CharacterDetailsViewModel(character: character)
        let detailsView = CharacterDetailView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: detailsView)

        navigationController.pushViewController(hostingController, animated: true)

        // Monitor when the view controller is popped from the navigation stack
      
        navigationController.publisher(for: \.viewControllers)
            .sink { [weak self] viewControllers in
                guard let self = self else { return }

                    completionPublisher.send()
                    self.pop()
         
            }
            .store(in: &cancellables)

        
    }
    
    
    func pop() {
        // Send completion
        completionPublisher.send(completion: .finished)
        // Remove all references to avoid memory leaks
        cancellables.removeAll()
        childCoordinators.removeAll()
    }

}
 




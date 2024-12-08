//
//  CharacterListViewController.swift
//  CharactersListApp
//
//  Created by Mai Hassen on 03/12/2024.
//

import UIKit
import Combine
import SwiftUI

class CharacterListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterContainerView: UIView!

    private let viewModel: CharacterListViewModel
    private let coordinator: Coordinator
    private var filterViewHostingController: UIHostingController<FilterView>?
    private var cancellables: Set<AnyCancellable> = []

    init(viewModel: CharacterListViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: "CharacterListViewController", bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupFilterView()
        bindViewModel()
        viewModel.fetchCharacters()
    }
    

    private func setupFilterView() {
        let filterView = FilterView(viewModel: viewModel)
        filterViewHostingController = UIHostingController(rootView: filterView)
        guard let filterController = filterViewHostingController else { return }
        addChild(filterController)
        filterController.view.frame = filterContainerView.bounds
        filterContainerView.addSubview(filterController.view)
        filterController.didMove(toParent: self)
    }

    private func bindViewModel() {
        // Reload table view when filtered characters change
        viewModel.$filteredCharacters
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        // Navigate to details when a character is selected
        viewModel.characterSelected
                  .sink { [weak self] character in
                      guard let coordinator = self?.coordinator as? CharacterCoordinator else { return }
                      coordinator.openDetails(for: character)
                  }
                  .store(in: &cancellables)
        
        viewModel.$selectedFilter
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                
                if self?.viewModel.filteredCharacters.count ?? 0 > 0 {
                    self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
            }
            .store(in: &cancellables)
      
    }



}


extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = viewModel.filteredCharacters[indexPath.row]
        viewModel.characterSelected.send(character) // Notify the ViewModel
    }
}

extension CharacterListViewController {
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self // Add UITableViewDelegate
        tableView.prefetchDataSource = self
        tableView.allowsSelection = true // Ensure selection is enabled
    }
}

extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCharacters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let character = viewModel.filteredCharacters[indexPath.row]
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CharacterRowCell")
        let hostingController = UIHostingController(rootView: CharacterCard(character: character))

        // Add the SwiftUI view to the cell
        cell.contentView.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
        ])

        cell.selectionStyle = .default
        cell.isUserInteractionEnabled = true

        return cell
    }
    
}


extension CharacterListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let rows = indexPaths.map { $0.row }
        if rows.contains(viewModel.filteredCharacters.count - 1) {
            viewModel.fetchCharacters()
        }
    }
}

//
//  Coordinator.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 13/01/2025.
//

import UIKit
import SwiftUI

final class Coordinator {
    private let navigationController: UINavigationController
    private let viewModel: PokemonListViewModel

    init(navigationController: UINavigationController, viewModel: PokemonListViewModel) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }

    func start() {
        let pokemonListViewController = PokemonListViewController(viewModel: viewModel, coordinator: self)
        navigationController.setViewControllers([pokemonListViewController], animated: false)
    }

    func showPokemonDetail(for pokemon: Pokemon) {
        let detailView = PokemonDetailView(pokemon: pokemon)
        let hostingController = UIHostingController(rootView: detailView)
        navigationController.pushViewController(hostingController, animated: true)
    }
}

//
//  PokemonListViewControllerWrapper.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 12/01/2025.
//

import SwiftUI
import UIKit

struct PokemonListViewControllerWrapper: UIViewControllerRepresentable {
    @ObservedObject var viewModel: PokemonListViewModel
    private let navigationController = UINavigationController()

    func makeUIViewController(context: Context) -> UINavigationController {
        let coordinator = context.coordinator
        coordinator.start()
        return navigationController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(navigationController: navigationController, viewModel: viewModel)
    }
}

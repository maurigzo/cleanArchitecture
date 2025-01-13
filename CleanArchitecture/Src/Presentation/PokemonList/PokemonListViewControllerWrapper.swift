//
//  PokemonListViewControllerWrapper.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 12/01/2025.
//

import SwiftUI
import UIKit

struct PokemonListViewControllerWrapper: UIViewControllerRepresentable {
    let viewModel: PokemonListViewModel

    func makeUIViewController(context: Context) -> PokemonListViewController {
        PokemonListViewController(viewModel: viewModel)
    }

    func updateUIViewController(_ uiViewController: PokemonListViewController, context: Context) {}
}

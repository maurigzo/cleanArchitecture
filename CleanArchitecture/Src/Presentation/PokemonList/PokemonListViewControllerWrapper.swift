import SwiftUI
import UIKit

struct PokemonListViewControllerWrapper: UIViewControllerRepresentable {
    let viewModel: PokemonListViewModel // Tu ViewModel de Combine para la lista

    func makeUIViewController(context: Context) -> PokemonListViewController {
        let viewController = PokemonListViewController()
        viewController.viewModel = viewModel
        return viewController
    }

    func updateUIViewController(_ uiViewController: PokemonListViewController, context: Context) {
        // Aquí puedes sincronizar cambios del ViewModel o de SwiftUI hacia el UIViewController
    }
}

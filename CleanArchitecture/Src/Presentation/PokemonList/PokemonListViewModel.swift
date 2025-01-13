//
//  PokemonListViewModel.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 12/01/2025.
//

import Combine
import Foundation

class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    private let repository: PokemonListRepositoryType
//    private let coordinator: AppCoordinator
    private var cancellables = Set<AnyCancellable>()

    init(repository: PokemonListRepositoryType = PokemonRepository()/*, coordinator: AppCoordinator*/) {
        self.repository = repository
//        self.coordinator = coordinator
    }

    func fetchPokemonList() {
        repository.fetchPokemonList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching Pokémon list: \(error)")
                }
            }, receiveValue: { [weak self] pokemons in
                self?.pokemons = pokemons
            })
            .store(in: &cancellables)
    }

    func didSelectPokemon(_ pokemon: Pokemon) {
//        coordinator.navigateToPokemonDetail(pokemon: pokemon)
    }
}

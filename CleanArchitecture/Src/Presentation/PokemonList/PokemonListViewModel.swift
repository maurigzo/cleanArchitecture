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
    @Published var pokemonTypes: [PokemonType] = []
    private let fetchPokemonListUseCase: FetchPokemonListUseCaseType
    private let fetchPokemonTypesUseCase: FetchPokemonTypesUseCaseType
    private var cancellables = Set<AnyCancellable>()

    init(
        fetchPokemonListUseCase: FetchPokemonListUseCaseType = FetchPokemonListUseCase(),
        fetchPokemonTypesUseCase: FetchPokemonTypesUseCaseType = FetchPokemonTypesUseCase()
    ) {
        self.fetchPokemonListUseCase = fetchPokemonListUseCase
        self.fetchPokemonTypesUseCase = fetchPokemonTypesUseCase
    }

    func fetchPokemonList() {
        fetchPokemonListUseCase.execute()
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
    
    func fetchPokemonTypes() {
        fetchPokemonTypesUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching Pokémon list: \(error)")
                }
            }, receiveValue: { [weak self] pokemonTypes in
                self?.pokemonTypes = pokemonTypes
            })
            .store(in: &cancellables)
    }
}

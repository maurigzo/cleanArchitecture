//
//  PokemonListViewModel.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 12/01/2025.
//

import Combine
import Foundation
import UIKit

class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    private let fetchPokemonListUseCase: FetchPokemonListUseCaseType
    private let pokemonDataSource: PokemonDataSourceType
    private var cancellables = Set<AnyCancellable>()
    
    init(
        fetchPokemonListUseCase: FetchPokemonListUseCaseType = FetchPokemonListUseCase(),
        pokemonDataSource: PokemonDataSourceType = PokemonDataSource()
    ) {
        self.fetchPokemonListUseCase = fetchPokemonListUseCase
        self.pokemonDataSource = pokemonDataSource
    }
    
    func fetchPokemonList() {
        fetchPokemonListUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching Pokémon list: \(error)")
                }
            }, receiveValue: { [weak self] pokemons in
                guard let self = self else { return }
                self.pokemons = pokemons.sorted { $0.id < $1.id }
                self.downloadImages(for: pokemons)
            })
            .store(in: &cancellables)
    }
    
    private func downloadImages(for pokemons: [Pokemon]) {
        let imagePublishers = pokemons.map { pokemon in
            pokemonDataSource.downloadImage(from: pokemon.imageURL, key: "\(pokemon.id)")
                .catch { _ in Just(UIImage(named: "placeholder") ?? UIImage()) }
                .map { image -> Pokemon in
                    var updatedPokemon = pokemon
                    updatedPokemon.image = image
                    return updatedPokemon
                }
        }
        Publishers.MergeMany(imagePublishers)
            .collect()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] updatedPokemons in
                self?.pokemons = updatedPokemons.sorted { $0.id < $1.id }
            })
            .store(in: &cancellables)
    }
}


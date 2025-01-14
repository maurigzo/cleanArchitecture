//
//  FetchPokemonListUseCase.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 11/01/2025.
//

import Combine

final class FetchPokemonListUseCase: FetchPokemonListUseCaseType {
    private let pokemonListRepository: PokemonListRepositoryType
    
    init(pokemonListRepository: PokemonListRepositoryType = PokemonListRepository()) {
        self.pokemonListRepository = pokemonListRepository
    }

    func execute() -> AnyPublisher<[Pokemon], DomainError> {
        pokemonListRepository.fetchPokemonList()
    }
}

//
//  FetchPokemonTypesUseCase.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 13/01/2025.
//

import Combine

final class FetchPokemonTypesUseCase: FetchPokemonTypesUseCaseType {
    private let pokemonTypeRepository: PokemonTypeRepositoryType
    
    init(pokemonTypeRepository: PokemonTypeRepositoryType = PokemonTypeRepository()) {
        self.pokemonTypeRepository = pokemonTypeRepository
    }
    
    func execute() -> AnyPublisher<[PokemonType], DomainError> {
        pokemonTypeRepository.fetchPokemonTypes()
    }
}

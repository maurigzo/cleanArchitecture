//
//  PokemonListRepository.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 11/01/2025.
//

import Combine

final class PokemonListRepository: PokemonListRepositoryType {
    private let dataSource: PokemonDataSourceType
    private let errorMapper: DomainErrorMapper

    init(dataSource: PokemonDataSourceType = PokemonDataSource(), errorMapper: DomainErrorMapper = DomainErrorMapper()) {
        self.dataSource = dataSource
        self.errorMapper = errorMapper
    }

    func fetchPokemonList() -> AnyPublisher<[Pokemon], DomainError> {
        dataSource.fetchPokemonDetails()
            .map { pokemonDetails in
                pokemonDetails.map { pokemonDTO in
                    Pokemon.build(from: pokemonDTO)
                }
            }
            .catch{ [weak self] error in
                let domainError = self?.errorMapper.map(error: error)
                return Fail<[Pokemon], DomainError>(error: domainError ?? .generic)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

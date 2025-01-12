//
//  PokemonRepository.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 11/01/2025.
//

import Combine

final class PokemonRepository: PokemonListRepositoryType {
    private let dataSource: PokemonDataSourceType
    private let errorMapper: DomainErrorMapper

    init(dataSource: PokemonDataSourceType, errorMapper: DomainErrorMapper) {
        self.dataSource = dataSource
        self.errorMapper = errorMapper
    }

    func fetchPokemonList() async -> AnyPublisher<[Pokemon], DomainError> {
        await dataSource.fetchPokemonDetails()
            .map { pokemonDetails in
                pokemonDetails.map { pokemonDTO in
                    Pokemon(id: pokemonDTO.id, name: pokemonDTO.name)
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

final class DomainErrorMapper {
    func map(error: HTTPClientError?) -> DomainError {
        return .generic
    }
}

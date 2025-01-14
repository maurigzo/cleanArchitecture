//
//  PokemonTypeRepository.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 13/01/2025.
//

import Combine

final class PokemonTypeRepository: PokemonTypeRepositoryType {
    private let dataSource: PokemonDataSourceType
    private let errorMapper: DomainErrorMapper
    
    init(dataSource: PokemonDataSourceType = PokemonDataSource(), errorMapper: DomainErrorMapper = DomainErrorMapper()) {
        self.dataSource = dataSource
        self.errorMapper = errorMapper
    }
    
    func fetchPokemonTypes() -> AnyPublisher<[PokemonType], DomainError> {
        dataSource.fetchPokemonTypesDetails()
            .map { pokemonTypes in
                pokemonTypes.map { dto in
                    PokemonType.build(from: dto)
                }
            }
            .catch{ [weak self] error in
                let domainError = self?.errorMapper.map(error: error)
                return Fail<[PokemonType], DomainError>(error: domainError ?? .generic)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

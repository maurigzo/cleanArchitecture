//
//  FetchPokemonTypesListUseCaseType.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 13/01/2025.
//

import Combine

protocol FetchPokemonTypesUseCaseType {
    func execute() -> AnyPublisher<[PokemonType], DomainError>
}

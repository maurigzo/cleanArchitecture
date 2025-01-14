//
//  FetchPokemonListUseCaseType.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 13/01/2025.
//

import Combine

protocol FetchPokemonListUseCaseType {
    func execute() -> AnyPublisher<[Pokemon], DomainError>
}

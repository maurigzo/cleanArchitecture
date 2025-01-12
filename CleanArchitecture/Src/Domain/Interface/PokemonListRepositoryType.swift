//
//  PokemonListRepositoryType.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 11/01/2025.
//

import Combine

protocol PokemonListRepositoryType {
    func fetchPokemonList() async -> AnyPublisher<[Pokemon], DomainError>
}

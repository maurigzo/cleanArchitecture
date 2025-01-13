//
//  PokemonDataSourceType.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 11/01/2025.
//

import Combine

protocol PokemonDataSourceType {
    func fetchPokemonList() -> AnyPublisher<PokemonListDTO, HTTPClientError>
    func fetchPokemonDetails() -> AnyPublisher<[PokemonDTO], HTTPClientError>
}

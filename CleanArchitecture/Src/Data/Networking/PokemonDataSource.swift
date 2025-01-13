//
//  PokemonDataSource.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 11/01/2025.
//

import Combine
import Foundation

final class PokemonDataSource: PokemonDataSourceType {
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient = URLSessionHTTPClient()) {
        self.httpClient = httpClient
    }

    func fetchPokemonList() -> AnyPublisher<PokemonListDTO, HTTPClientError> {
        let endpoint = "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0"
        return httpClient.makeRequest(endpoint: endpoint)
            .decode(PokemonListDTO.self)
    }
    
    func fetchPokemonDetails() -> AnyPublisher<[PokemonDTO], HTTPClientError> {
        fetchPokemonList()
            .flatMap { pokemonListDTO -> AnyPublisher<[PokemonDTO], HTTPClientError> in
                let publishers = pokemonListDTO.results.compactMap { [weak self] pokemonListResultDTO in
                    self?.httpClient.makeRequest(endpoint: pokemonListResultDTO.url)
                        .decode(PokemonDTO.self)
                }
                return Publishers.MergeMany(publishers)
                    .collect()
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

//
//  PokemonDataSource.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 11/01/2025.
//

import Combine
import Foundation
import UIKit

final class PokemonDataSource: PokemonDataSourceType {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient = URLSessionHTTPClient()) {
        self.httpClient = httpClient
    }

    func fetchPokemonDetails(limit: Int, offset: Int) -> AnyPublisher<[PokemonDTO], HTTPClientError> {
        fetchPokemonList(limit: limit, offset: offset)
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

    func downloadImage(from url: String, key: String) -> AnyPublisher<UIImage, ImageDownloadError> {
        httpClient.makeRequest(endpoint: url)
            .tryMap { data in
                guard let image = UIImage(data: data) else { throw HTTPClientError.parsingError }
                return image
            }
            .mapError { _ in return ImageDownloadError.downloadFailed }
            .eraseToAnyPublisher()
    }
}

private extension PokemonDataSource {
    func fetchPokemonList(limit: Int, offset: Int) -> AnyPublisher<PokemonListDTO, HTTPClientError> {
        let endpoint = "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)"
        return httpClient.makeRequest(endpoint: endpoint)
            .decode(PokemonListDTO.self)
            .eraseToAnyPublisher()
    }
}

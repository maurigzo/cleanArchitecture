//
//  PokemonListRepository.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 11/01/2025.
//

import Combine
import UIKit

final class PokemonListRepository: PokemonListRepositoryType {
    private let dataSource: PokemonDataSourceType
    private let errorMapper: DomainErrorMapper

    init(dataSource: PokemonDataSourceType = PokemonDataSource(), errorMapper: DomainErrorMapper = DomainErrorMapper()) {
        self.dataSource = dataSource
        self.errorMapper = errorMapper
    }

    func fetchPokemonList(limit: Int, offset: Int) -> AnyPublisher<[Pokemon], DomainError> {
        dataSource.fetchPokemonDetails(limit: limit, offset: offset)
            .mapError { error in
                self.errorMapper.map(error: error)
            }
            .flatMap { [weak self] pokemonDTOs in
                self?.downloadPokemonImages(for: pokemonDTOs) ?? Fail(error: DomainError.generic).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

private extension PokemonListRepository {
    func downloadPokemonImages(for pokemonDTOs: [PokemonDTO]) -> AnyPublisher<[Pokemon], DomainError> {
        let pokemonPublishers = pokemonDTOs.map { pokemonDTO in
            self.downloadImage(for: pokemonDTO)
                .map { image in
                    Pokemon.build(from: pokemonDTO, image: image)
                }
                .mapError { _ in DomainError.imageDownloadError }
                .eraseToAnyPublisher()
        }
        return Publishers.MergeMany(pokemonPublishers)
            .collect()
            .eraseToAnyPublisher()
    }

    func downloadImage(for pokemonDTO: PokemonDTO) -> AnyPublisher<UIImage, DomainError> {
        dataSource.downloadImage(
            from: pokemonDTO.sprites.other.officialArtwork.frontDefault,
            key: pokemonDTO.id.description
        )
        .mapError { _ in DomainError.imageDownloadError }
        .eraseToAnyPublisher()
    }
}

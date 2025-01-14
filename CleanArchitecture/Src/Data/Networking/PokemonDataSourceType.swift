//
//  PokemonDataSourceType.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 11/01/2025.
//

import Combine
import UIKit

protocol PokemonDataSourceType {
    func fetchPokemonDetails() -> AnyPublisher<[PokemonDTO], HTTPClientError>
    func downloadImage(from url: String, key: String) -> AnyPublisher<UIImage, ImageDownloadError>
}


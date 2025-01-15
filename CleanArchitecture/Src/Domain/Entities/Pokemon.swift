//
//  Pokemon.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 11/01/2025.
//

import UIKit

struct Pokemon: Equatable {
    let id: Int
    let name: String
    let types: [PokemonType]
    let imageURL: String
    var image: UIImage?
    let weight: Double
    let height: Double
    let stats: [PokemonStat]

    var heightWithUnit: String {
        "\(height) m"
    }
    
    var weightWithUnit: String {
        "\(weight) kg"
    }

    static func build(from dto: PokemonDTO, image: UIImage?) -> Self {
        let types: [PokemonType] = dto.types.map { PokemonType(name: $0.type.name) }
        let imageURL = dto.sprites.other.officialArtwork.frontDefault
        let weight = dto.weight / 10.0
        let height = dto.height / 10.0
        let stats = dto.stats.map { PokemonStat.build(from: $0) }

        return .init(
            id: dto.id,
            name: dto.species.name,
            types: types,
            imageURL: imageURL,
            image: image,
            weight: weight,
            height: height,
            stats: stats
        )
    }
}

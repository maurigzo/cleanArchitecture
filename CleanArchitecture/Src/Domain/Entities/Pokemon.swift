//
//  Pokemon.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 11/01/2025.
//

import UIKit

struct Pokemon {
    let id: Int
    let name: String
    let abilities: [Ability]
    let types: [PokemonType]
    let imageURL: String
    var image: UIImage?
    let weight: Double
    let height: Double
    
    var heightWithUnit: String {
        "\(height) m"
    }
    
    var weightWithUnit: String {
        "\(weight) kg"
    }

    static func build(from dto: PokemonDTO) -> Self {
        let abilities: [Ability] = dto.abilities.map { Ability.build(from: $0) }
        let types: [PokemonType] = dto.types.map { PokemonType(name: $0.type.name) }
        let imageURL = dto.sprites.other.officialArtwork.frontDefault
        let weight = dto.weight / 10.0
        let height = dto.height / 10.0

        return .init(
            id: dto.id,
            name: dto.name,
            abilities: abilities,
            types: types,
            imageURL: imageURL,
            weight: weight,
            height: height
        )
    }
}

//
//  Pokemon.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 11/01/2025.
//

struct Pokemon {
    let id: Int
    let name: String
    let abilities: [Ability]

    static func build(from dto: PokemonDTO) -> Self {
        let abilities: [Ability] = dto.abilities.map { Ability.build(from: $0) }
        
        return .init(id: dto.id, name: dto.name, abilities: abilities)
    }
}

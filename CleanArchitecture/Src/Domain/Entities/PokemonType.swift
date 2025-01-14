//
//  PokemonType.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 13/01/2025.
//

struct PokemonType {
    let name: String
    let imageURL: String
    
    static func build(from dto: PokemonTypeDetailsDTO) -> Self {
        .init(name: dto.name, imageURL: dto.swordShieldImage.nameIcon)
    }
}

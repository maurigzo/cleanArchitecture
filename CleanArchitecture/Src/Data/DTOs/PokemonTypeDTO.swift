//
//  PokemonTypeDTO.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 13/01/2025.
//

struct PokemonTypeDetailsDTO: Codable {
    let name: String
    let swordShieldImage: TypeIcon
    
    enum codingKeys: String, CodingKey {
        case name = "name"
        case swordShieldImage = "sword-shield"
    }
}

struct TypeIcon: Codable {
    let nameIcon: String
}

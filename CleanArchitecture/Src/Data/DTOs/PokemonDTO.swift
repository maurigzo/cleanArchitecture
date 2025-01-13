//
//  PokemonDTO.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 11/01/2025.
//

struct PokemonDTO: Codable {
    let id: Int
    let name: String
    let abilities: [AbilityDTO]
}

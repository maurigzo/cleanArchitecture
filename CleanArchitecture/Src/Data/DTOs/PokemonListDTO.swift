//
//  PokemonListDTO.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 11/01/2025.
//

struct PokemonListDTO: Codable {
    let next: String
    let previous: String?
    let results: [PokemonListResultDTO]
}

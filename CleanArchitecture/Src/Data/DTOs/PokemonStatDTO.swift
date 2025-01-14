//
//  PokemonStatDTO.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 14/01/2025.
//

struct PokemonStatDTO: Codable {
    let baseStat: Int
    let stat: StatDetailsDTO
}

struct StatDetailsDTO: Codable {
    let name: String
}

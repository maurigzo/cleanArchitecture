//
//  PokemonTypeListDTO.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 13/01/2025.
//


struct PokemonTypeListDTO: Codable {
    let results: [PokemonTypeDTO]
}

struct PokemonTypeDTO: Codable {
    let name: String
    let url: String
}

//
//  PokemonDTO.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 11/01/2025.
//

struct PokemonDTO: Codable {
    let id: Int
    let species: SpeciesDTO
    let abilities: [AbilityDTO]
    let types: [PokemonTypeDTO]
    let sprites: SpritesDTO
    let weight: Double
    let height: Double
    let stats: [PokemonStatDTO]
}

struct PokemonTypeDTO: Codable {
    let type: PokemonTypeDetailsDTO
}

struct PokemonTypeDetailsDTO: Codable {
    let name: String
}

struct SpeciesDTO: Codable {
    let name: String
}

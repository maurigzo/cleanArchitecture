//
//  File.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 15/01/2025.
//


extension PokemonDTO {
    static func squirtleMock() -> PokemonDTO {
        return PokemonDTO(
            id: 7,
            species: SpeciesDTO(name: "squirtle"),
            types: [PokemonTypeDTO(type: PokemonTypeDetailsDTO(name: "Water"))],
            sprites: SpritesDTO(other: OtherSpritesDTO(officialArtwork: OfficialArtworkDTO(frontDefault: ""))),
            weight: 69,
            height: 7,
            stats: []
        )
    }
}
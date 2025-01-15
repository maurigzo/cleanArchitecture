//
//  Pokemon+Mock.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 14/01/2025.
//

@testable import CleanArchitecture

extension Pokemon {
    static let bulbasaurMock: Self = .init(
        id: 1,
        name: "Bulbasaur",
        types: [PokemonType(name: "grass"), PokemonType(name: "poison")],
        imageURL: "",
        weight: 69,
        height: 70,
        stats: [
            PokemonStat(name: "hp", baseValue: 45),
            PokemonStat(name: "attack", baseValue: 49)
        ]
    )

    static let charmanderMock: Self = .init(
        id: 1,
        name: "Charmander",
        types: [PokemonType(name: "fire")],
        imageURL: "",
        weight: 85,
        height: 60,
        stats: [
            PokemonStat(name: "hp", baseValue: 39),
            PokemonStat(name: "attack", baseValue: 52)
        ]
    )
}

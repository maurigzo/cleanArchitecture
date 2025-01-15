//
//  PokemonTests.swift
//  CleanArchitectureTests
//
//  Created by Gonzalo Mauricio Ramirez on 15/01/2025.
//

import XCTest
@testable import CleanArchitecture

final class PokemonTests: XCTestCase {
    func testPokemonBuildFromDTO() {
        // Arrange
        let dto = PokemonDTO(
            id: 1,
            species: SpeciesDTO(name: "Bulbasaur"),
            types: [PokemonTypeDTO(type: PokemonTypeDetailsDTO(name: "grass"))],
            sprites: SpritesDTO(other: OtherSpritesDTO(officialArtwork: OfficialArtworkDTO(frontDefault: "https://example.com/bulbasaur.png"))),
            weight: 69,
            height: 7,
            stats: [
                PokemonStatDTO(baseStat: 45, stat: StatDetailsDTO(name: "hp")),
                PokemonStatDTO(baseStat: 49, stat: StatDetailsDTO(name: "attack"))
            ]
        )
        
        let pokemon = Pokemon.build(from: dto, image: nil)
        
        // Assert
        XCTAssertEqual(pokemon.id, 1)
        XCTAssertEqual(pokemon.name, "Bulbasaur")
        XCTAssertEqual(pokemon.types.count, 1)
        XCTAssertEqual(pokemon.types.first?.name, "grass")
        XCTAssertEqual(pokemon.imageURL, "https://example.com/bulbasaur.png")
        XCTAssertEqual(pokemon.weight, 6.9)
        XCTAssertEqual(pokemon.height, 0.7)
        XCTAssertEqual(pokemon.stats.count, 2)
        XCTAssertEqual(pokemon.stats.first?.name, "hp")
        XCTAssertEqual(pokemon.stats.first?.baseValue, 45)
    }
    
    func testPokemonHeightAndWeightWithUnits() {
        // Arrange
        let pokemon = Pokemon.bulbasaurMock
        
        // Assert
        XCTAssertEqual(pokemon.heightWithUnit, "0.7 m")
        XCTAssertEqual(pokemon.weightWithUnit, "6.9 kg")
    }
    
    func testPokemonStatColor() {
        // Arrange
        let lowStat = PokemonStat(name: "hp", baseValue: 40)
        let mediumStat = PokemonStat(name: "attack", baseValue: 120)
        let highStat = PokemonStat(name: "defense", baseValue: 230)
        
        // Assert
        XCTAssertEqual(lowStat.color, .red)
        XCTAssertEqual(mediumStat.color, .yellow)
        XCTAssertEqual(highStat.color, .green)
    }
}

//
//  PokemonTests.swift
//  CleanArchitectureTests
//
//  Created by Gonzalo Mauricio Ramirez on 15/01/2025.
//

import XCTest
@testable import CleanArchitecture

final class PokemonTests: XCTestCase {
    
    // Prueba para verificar la conversión desde PokemonDTO a Pokemon
    func testPokemonBuildFromDTO() {
        // Arrange: Crear un DTO simulado
        let dto = PokemonDTO(
            id: 1,
            species: PokemonSpecies(name: "Bulbasaur"),
            types: [PokemonTypeDTO(type: NamedAPIResource(name: "grass"))],
            sprites: PokemonSprites(
                other: OtherSprites(
                    officialArtwork: OfficialArtwork(frontDefault: "https://example.com/bulbasaur.png")
                )
            ),
            weight: 69,
            height: 70,
            stats: [
                PokemonStatDTO(baseStat: 45, stat: NamedAPIResource(name: "hp")),
                PokemonStatDTO(baseStat: 49, stat: NamedAPIResource(name: "attack"))
            ]
        )
        
        // Act: Convertir el DTO a un modelo de dominio
        let pokemon = Pokemon.build(from: dto, image: nil)
        
        // Assert: Verificar que los datos son correctos
        XCTAssertEqual(pokemon.id, 1)
        XCTAssertEqual(pokemon.name, "Bulbasaur")
        XCTAssertEqual(pokemon.types.count, 1)
        XCTAssertEqual(pokemon.types.first?.name, "grass")
        XCTAssertEqual(pokemon.imageURL, "https://example.com/bulbasaur.png")
        XCTAssertEqual(pokemon.weight, 6.9)
        XCTAssertEqual(pokemon.height, 7.0)
        XCTAssertEqual(pokemon.stats.count, 2)
        XCTAssertEqual(pokemon.stats.first?.name, "hp")
        XCTAssertEqual(pokemon.stats.first?.baseValue, 45)
    }
    
    // Prueba para heightWithUnit y weightWithUnit
    func testPokemonHeightAndWeightWithUnits() {
        // Arrange: Crear un modelo simulado
        let pokemon = Pokemon.bulbasaurMock
        
        // Assert: Verificar las propiedades calculadas
        XCTAssertEqual(pokemon.heightWithUnit, "7.0 m")
        XCTAssertEqual(pokemon.weightWithUnit, "6.9 kg")
    }
    
    // Prueba para PokemonStat.color
    func testPokemonStatColor() {
        // Arrange: Crear varios stats con valores base
        let lowStat = PokemonStat(name: "hp", baseValue: 40)
        let mediumStat = PokemonStat(name: "attack", baseValue: 120)
        let highStat = PokemonStat(name: "defense", baseValue: 230)
        
        // Assert: Verificar los colores calculados
        XCTAssertEqual(lowStat.color, .red)
        XCTAssertEqual(mediumStat.color, .yellow)
        XCTAssertEqual(highStat.color, .green)
    }
    
    // Prueba para verificar los mocks
    func testPokemonMocks() {
        // Arrange & Act: Usar los mocks definidos
        let bulbasaur = Pokemon.bulbasaurMock
        let charmander = Pokemon.charmanderMock
        
        // Assert: Verificar datos de los mocks
        XCTAssertEqual(bulbasaur.name, "Bulbasaur")
        XCTAssertEqual(bulbasaur.types.count, 2)
        XCTAssertEqual(bulbasaur.types.first?.name, "grass")
        
        XCTAssertEqual(charmander.name, "Charmander")
        XCTAssertEqual(charmander.types.count, 1)
        XCTAssertEqual(charmander.types.first?.name, "fire")
    }
}

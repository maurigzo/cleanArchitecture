//
//  PokemonListViewModelTests.swift
//  CleanArchitectureTests
//
//  Created by Gonzalo Mauricio Ramirez on 15/01/2025.
//

import XCTest
import Combine
@testable import CleanArchitecture

final class PokemonListViewModelTests: XCTestCase {
    private var sut: PokemonListViewModel!
    private var useCase: FetchPokemonListUseCaseMock!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        useCase = FetchPokemonListUseCaseMock()
        sut = PokemonListViewModel(fetchPokemonListUseCase: useCase)
    }
    
    override func tearDown() {
        cancellables = nil
        sut = nil
        useCase = nil
        super.tearDown()
    }
    
    func testInitialState() {
        XCTAssertTrue(sut.pokemons.isEmpty)
        XCTAssertFalse(sut.isLoading)
    }
    
    func testFetchPokemonList() {
        // Arrange
        let expectedPokemons = [Pokemon.bulbasaurMock, Pokemon.charmanderMock]
        let loadingExpectation = expectation(description: "Loading state updates correctly")
        let pokemonsExpectation = expectation(description: "Pokémons loaded correctly")
        
        // Act
        sut.$isLoading
            .dropFirst()
            .sink { isLoading in
                if !isLoading {
                    loadingExpectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        sut.$pokemons
            .dropFirst()
            .sink { pokemons in
                if !pokemons.isEmpty {
                    XCTAssertEqual(pokemons, expectedPokemons)
                    pokemonsExpectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        sut.fetchPokemonList()
        
        // Assert
        wait(for: [loadingExpectation, pokemonsExpectation], timeout: 2.0)
    }
    
    func testMemoryLeaks() {
        // Act
        weak var weakSUT = sut
        sut = nil
        
        // Assert
        XCTAssertNil(weakSUT, "The PokemonListViewModel instance was not deallocated, indicating a memory leak.")
    }
}

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
    private var viewModel: PokemonListViewModel!
    private var useCase: MockFetchPokemonListUseCase!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
        useCase = MockFetchPokemonListUseCase()
        viewModel = PokemonListViewModel(fetchPokemonListUseCase: useCase)
    }
    
    override func tearDown() {
        cancellables = nil
        viewModel = nil
        useCase = nil
        super.tearDown()
    }
    
    // Prueba para verificar el estado inicial del ViewModel
    func testInitialState() {
        XCTAssertTrue(viewModel.pokemons.isEmpty)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    // Prueba para verificar la carga exitosa de Pokémon
    func testLoadPokemonsSuccess() {
        // Arrange: Configurar el mock para devolver datos simulados
        let expectedPokemons = [Pokemon.bulbasaurMock, Pokemon.charmanderMock]
        let expectation = XCTestExpectation(description: "Pokémons are loaded successfully")
        
        // Act: Llamar al método de carga
        viewModel.$pokemons
            .dropFirst() // Ignorar el valor inicial vacío
            .sink { pokemons in
                XCTAssertEqual(pokemons, expectedPokemons)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadPokemons()
        
        // Assert: Verificar que el estado de carga cambia apropiadamente
        XCTAssertTrue(viewModel.isLoading)
        wait(for: [expectation], timeout: 2.0)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    // Prueba para verificar un error durante la carga
    func testLoadPokemonsFailure() {
        // Arrange: Configurar el mock para devolver un error
        useCase.shouldFail = true
        let expectation = XCTestExpectation(description: "Error is handled correctly")
        
        // Act: Llamar al método de carga
        viewModel.$errorMessage
            .dropFirst() // Ignorar el valor inicial nulo
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, "An error occurred. Please try again later.") // Ajustar según el formato de error
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadPokemons()
        
        // Assert: Verificar que el estado de carga cambia apropiadamente
        XCTAssertTrue(viewModel.isLoading)
        wait(for: [expectation], timeout: 2.0)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    // Prueba para verificar el reinicio del error
    func testResetError() {
        // Arrange: Configurar un error inicial
        viewModel.errorMessage = "An error occurred."
        
        // Act: Llamar al método para reiniciar el error
        viewModel.resetError()
        
        // Assert: Verificar que el mensaje de error se haya reiniciado
        XCTAssertNil(viewModel.errorMessage)
    }
}

//
//  FetchPokemonListUseCaseTests.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 14/01/2025.
//

import XCTest
import Combine
@testable import CleanArchitecture

final class FetchPokemonListUseCaseTests: XCTestCase {
    private var sut: FetchPokemonListUseCase!
    private var repositoryMock: PokemonListRepositoryMock!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        repositoryMock = PokemonListRepositoryMock()
        sut = FetchPokemonListUseCase(pokemonListRepository: repositoryMock)
        cancellables = []
    }
    
    override func tearDown() {
        repositoryMock = nil
        sut = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchPokemonList() {
        // Arrange
        let pokemonList: [Pokemon] = [Pokemon.bulbasaurMock, Pokemon.charmanderMock]
        repositoryMock.result = .success(pokemonList)
        
        let expectation = XCTestExpectation(description: "Fetch Pokemon List")
        
        // Act
        sut.execute(limit: 20, offset: 0)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but got failure")
                }
            }, receiveValue: { result in
                // Assert
                XCTAssertEqual(result.count, pokemonList.count)
                XCTAssertEqual(result.first?.name, pokemonList.first?.name)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchPokemonListError() {
        // Arrange
        repositoryMock.result = .failure(.generic)
        
        let expectation = XCTestExpectation(description: "Fetch Pokemon List Failure")
        
        // Act
        sut.execute(limit: 20, offset: 0)
            .sink(receiveCompletion: { completion in
                // Assert
                if case let .failure(error) = completion {
                    XCTAssertEqual(error, .generic)
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure but got value")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testMemoryLeaks() {
        // Act
        weak var weakSUT = sut
        sut = nil
        
        // Assert
        XCTAssertNil(weakSUT, "The FetchPokemonListUseCase instance was not deallocated, indicating a memory leak.")
    }
}

final class PokemonListRepositoryMock: PokemonListRepositoryType {
    var result: Result<[Pokemon], DomainError>?

    func fetchPokemonList(limit: Int, offset: Int) -> AnyPublisher<[Pokemon], DomainError> {
        guard let result = result else { return Fail(error: .generic).eraseToAnyPublisher() }
        return result.publisher.eraseToAnyPublisher()
    }
}

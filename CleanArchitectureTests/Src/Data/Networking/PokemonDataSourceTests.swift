//
//  PokemonDataSourceTests.swift
//  CleanArchitectureTests
//
//  Created by Gonzalo Mauricio Ramirez on 15/01/2025.
//

import XCTest
import Combine
@testable import CleanArchitecture

final class PokemonDataSourceTests: XCTestCase {
    private var sut: PokemonDataSource!
    private var httpClientMock: HTTPClientMock!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        httpClientMock = HTTPClientMock()
        sut = PokemonDataSource(httpClient: httpClientMock)
        cancellables = []
    }

    override func tearDown() {
        sut = nil
        httpClientMock = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchPokemonDetails() {
        // Arrange
        let mockPokemonListDTO = PokemonListDTO(results: [PokemonListResultDTO(name: "squirtle", url: "https://pokeapi.co/api/v2/pokemon/7")])
        let mockPokemonDTO = PokemonDTO.squirtleMock()
        httpClientMock.resultForURL = [
            "https://pokeapi.co/api/v2/pokemon?limit=10&offset=0": .success(try! JSONEncoder().encode(mockPokemonListDTO)),
            "https://pokeapi.co/api/v2/pokemon/7": .success(try! JSONEncoder().encode(mockPokemonDTO))
        ]
        let expectation = XCTestExpectation(description: "Fetch Pokemon Details")

        // Act
        sut.fetchPokemonDetails(limit: 10, offset: 0)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but got failure")
                }
            }, receiveValue: { result in
                // Assert
                XCTAssertEqual(result.count, 1)
                XCTAssertEqual(result.first?.species.name, mockPokemonDTO.species.name)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchPokemonDetailsFailure() {
        // Arrange
        httpClientMock.resultForURL = ["https://pokeapi.co/api/v2/pokemon?limit=10&offset=0": .failure(.generic)]
        let expectation = XCTestExpectation(description: "Fetch Pokemon Details Failure")

        // Act
        sut.fetchPokemonDetails(limit: 10, offset: 0)
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

    func testDownloadImage() {
        // Arrange
        let mockImageData = UIImage(systemName: "circle")!.pngData()!
        httpClientMock.resultForURL = ["https://example.com/image.png": .success(mockImageData)]
        let expectation = XCTestExpectation(description: "Download Image Success")

        // Act
        sut.downloadImage(from: "https://example.com/image.png", key: "imageKey")
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but got failure")
                }
            }, receiveValue: { image in
                // Assert
                XCTAssertNotNil(image)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testDownloadImageFailure() {
        // Arrange
        httpClientMock.resultForURL = ["https://example.com/image.png": .failure(.clientError)]
        let expectation = XCTestExpectation(description: "Download Image Failure")

        // Act
        sut.downloadImage(from: "https://example.com/image.png", key: "imageKey")
            .sink(receiveCompletion: { completion in
                // Assert
                if case let .failure(error) = completion {
                    XCTAssertEqual(error, .downloadFailed)
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
        XCTAssertNil(weakSUT, "The PokemonDataSource instance was not deallocated, indicating a memory leak.")
    }
}

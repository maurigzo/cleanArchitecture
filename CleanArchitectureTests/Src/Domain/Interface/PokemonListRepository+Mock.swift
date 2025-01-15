//
//  PokemonListRepository+Mock.swift
//  CleanArchitectureTests
//
//  Created by Gonzalo Mauricio Ramirez on 15/01/2025.
//

@testable import CleanArchitecture
import Combine

final class PokemonListRepositoryMock: PokemonListRepositoryType {
    var result: Result<[Pokemon], DomainError>?

    func fetchPokemonList(limit: Int, offset: Int) -> AnyPublisher<[Pokemon], DomainError> {
        guard let result = result else { return Fail(error: .generic).eraseToAnyPublisher() }
        return result.publisher.eraseToAnyPublisher()
    }
}

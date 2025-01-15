//
//  FetchPokemonListUseCase+Mock.swift
//  CleanArchitectureTests
//
//  Created by Gonzalo Mauricio Ramirez on 15/01/2025.
//

import Combine
@testable import CleanArchitecture

final class FetchPokemonListUseCaseMock: FetchPokemonListUseCaseType {
    var shouldFail = false
    func execute(limit: Int, offset: Int) -> AnyPublisher<[Pokemon], DomainError> {
        if shouldFail {
            return Fail(error: DomainError.clientError)
                .eraseToAnyPublisher()
        } else {
            return Just([Pokemon.bulbasaurMock, Pokemon.charmanderMock])
                .setFailureType(to: DomainError.self)
                .eraseToAnyPublisher()
        }
    }
}


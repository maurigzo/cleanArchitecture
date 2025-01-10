//
//  FetchWinnersUseCase.swift
//  CleanArchitecture
//
//  Created by jrobles on 07/01/2025.
//

import Combine

protocol FetchWinnersUseCaseType {
    func execute(allowedWinners: Int) -> AnyPublisher<[RaffleModel], RaffleError>
}

final class FetchWinnersUseCase {
    private let authorizationCenter: AuthorizationCenterType
    private let raffleRepository: RaffleRepositoryType
    
    init(
        authorizationCenter: AuthorizationCenterType = AuthorizationCenter.shared,
        raffleRepository: RaffleRepositoryType = RaffleRepository()
    ) {
        self.authorizationCenter = authorizationCenter
        self.raffleRepository = raffleRepository
    }
}

// MARK: - Private methods
private extension FetchWinnersUseCase {
    func validateUserAuthorized() -> Bool {
        let random = Int.random(in: 0...5)
        // simulate some random unauthorized error
        guard random != 4, authorizationCenter.isUserAuthorized() else {
            return false
        }
        return true
    }
}

// MARK: - FetchWinnersUseCaseType
extension FetchWinnersUseCase: FetchWinnersUseCaseType {
    func execute(allowedWinners: Int) -> AnyPublisher<[RaffleModel], RaffleError> {
        guard self.validateUserAuthorized() else {
            return Fail(error: RaffleError.unauthorized).eraseToAnyPublisher()
        }
        return self.raffleRepository.fetchWinners(amount: allowedWinners)
    }
}


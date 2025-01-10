//
//  RaffleRepository.swift
//  CleanArchitecture
//
//  Created by jrobles on 07/01/2025.
//

import Combine
import Foundation

final class RaffleRepository {
    private let remoteDS: RemoteDataSourceType
    
    init(remoteDS: RemoteDataSourceType = RemoteDataSource()) {
        self.remoteDS = remoteDS
    }
}

// MARK: - RaffleRepositoryType
extension RaffleRepository: RaffleRepositoryType {
    func fetchWinners(amount: Int) -> AnyPublisher<[RaffleModel], RaffleError> {
        self.remoteDS.getWinners(amount: amount)
            .tryMap { values in
                guard !values.isEmpty else {
                    throw RaffleError.notFound
                }
                let response: [RaffleModel] = values.map {
                    RaffleModel(from: $0, with: UUID())
                }
                return response
            }
            .mapError {
                $0 as? RaffleError ?? .notFound
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Mappers
private extension RaffleModel {
    init(
        from winningNumber: Int,
        with uniqueIdentifier: UUID
    ) {
        self.uniqueIdentifier = uniqueIdentifier
        self.winningNumber = winningNumber
    }
}

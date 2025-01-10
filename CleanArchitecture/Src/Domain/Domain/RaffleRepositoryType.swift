//
//  RaffleRepositoryType.swift
//  CleanArchitecture
//
//  Created by jrobles on 07/01/2025.
//

import Combine

protocol RaffleRepositoryType {
    func fetchWinners(amount: Int) -> AnyPublisher<[RaffleModel], RaffleError>
}

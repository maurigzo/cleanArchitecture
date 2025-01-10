//
//  RemoteDataSource.swift
//  CleanArchitecture
//
//  Created by jrobles on 07/01/2025.
//

import Combine
import Foundation

protocol RemoteDataSourceType {
    func getWinners(amount: Int) -> AnyPublisher<[Int], RaffleError>
}

final class RemoteDataSource: RemoteDataSourceType {
    func getWinners(amount: Int) -> AnyPublisher<[Int], RaffleError> {
            Future { promise in
                DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
                    let winners = (0..<amount).map { _ in Int.random(in: 0...255) }
                    promise(.success(winners))
                }
            }
            .eraseToAnyPublisher()
        }
}

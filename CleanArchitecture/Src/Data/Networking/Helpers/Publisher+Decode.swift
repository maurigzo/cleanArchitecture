//
//  Publisher+Decode.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 11/01/2025.
//

import Combine
import Foundation

extension Publisher where Output == Data, Failure == HTTPClientError {
    func decode<T: Decodable>(_ type: T.Type) -> AnyPublisher<T, HTTPClientError> {
        self
            .tryMap { data in
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    throw HTTPClientError.parsingError
                }
            }
            .mapError { _ in
                HTTPClientError.generic
            }
            .eraseToAnyPublisher()
    }
}

//
//  URLSessionType.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 15/01/2025.
//

import Foundation
import Combine

protocol URLSessionType {
    func publisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

extension URLSession: URLSessionType {
    func publisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        self.dataTaskPublisher(for: url)
            .eraseToAnyPublisher()
    }
}

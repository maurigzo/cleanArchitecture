//
//  HTTPClient+Mock.swift
//  CleanArchitectureTests
//
//  Created by Gonzalo Mauricio Ramirez on 15/01/2025.
//

import Foundation
@testable import CleanArchitecture
import Combine

final class HTTPClientMock: HTTPClient {
    var resultForURL: [String: Result<Data, HTTPClientError>] = [:]

    func makeRequest(endpoint: String) -> AnyPublisher<Data, HTTPClientError> {
        if let result = resultForURL[endpoint] {
            return result.publisher.eraseToAnyPublisher()
        }
        return Fail(error: HTTPClientError.generic).eraseToAnyPublisher()
    }
}

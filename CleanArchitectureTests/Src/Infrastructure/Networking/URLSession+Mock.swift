//
//  URLSession+Mock.swift
//  CleanArchitectureTests
//
//  Created by Gonzalo Mauricio Ramirez on 15/01/2025.
//

import Foundation
import Combine
@testable import CleanArchitecture

final class URLSessionMock: URLSessionType {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: URLError?

    func publisher(for url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        if let mockError = mockError {
            return Fail(error: mockError).eraseToAnyPublisher()
        } else {
            let data = mockData ?? Data()
            let response = mockResponse ?? URLResponse()
            return Just((data: data, response: response))
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
        }
    }
}

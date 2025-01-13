//
//  URLSessionHTTPClient.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 11/01/2025.
//

import Foundation
import Combine

final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    private let errorResolver: URLSessionErrorResolver
    
    init(session: URLSession = .shared, errorResolver: URLSessionErrorResolver = URLSessionErrorResolver()) {
        self.session = session
        self.errorResolver = errorResolver
    }
    
    func makeRequest(endpoint: String) -> AnyPublisher<Data, HTTPClientError> {
        guard let endpointURL = URL(string: endpoint) else {
            return Fail(error: HTTPClientError.clientError)
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: endpointURL)
            .tryMap { [weak self] data, response in
                guard let self else { throw HTTPClientError.clientError }
                guard let httpResponse = response as? HTTPURLResponse else { throw HTTPClientError.clientError }
                guard httpResponse.statusCode == 200 else { throw self.errorResolver.resolve(statusCode: httpResponse.statusCode) }
                return data
            }
            .mapError { _ in HTTPClientError.generic }
            .eraseToAnyPublisher()
    }
}

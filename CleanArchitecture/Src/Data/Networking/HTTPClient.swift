//
//  HTTPClient.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 11/01/2025.
//

import Combine
import Foundation

protocol HTTPClient {
    func makeRequest(endpoint: String) -> AnyPublisher<Data, HTTPClientError>
}

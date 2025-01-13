//
//  DomainErrorMapper.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 12/01/2025.
//

final class DomainErrorMapper {
    func map(error: HTTPClientError?) -> DomainError {
        return .generic
    }
}

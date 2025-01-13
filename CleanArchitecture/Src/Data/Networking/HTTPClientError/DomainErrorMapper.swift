//
//  DomainErrorMapper.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 12/01/2025.
//

final class DomainErrorMapper {
    func map(error: HTTPClientError?) -> DomainError {
        switch error {
        case .parsingError:
            return .parsingError
        case .clientError:
            return .clientError
        case .tooManyRequestsError:
            return .tooManyRequestsError
        case .serverError:
            return .serverError
        default:
            return .generic
        }
    }
}

//
//  DomainError.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 11/01/2025.
//

enum DomainError: Error {
    case parsingError
    case generic
    case clientError
    case tooManyRequestsError
    case serverError
}

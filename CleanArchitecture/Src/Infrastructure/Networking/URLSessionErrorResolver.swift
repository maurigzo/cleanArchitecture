//
//  URLSessionErrorResolver.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 11/01/2025.
//

class URLSessionErrorResolver {
    func resolve(statusCode: Int) -> HTTPClientError {
        if statusCode == 429 {
            return HTTPClientError.tooManyRequestsError
        } else if statusCode < 500 {
            return HTTPClientError.clientError
        }
        return HTTPClientError.serverError
    }
}

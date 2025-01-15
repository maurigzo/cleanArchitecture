//
//  ImageDownloadError.swift
//  CleanArchitecture
//
//  Created by Gonzalo Mauricio Ramirez on 13/01/2025.
//

enum ImageDownloadError: Error {
    case invalidURL
    case downloadFailed
    case unknownError
}

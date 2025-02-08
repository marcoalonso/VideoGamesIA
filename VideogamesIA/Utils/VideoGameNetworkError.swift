//
//  VideoGameNetworkError.swift
//  VideogamesIAInt
//
//  Created by Marco Alonso Rodriguez on 07/02/25.
//

import Foundation

enum VideoGameNetworkError: LocalizedError {
    case invalidURL
    case requestFailed
    case invalidResponse
    case serverError(statusCode: Int)
    case decodingError
    case unknownError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .requestFailed:
            return "Failed to complete the request. Please check your internet connection."
        case .invalidResponse:
            return "Received an invalid response from the server."
        case .serverError(let statusCode):
            return "Server returned an error with status code \(statusCode)."
        case .decodingError:
            return "Failed to decode the response data."
        case .unknownError:
            return "An unknown error occurred. Please try again later."
        }
    }
}


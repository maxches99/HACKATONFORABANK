//
//  APIError.swift
//  Hackaton
//
//  Created by Максим Чесников on 22.10.2021.
//

import Foundation

/// Custom errors of NetworkLayer
enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case registrationError
    case unknown
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .decodingError:
            return "APIError: decodingError"
        case .errorCode(let code):
            return "APIError: \(code)"
        case .registrationError:
            return "Error with registration"
        case .unknown:
            return "APIError: unknown"
        }
    }
}

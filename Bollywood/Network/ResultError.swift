//
//  ResultError.swift
//  Bollywood
//
//  Created by adam smith on 5/17/22.
//

import Foundation

enum ResultError: LocalizedError {
    case invalidURL(String)
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "unable to reach the server. please try agains."
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -> \(error)"
        case .noData:
            return "The server responded with no data. please try agains."
        case .unableToDecode:
            return "The server responded with bad data. please try agains."
        }
    }
}


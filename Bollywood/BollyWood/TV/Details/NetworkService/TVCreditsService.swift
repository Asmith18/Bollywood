//
//  TVCreditsService.swift
//  Bollywood
//
//  Created by adam smith on 10/20/22.
//

import Foundation

protocol TVCreditsServicable {
    func fetch(from endpoint: BollywoodEndpoint, completion: @escaping (Result<TVCredits, ResultError>) -> Void)
}

struct TVCreditsService: BollywoodAPI, TVCreditsServicable {
    
    func fetch(from endpoint: BollywoodEndpoint, completion: @escaping (Result<TVCredits, ResultError>) -> Void) {
        guard let url = endpoint.fullURL else {
            completion(.failure(.badURL))
            return
        }
        perform(URLRequest(url: url)) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let tvCredits = try decoder.decode(TVCredits.self, from: data)
                    completion(.success(tvCredits))
                } catch {
                    completion(.failure(.unableToDecode))
                }
            case .failure(let error):
                completion(.failure(.thrownError(error)))
            }
        }
    }
}


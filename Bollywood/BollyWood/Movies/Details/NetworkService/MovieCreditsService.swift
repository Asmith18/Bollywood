//
//  MovieCreditsService.swift
//  Bollywood
//
//  Created by adam smith on 10/20/22.
//

import Foundation

protocol MovieCreditsServicable {
    func fetch(from endpoint: BollywoodEndpoint, completion: @escaping (Result<MovieCredits, ResultError>) -> Void)
}

struct MovieCreditsService: BollywoodAPI, MovieCreditsServicable {
    func fetch(from endpoint: BollywoodEndpoint, completion: @escaping (Result<MovieCredits, ResultError>) -> Void) {
        guard let url = endpoint.fullURL else {
            completion(.failure(.badURL))
            return
        }
        perform(URLRequest(url: url)) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let movieCredits = try decoder.decode(MovieCredits.self, from: data)
                    completion(.success(movieCredits))
                } catch {
                    completion(.failure(.unableToDecode))
                }
            case .failure(let error):
                completion(.failure(.thrownError(error)))
            }
        }
    }
}

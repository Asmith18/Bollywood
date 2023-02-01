//
//  MovieSearchService.swift
//  Bollywood
//
//  Created by adam smith on 10/18/22.
//

import Foundation

protocol MovieSearchServicable {
    func fetch(from endpoint: BollywoodEndpoint, completion: @escaping (Result<Movie, ResultError>) -> Void)
}

struct MovieSearchService: BollywoodAPI, MovieSearchServicable {
    func fetch(from endpoint: BollywoodEndpoint, completion: @escaping (Result<Movie, ResultError>) -> Void) {
        guard let url = endpoint.fullURL else {
            completion(.failure(.badURL))
            return
        }
        perform(URLRequest(url: url)) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let movieSearch = try decoder.decode(Movie.self, from: data)
                    completion(.success(movieSearch))
                } catch {
                    completion(.failure(.unableToDecode))
                }
            case .failure(let error):
                completion(.failure(.thrownError(error)))
            }
        }
    }
}

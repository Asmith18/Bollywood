//
//  MovieDetailsService.swift
//  Bollywood
//
//  Created by adam smith on 10/20/22.
//

import Foundation

protocol MovieGenreServicable {
    func fetch(from endpoint: BollywoodEndpoint, completion: @escaping (Result<MovieDetails, ResultError>) -> Void)
}

struct MovieGenreService: BollywoodAPI, MovieGenreServicable {
    func fetch(from endpoint: BollywoodEndpoint, completion: @escaping (Result<MovieDetails, ResultError>) -> Void) {
        guard let url = endpoint.fullURL else {
            completion(.failure(.badURL))
            return
        }
        perform(URLRequest(url: url)) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let movieGenre = try decoder.decode(MovieDetails.self, from: data)
                    completion(.success(movieGenre))
                } catch {
                    completion(.failure(.unableToDecode))
                }
            case .failure(let error):
                completion(.failure(.thrownError(error)))
            }
        }
    }
    

}

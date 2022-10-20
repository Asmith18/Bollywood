//
//  MovieDetailsService.swift
//  Bollywood
//
//  Created by adam smith on 10/20/22.
//

import Foundation

struct MovieGenreService {

    private let apiService = BollywoodAPI()
    func fetchcharacterList(for endPoint: BollywoodEndpoint, completion: @escaping (Result<MovieDetails, ResultError>) -> Void) {

        guard let finalURL = endPoint.fullURL else {
            completion(.failure(.badURL))
            return
        }

        let urlRequest = URLRequest(url: finalURL)

        apiService.perform(urlRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let movie = try JSONDecoder().decode(MovieDetails.self, from: data)
                    completion(.success(movie))
                } catch {
                    completion(.failure(.unableToDecode))
                }
            case .failure(let error):
                completion(.failure(.thrownError(error)))
            }
        }
    }
}

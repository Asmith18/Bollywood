//
//  GenreService.swift
//  Bollywood
//
//  Created by adam smith on 10/20/22.
//

import Foundation

protocol TVGenreServicable {
    func fetch(from endpoint: BollywoodEndpoint, completion: @escaping (Result<TVDetails, ResultError>) -> Void)
}

struct TVGenreService: BollywoodAPI, TVGenreServicable {
    
    func fetch(from endpoint: BollywoodEndpoint, completion: @escaping (Result<TVDetails, ResultError>) -> Void) {
        guard let url = endpoint.fullURL else {
            completion(.failure(.badURL))
            return
        }
        perform(URLRequest(url: url)) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let tvdetails = try decoder.decode(TVDetails.self, from: data)
                    completion(.success(tvdetails))
                } catch {
                    completion(.failure(.unableToDecode))
                }
            case .failure(let error):
                completion(.failure(.thrownError(error)))
            }
        }
    }
}

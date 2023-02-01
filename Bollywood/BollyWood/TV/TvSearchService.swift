//
//  TvSearchService.swift
//  Bollywood
//
//  Created by adam smith on 10/19/22.
//

import Foundation

protocol TvSearchServicable {
    func fetch(from endpoint: BollywoodEndpoint, completion: @escaping (Result<TV, ResultError>) -> Void)
}

struct TvSearchService: BollywoodAPI, TvSearchServicable {
    func fetch(from endpoint: BollywoodEndpoint, completion: @escaping (Result<TV, ResultError>) -> Void) {
        guard let url = endpoint.fullURL else {
            completion(.failure(.badURL))
            return
        }
        perform(URLRequest(url: url)) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let tvSearch = try decoder.decode(TV.self, from: data)
                    completion(.success(tvSearch))
                } catch {
                    completion(.failure(.unableToDecode))
                }
            case .failure(let error):
                completion(.failure(.thrownError(error)))
            }
        }
    }
}

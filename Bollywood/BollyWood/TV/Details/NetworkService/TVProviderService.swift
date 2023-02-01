//
//  TVProviderService.swift
//  Bollywood
//
//  Created by adam smith on 10/20/22.
//

import Foundation

protocol TVProviderServicable {
    func fetch(from endpoint: BollywoodEndpoint, completion: @escaping (Result<TVProviders, ResultError>) -> Void)
}

struct TVProviderService: BollywoodAPI, TVProviderServicable {
    
    func fetch(from endpoint: BollywoodEndpoint, completion: @escaping (Result<TVProviders, ResultError>) -> Void) {
        guard let url = endpoint.fullURL else {
            completion(.failure(.badURL))
            return
        }
        perform(URLRequest(url: url)) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let tvProvider = try decoder.decode(TVProviders.self, from: data)
                    completion(.success(tvProvider))
                } catch {
                    completion(.failure(.unableToDecode))
                }
            case .failure(let error):
                completion(.failure(.thrownError(error)))
            }
        }
    }
}

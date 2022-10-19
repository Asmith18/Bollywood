//
//  TvSearchService.swift
//  Bollywood
//
//  Created by adam smith on 10/19/22.
//

import Foundation

struct TvSearchService {

    private let apiService = BollywoodAPI()
    func fetchcharacterList(for endPoint: BollywoodEndpoint, completion: @escaping (Result<TV, ResultError>) -> Void) {

        guard let finalURL = endPoint.fullURL else {
            completion(.failure(.badURL))
            return
        }

        let urlRequest = URLRequest(url: finalURL)

        apiService.perform(urlRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let tv =  try JSONDecoder().decode(TV.self, from: data)
                    completion(.success(tv))
                } catch {
                    completion(.failure(.unableToDecode))
                }
            case .failure(let error):
                completion(.failure(.thrownError(error)))
            }
        }
    }
}

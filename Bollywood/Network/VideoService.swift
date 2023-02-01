//
//  TVVideoService.swift
//  Bollywood
//
//  Created by adam smith on 10/20/22.
//

import Foundation

protocol VideoServicable {
    func fetch(from endpoint: BollywoodEndpoint, completion: @escaping (Result<WebView, ResultError>) -> Void)
}

struct VideoService: BollywoodAPI, VideoServicable {
    
    func fetch(from endpoint: BollywoodEndpoint, completion: @escaping (Result<WebView, ResultError>) -> Void) {
        guard let url = endpoint.fullURL else {
            completion(.failure(.badURL))
            return
        }
        perform(URLRequest(url: url)) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let webView = try decoder.decode(WebView.self, from: data)
                    completion(.success(webView))
                } catch {
                    completion(.failure(.unableToDecode))
                }
            case .failure(let error):
                completion(.failure(.thrownError(error)))
            }
        }
    }
}

//
//  BollywoodAPI.swift
//  Bollywood
//
//  Created by adam smith on 5/17/22.
//

import Foundation
import UIKit

protocol BollywoodAPI {
    func perform(_ request: URLRequest, completion: @escaping (Result<Data, ResultError>) -> Void)
}

extension BollywoodAPI {
    
    func perform(_ request: URLRequest, completion: @escaping (Result<Data, ResultError>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error {
                completion(.failure(.thrownError(error)))
            }
            guard let data else {
                completion(.failure(.noData))
                return
            }
            completion(.success(data))
        }.resume()
    }
    
    //    private static let imageURLString = "https://image.tmdb.org"
//    static func fetchImage(from imagePath: String, completion: @escaping (Result<UIImage, ResultError>) -> Void) {
//
//        guard let baseURL = URL(string: imageURLString) else { return }
//
//        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
//        urlComponents?.path = "/t/p/original\(imagePath)"
//        guard let finalURL = urlComponents?.url else { return }
//
//        URLSession.shared.dataTask(with: finalURL) { data, _, error in
//            if let error = error {
//                completion(.failure(.thrownError(error)))
//            }
//            guard let imageData = data else {
//                completion(.failure(.noData))
//                return
//            }
//            guard let movieImage = UIImage(data: imageData) else {
//                completion(.failure(.unableToDecode))
//                return
//            }
//            completion(.success(movieImage))
//        }.resume()
//    }
}
    

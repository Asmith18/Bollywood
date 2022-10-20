//
//  BollywoodAPI.swift
//  Bollywood
//
//  Created by adam smith on 5/17/22.
//

import Foundation
import UIKit
import WebKit

struct BollywoodAPI {
    
    private static let baseURLString = "https://api.themoviedb.org/3/"
    private static let imageURLString = "https://image.tmdb.org"
    private static let apiKey = "be35af15dc34f6c18ecb1b03e2fd3559"
    
    func perform(_ request: URLRequest, completion: @escaping (Result<Data, ResultError>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("Completed with a response of", response.statusCode)
            }
            guard let data else {
                completion(.failure(.noData))
                return
            }
            completion(.success(data))
        }.resume()
    }
    
    static func fetchImage(from imagePath: String, completion: @escaping (Result<UIImage, ResultError>) -> Void) {
        
        guard let baseURL = URL(string: imageURLString) else { return }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/t/p/original\(imagePath)"
        guard let finalURL = urlComponents?.url else { return }
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
            }
            guard let imageData = data else {
                completion(.failure(.noData))
                return
            }
            guard let movieImage = UIImage(data: imageData) else {
                completion(.failure(.unableToDecode))
                return
            }
            completion(.success(movieImage))
        }.resume()
    }
    
    static func fetchMovieDetails(with movieId: Int, completion: @escaping (Result<MovieDetails, ResultError>) -> Void) {
        
        guard let baseURL = URL(string: baseURLString) else { return }
        
        let apiQuery = URLQueryItem(name: "api_key", value: apiKey)
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/3/movie/\(movieId)"
        urlComponents?.queryItems = [apiQuery]
        let finalURL = urlComponents?.url
        
        URLSession.shared.dataTask(with: finalURL!) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            guard let detailsData = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let movieDetails = try JSONDecoder().decode(MovieDetails.self, from: detailsData)
                completion(.success(movieDetails))
            } catch {
                completion(.failure(.unableToDecode))
            }
        } .resume()
    }
    
    static func fetchTvDetails(with tvId: Int, completion: @escaping (Result<TVDetails, ResultError>) -> Void) {
        
        guard let baseURL = URL(string: baseURLString) else { return }
        
        let apiQuery = URLQueryItem(name: "api_key", value: apiKey)
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/3/tv/\(tvId)"
        urlComponents?.queryItems = [apiQuery]
        let finalURL = urlComponents?.url
        
        URLSession.shared.dataTask(with: finalURL!) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            guard let detailsData = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let tvDetails = try JSONDecoder().decode(TVDetails.self, from: detailsData)
                completion(.success(tvDetails))
            } catch {
                completion(.failure(.unableToDecode))
            }
        } .resume()
    }
}


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
    
    private static let baseURLString = "https://api.themoviedb.org"
    private static let imageURLString = "https://image.tmdb.org"

    static func fetchPopularMovie(completion: @escaping (Result<Movie, ResultError>) -> Void) {
        
        guard let baseURL = URL(string: baseURLString) else { return }
        
        let apiQuery = URLQueryItem(name: "api_key", value: "be35af15dc34f6c18ecb1b03e2fd3559")
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/3/movie/popular"
        urlComponents?.queryItems = [apiQuery]
        let finalURL = urlComponents?.url
        
        URLSession.shared.dataTask(with: finalURL!) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
            }
            guard let movieData = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let movie = try JSONDecoder().decode(Movie.self, from: movieData)
                completion(.success(movie))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func fetchPopularTV(completion: @escaping (Result<TV, ResultError>) -> Void) {
        
        guard let baseURL = URL(string: baseURLString) else { return }
        
        let apiQuery = URLQueryItem(name: "api_key", value: "be35af15dc34f6c18ecb1b03e2fd3559")
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/3/tv/popular"
        urlComponents?.queryItems = [apiQuery]
        let finalURL = urlComponents?.url
        
        URLSession.shared.dataTask(with: finalURL!) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
            }
            guard let tvData = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let tv = try JSONDecoder().decode(TV.self, from: tvData)
                completion(.success(tv))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func fetchTvVideo(for tvID: Int, completion: @escaping (Result<WebView, ResultError>) -> Void) {
        
        guard let baseURL = URL(string: baseURLString) else { return }
        
        let apiQuery = URLQueryItem(name: "api_key", value: "be35af15dc34f6c18ecb1b03e2fd3559")
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/3/tv/\(tvID)/videos"
        urlComponents?.queryItems = [apiQuery]
        let finalURL = urlComponents?.url
        
        URLSession.shared.dataTask(with: finalURL!) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
            }
            guard let tvData = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let tv = try JSONDecoder().decode(WebView.self, from: tvData)
                completion(.success(tv))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func fetchMovieVideo(for movieID: Int, completion: @escaping (Result<WebView, ResultError>) -> Void) {
        
        guard let baseURL = URL(string: baseURLString) else { return }
        
        let apiQuery = URLQueryItem(name: "api_key", value: "be35af15dc34f6c18ecb1b03e2fd3559")
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/3/movie/\(movieID)/videos"
        urlComponents?.queryItems = [apiQuery]
        let finalURL = urlComponents?.url
        
        URLSession.shared.dataTask(with: finalURL!) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
            }
            guard let tvData = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let tv = try JSONDecoder().decode(WebView.self, from: tvData)
                completion(.success(tv))
            } catch {
                completion(.failure(.unableToDecode))
            }
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
    
    static func searchMovie(with searchTerm: String, completion: @escaping (Result<Movie, ResultError>) -> Void) {

        guard let baseURL = URL(string: baseURLString) else { return }
        
        let apiQuery = URLQueryItem(name: "api_key", value: "be35af15dc34f6c18ecb1b03e2fd3559")
        let searchQuery = URLQueryItem(name: "query", value: searchTerm)
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/3/search/movie/"
        urlComponents?.queryItems = [apiQuery, searchQuery]
        let finalURL = urlComponents?.url
        
        URLSession.shared.dataTask(with: finalURL!) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
            }
            
            guard let searchMovieData = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let searchMovie = try JSONDecoder().decode(Movie.self, from: searchMovieData)
                completion(.success(searchMovie))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func searchTVShow(with searchTerm: String, completion: @escaping (Result<TV, ResultError>) -> Void) {

        guard let baseURL = URL(string: baseURLString) else { return }
        
        let apiQuery = URLQueryItem(name: "api_key", value: "be35af15dc34f6c18ecb1b03e2fd3559")
        let searchQuery = URLQueryItem(name: "query", value: searchTerm)
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/3/search/tv/"
        urlComponents?.queryItems = [apiQuery, searchQuery]
        let finalURL = urlComponents?.url
        
        URLSession.shared.dataTask(with: finalURL!) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
            }
            
            guard let searchTVData = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let searchTVShow = try JSONDecoder().decode(TV.self, from: searchTVData)
                completion(.success(searchTVShow))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
}

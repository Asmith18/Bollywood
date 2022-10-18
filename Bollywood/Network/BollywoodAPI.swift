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
    private static let moviePopular = "/3/movie/popular"
    private static let tvPopular = "/3/tv/popular"
    
//    func perform(_ request: URLRequest, completion: @escaping (Result<Data, ResultError>) -> Void) {
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error {
//                completion(.failure(.thrownError(error)))
//            }
//            if let response = response as? HTTPURLResponse {
//                print("Completed with a response of", response.statusCode)
//            }
//            guard let data else {
//                completion(.failure(.noData))
//                return
//            }
//            completion(.success(data))
//        }.resume()
//    }

    static func fetchPopularMovie(completion: @escaping (Result<Movie, ResultError>) -> Void) {
        
        guard let baseURL = URL(string: baseURLString) else { return }
        
        let apiQuery = URLQueryItem(name: "api_key", value: apiKey)
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = moviePopular
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
        
        let apiQuery = URLQueryItem(name: "api_key", value: apiKey)
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = tvPopular
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
        
        let apiQuery = URLQueryItem(name: "api_key", value: apiKey)
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
        
        let apiQuery = URLQueryItem(name: "api_key", value: apiKey)
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
        
        let apiQuery = URLQueryItem(name: "api_key", value: apiKey)
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
    
    static func fetchMovieProviders(with movieId: Int, completion: @escaping (Result<MovieProviders, ResultError>) -> Void) {
        
        guard let baseURL = URL(string: baseURLString) else { return }
        
        let apiQuery = URLQueryItem(name: "api_key", value: apiKey)
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/3/movie/\(movieId)/watch/providers"
        urlComponents?.queryItems = [apiQuery]
        let finalURL = urlComponents?.url
        
        URLSession.shared.dataTask(with: finalURL!) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
            }
            guard let providerData = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let movieProviders = try JSONDecoder().decode(MovieProviders.self, from: providerData)
                completion(.success(movieProviders))
            } catch {
                completion(.failure(.unableToDecode))
            }
        } .resume()
    }
    
    static func fetchTVProviders(with tvId: Int, completion: @escaping (Result<TVProviders, ResultError>) -> Void) {
        
        guard let baseURL = URL(string: baseURLString) else { return }
        
        let apiQuery = URLQueryItem(name: "api_key", value: apiKey)
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/3/tv/\(tvId)/watch/providers"
        urlComponents?.queryItems = [apiQuery]
        let finalURL = urlComponents?.url
        
        URLSession.shared.dataTask(with: finalURL!) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
            }
            
            guard let providerData = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let tvProviders = try JSONDecoder().decode(TVProviders.self, from: providerData)
                completion(.success(tvProviders))
            } catch {
                completion(.failure(.unableToDecode))
            }
        } .resume()
    }
    
    static func fetchMovieCredits(with movieId: Int, completion: @escaping (Result<MovieCredits, ResultError>) -> Void) {
        
        guard let baseURL = URL(string: baseURLString) else { return }
        
        let apiQuery = URLQueryItem(name: "api_key", value: apiKey)
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/3/movie/\(movieId)/credits"
        urlComponents?.queryItems = [apiQuery]
        let finalURL = urlComponents?.url
        
        URLSession.shared.dataTask(with: finalURL!) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            guard let castData = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let movieCast = try JSONDecoder().decode(MovieCredits.self, from: castData)
                completion(.success(movieCast))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func fetchTvCredits(with tvId: Int, completion: @escaping (Result<TVCredits, ResultError>) -> Void) {
        
        guard let baseURL = URL(string: baseURLString) else { return }
        
        let apiQuery = URLQueryItem(name: "api_key", value: apiKey)
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/3/tv/\(tvId)/credits"
        urlComponents?.queryItems = [apiQuery]
        let finalURL = urlComponents?.url
        
        URLSession.shared.dataTask(with: finalURL!) { data, _, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            guard let castData = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let tvCast = try JSONDecoder().decode(TVCredits.self, from: castData)
                completion(.success(tvCast))
            } catch {
                completion(.failure(.unableToDecode))
            }
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


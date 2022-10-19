//
//  BollywoodEndpoint.swift
//  Bollywood
//
//  Created by adam smith on 10/18/22.
//

import Foundation

enum BollywoodEndpoint {
    
    case moviePath(String)
    case tvPath(String)
    case popularMovie
    case popularTv
    
    var path: String {
        switch self {
            
        case .moviePath:
            return "search/movie"
        case .tvPath:
            return "search/tv"
        case .popularMovie:
            return "movie/popular"
        case .popularTv:
            return "tv/popular"
        }
    }
    
    var fullURL: URL? {
        guard var baseURL = URL(string: "https://api.themoviedb.org/3/") else { return nil }
        let apiQuery = URLQueryItem(name: "api_key", value: "be35af15dc34f6c18ecb1b03e2fd3559")
        switch self {
        case
                .moviePath(let searchTerm),
                .tvPath(let searchTerm):
            baseURL.appendPathComponent(path)
            guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
                return nil
            }
                    let searchQueryItem = URLQueryItem(name: "query", value: searchTerm)
                    components.queryItems = [apiQuery, searchQueryItem]
            return components.url
            
        case .popularMovie:
            baseURL.appendPathComponent(path)
            guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
                return nil
            }
                    components.queryItems = [apiQuery]
            return components.url
            
        case .popularTv:
            baseURL.appendPathComponent(path)
            guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else {
                return nil
            }
                    components.queryItems = [apiQuery]
            return components.url
        }
    }
}

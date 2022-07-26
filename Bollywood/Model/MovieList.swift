//
//  MovieList.swift
//  Bollywood
//
//  Created by adam smith on 7/26/22.
//

import Foundation

struct MovieList: Decodable {
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }
    
    let count: Int
    let next: String
    let previous: String?
    let results: [MovieResults]
}

struct MovieResults: Decodable {
    let name, url: String
}

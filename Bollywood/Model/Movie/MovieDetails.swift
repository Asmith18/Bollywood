//
//  MovieDetails.swift
//  Bollywood
//
//  Created by adam smith on 7/30/22.
//

import Foundation

struct MovieDetails: Decodable {
    let genres: [MovieGenres]
}

struct MovieGenres: Decodable {
    let name: String?
}

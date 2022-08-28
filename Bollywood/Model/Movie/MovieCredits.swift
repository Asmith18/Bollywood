//
//  MovieCredits.swift
//  Bollywood
//
//  Created by adam smith on 8/3/22.
//

import Foundation

struct MovieCredits: Decodable {
    let cast: [MovieCast]
    let crew: [MovieCrew]
}

struct MovieCast: Decodable {
    let name: String?
    let character: String?
    let profile_path: String?
}

struct MovieCrew: Decodable {
    let name: String?
    let profile_path: String?
    let job: String?
}

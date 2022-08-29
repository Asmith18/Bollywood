//
//  TV.swift
//  Bollywood
//
//  Created by adam smith on 6/27/22.
//

import Foundation
import UIKit

struct TV: Decodable {
    let results: [TVShows]
}

struct TVShows: Decodable {
    let name, poster_path, backdrop_path, overview: String?
    let vote_average: Double?
    let id: Int?
    let first_air_date: String?
}

//
//  Bollywood.swift
//  Bollywood
//
//  Created by adam smith on 5/17/22.
//

import Foundation
import UIKit

struct Movie: Decodable {
    let results: [Movies]
}

struct Movies: Decodable {
    let title, poster_path, backdrop_path, overview: String?
    let vote_average: Double?
    let id: Int?
    let release_date: String?
    let original_language: String?
}



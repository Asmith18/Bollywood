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
    let name: String
    let poster_path: String?
    let overview: String?
    let vote_average: Double?
    let id: Int?
}

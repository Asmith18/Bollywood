//
//  TVDetails.swift
//  Bollywood
//
//  Created by adam smith on 8/28/22.
//

import Foundation

struct TVDetails: Decodable {
    let genres: [TVGenres]
}

struct TVGenres: Decodable {
    let name: String?
}

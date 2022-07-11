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
    let title: String
    let poster_path: String?
    let overview: String?
    let vote_average: Double?
    let id: Int?
}



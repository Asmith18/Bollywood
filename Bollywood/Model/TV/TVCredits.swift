//
//  TVCredits.swift
//  Bollywood
//
//  Created by adam smith on 8/27/22.
//

import Foundation

struct TVCredits: Decodable {
    let cast: [TVCast]
    let crew: [TVCrew]
}

struct TVCast: Decodable {
    let name: String?
    let profile_path: String?
    let character: String?
}

struct TVCrew: Decodable {
    let name: String?
    let profile_path: String?
}

//
//  Seasons.swift
//  Bollywood
//
//  Created by adam smith on 8/3/22.
//

import Foundation

struct Seasons: Decodable {
    let episodes: [Episodes]
}

struct Episodes: Decodable {
    enum codingKeys: String, CodingKey {
        case air_date = "airDate"
        case episode_number = "episodeNumber"
        case season_number = "seasonNumber"
        case guest_stars = "guaestStars"
    }
    let air_date: String?
    let episode_number: Int?
    let name: String?
    let overview: String?
    let season_number: Int?
    let guest_stars: [Actors]
}

struct Actors: Decodable {
    enum codingKeys: String, CodingKey {
        case profile_path = "profileImage"
    }
    let character: String?
    let name: String?
    let profile_path: String?
}

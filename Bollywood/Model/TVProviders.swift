//
//  TVProviders.swift
//  Bollywood
//
//  Created by adam smith on 7/29/22.
//

import Foundation

struct TVProviders: Decodable {
    let results: TVResults
}

struct TVResults: Decodable {
    let US: USResults
}

struct USResults: Decodable {
    let flatrate: [Flatrate]
}

struct Flatrate: Decodable {
    let logo_path: String?
    let provider_name: String?
}



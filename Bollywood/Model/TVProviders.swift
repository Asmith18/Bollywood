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
    let US: USTVResults
}

struct USTVResults: Decodable {
    let link: String?
    let free: [FreeResults]
}

struct FreeResults: Decodable {
    let logo_path: String?
    let provider_name: String
}



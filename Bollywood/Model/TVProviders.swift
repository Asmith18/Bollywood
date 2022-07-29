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
    let unitedStates: UnitedStates
}

struct UnitedStates: Decodable {
    let free: FreeResults
}

struct FreeResults: Decodable {
    let logo_path: String?
    let provider_name: String
}



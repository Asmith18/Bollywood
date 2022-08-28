//
//  Providers.swift
//  Bollywood
//
//  Created by adam smith on 7/29/22.
//

import Foundation

struct MovieProviders: Decodable {
    let results: ProviderResults
}

struct ProviderResults: Decodable {
    let US: USMovieResults
}

struct USMovieResults: Decodable {
    let link: String?
    let rent: [RentResults]
    let buy: [BuyResults]
    let flatrate: FlatrateResults
}

struct RentResults: Decodable {
    let logo_path: String?
    let provider_name: String?
}

struct BuyResults: Decodable {
    let logo_path: String?
    let provider_name: String?
}

struct FlatrateResults: Decodable {
    let logo_path: String?
    let provider_name: String?
}


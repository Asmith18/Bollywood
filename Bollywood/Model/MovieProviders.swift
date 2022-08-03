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
}

struct RentResults: Decodable {
    let logo_path: String?
    let provider_name: String?
}

struct BuyResults: Decodable {
    let logo_path: String?
    let provider_name: String?
}


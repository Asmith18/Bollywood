//
//  Providers.swift
//  Bollywood
//
//  Created by adam smith on 7/29/22.
//

import Foundation

struct MovieProviders: Decodable {
    let results: Results
}

struct Results: Decodable {
    let providerResults: ProviderResults
}

struct ProviderResults: Decodable {
    let link: String?
    let rent: [Rent]
}

struct Rent: Decodable {
    let logo_path: String?
    let provider_name: String?
}


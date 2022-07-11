//
//  WebView.swift
//  Bollywood
//
//  Created by adam smith on 6/29/22.
//

import Foundation

struct WebView: Decodable {
    let results: [WebViewResults]
}

struct WebViewResults: Decodable {
    let key: String
    let type: String
}

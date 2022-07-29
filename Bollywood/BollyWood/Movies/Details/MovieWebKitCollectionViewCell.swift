//
//  WebKitCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 7/29/22.
//

import UIKit
import WebKit

class MovieWebKitCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieTrailer: WKWebView!
    
    func getVideo(results: WebViewResults) {
        guard let vidCode = results.key else { return }
        let vidCodeBaseURLString = "https://www.youtube.com"
        guard let baseURL = URL(string: vidCodeBaseURLString) else { return }
        
        var urlcomponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlcomponents?.path = "/embed/\(vidCode)"
        let finalURL = urlcomponents?.url
        movieTrailer.load(URLRequest(url: finalURL!))
    }
}

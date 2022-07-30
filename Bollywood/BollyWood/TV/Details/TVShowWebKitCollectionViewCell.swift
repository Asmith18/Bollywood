//
//  TVShowWebKitCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 7/30/22.
//

import UIKit
import WebKit

class TVShowWebKitCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var showWebView: WKWebView!
    
    
    
    
    //    func getVideo() {
    //        if viewModel.tvShow?.id != nil {
    //            guard let vidCode = viewModel.results.filter({ $0.type == "Trailer"}).first?.key else { return }
    //            let vidCodeBaseURLString = "https://www.youtube.com"
    //            guard let baseURL = URL(string: vidCodeBaseURLString) else { return }
    //
    //            var urlcomponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
    //            urlcomponents?.path = "/embed/\(vidCode)"
    //            let finalURL = urlcomponents?.url
    //            tvShowWebView.load(URLRequest(url: finalURL!))
    //        } else {
    //            print("no data")
    //        }
    //    }
}

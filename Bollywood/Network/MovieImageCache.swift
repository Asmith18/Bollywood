//
//  ImageCache.swift
//  Bollywood
//
//  Created by adam smith on 1/31/23.
//

import Foundation
import UIKit

fileprivate var imageCache = NSCache<NSString, UIImage>()

class MovieImageCache: UIImageView, BollywoodAPI {
    
    private var baseURLSting = "https://image.tmdb.org/t/p/original"
    
    func setImage(using url: String?) {
        guard let url = URL(string: baseURLSting + (url ?? "")) else { return }
        if let cacheImage = imageCache.object(forKey: url.path as NSString) {
            self.image = cacheImage
            return
        }
        perform(URLRequest(url: url)) { [weak self] result in
            DispatchQueue.main.async {
                guard let data = try? result.get() else { return }
                self?.image = UIImage(data: data)
                imageCache.setObject(UIImage(data: data)!, forKey: url.path as NSString)
            }
        }
    }
}

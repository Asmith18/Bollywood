//
//  ImageCache.swift
//  Bollywood
//
//  Created by adam smith on 10/12/22.
//

import Foundation
import UIKit.UIImage

class ImageCache {
    static let shared = ImageCache()
    var cache = NSCache<NSData, UIImage>()
}

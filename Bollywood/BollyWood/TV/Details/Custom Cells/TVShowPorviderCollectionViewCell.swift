//
//  TVShowPorviderCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 7/30/22.
//

import UIKit

class TVShowPorviderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var showProviderImageView: MovieImageCache!
    
    override func prepareForReuse() {
        showProviderImageView.image = nil
    }
    
    func makeRounded() {
        showProviderImageView.clipsToBounds = true
        showProviderImageView.layer.cornerRadius = showProviderImageView.frame.height/2
    }
    
    func setup(with free: Flatrate) {
        
        if free.logo_path != nil {
            showProviderImageView.setImage(using: free.logo_path)
        } else {
            showProviderImageView.image = UIImage(named: "noImage")
        }
        makeRounded()
    }
}

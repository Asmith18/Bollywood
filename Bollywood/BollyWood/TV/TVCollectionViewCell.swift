//
//  TVCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 6/27/22.
//

import UIKit

class TVCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tvImageView: MovieImageCache!
    @IBOutlet weak var tvTextLabel: UILabel!
    
    override func prepareForReuse() {
        tvImageView.image = nil
        tvTextLabel.text = nil
    }
    
    func setup(with tv: TVShows) {
        tvTextLabel.text = tv.name
        tvImageView.setImage(using: tv.poster_path)
    }
}

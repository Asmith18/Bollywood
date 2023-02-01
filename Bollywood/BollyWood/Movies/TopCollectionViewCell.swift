//
//  TopCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 5/17/22.
//

import UIKit

class TopCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var topMovieImageView: MovieImageCache!
    @IBOutlet weak var topTitleTextLabel: UILabel!
    
    override func prepareForReuse() {
        topMovieImageView.image = nil
        topTitleTextLabel.text = nil
    }
    
    func setup(with movie: Movies) {
        topTitleTextLabel.text = movie.title
        topMovieImageView.setImage(using: movie.poster_path)
    }
}

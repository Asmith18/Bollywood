//
//  MovieGenreCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 8/3/22.
//

import UIKit

class MovieGenreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieGenreTextLabel: UILabel!
    @IBOutlet weak var genreView: UIView!
    
    func setup(with genre: MovieGenres) {
        movieGenreTextLabel.text = genre.name
        genreView.layer.cornerRadius = 25
    }
}

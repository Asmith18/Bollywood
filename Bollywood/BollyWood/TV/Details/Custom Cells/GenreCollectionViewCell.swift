//
//  GenreCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 8/3/22.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var genreNameTextLabel: UILabel!
    @IBOutlet weak var genreView: UIView!
    
    func setup(with genre: TVGenres) {
        genreNameTextLabel.text = genre.name
        genreView.layer.cornerRadius = 25
    }
}

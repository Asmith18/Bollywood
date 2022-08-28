//
//  GenreCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 8/3/22.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var genreNameTextLabel: UILabel!
    
    func setup(with genre: TVGenres) {
        genreNameTextLabel.text = genre.name
    }
}

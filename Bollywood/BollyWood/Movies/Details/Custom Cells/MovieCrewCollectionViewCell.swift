//
//  MovieCrewCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 8/3/22.
//

import UIKit

class MovieCrewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieCrewImageView: MovieImageCache!
    @IBOutlet weak var movieCrewnameTextLabel: UILabel!
    
    override func prepareForReuse() {
        movieCrewImageView.image = nil
        movieCrewnameTextLabel.text = nil
    }
    
    func makeRounded() {
        movieCrewImageView.layer.cornerRadius = movieCrewImageView.frame.size.width / 2
        movieCrewImageView.clipsToBounds = true
    }
    
    func setup(with crew: MovieCrew) {
        
        if crew.name != nil {
            movieCrewnameTextLabel.text = crew.name
        } else {
            movieCrewnameTextLabel.text = ""
        }
        
        if crew.profile_path != nil {
            movieCrewImageView.setImage(using: crew.profile_path)
        } else {
            movieCrewImageView.image = UIImage(named: "noImage")
        }
        makeRounded()
    }
}

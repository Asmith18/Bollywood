//
//  MovieActorCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 8/3/22.
//

import UIKit

class MovieActorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieActorImageView: MovieImageCache!
    @IBOutlet weak var movieActorNameTextLabel: UILabel!
    
    override func prepareForReuse() {
        movieActorImageView.image = nil
        movieActorNameTextLabel.text = nil
    }
    
    func makeRounded() {
        movieActorImageView.layer.cornerRadius = movieActorImageView.frame.size.width / 2
        movieActorImageView.clipsToBounds = true
    }
    
    func setup(credits: MovieCast) {
        
        if credits.name != nil {
            movieActorNameTextLabel.text = credits.name
        } else {
            movieActorNameTextLabel.text = ""
        }
        
        if credits.profile_path != nil {
            movieActorImageView.setImage(using: credits.profile_path)
        } else {
            movieActorImageView.image = UIImage(named: "noImage")
        }
        
        makeRounded()
    }
}

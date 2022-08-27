//
//  MovieActorCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 8/3/22.
//

import UIKit

class MovieActorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieActorImageView: UIImageView!
    @IBOutlet weak var movieActorNameTextLabel: UILabel!
    
    
    func setup(credits: MovieCast) {
        fetchImage(with: credits)
        movieActorNameTextLabel.text = credits.name
    }
    
    func fetchImage(with credits: MovieCast) {
        guard let castImage = credits.profile_path else { return }
        BollywoodAPI.fetchImage(from: castImage) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.movieActorImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

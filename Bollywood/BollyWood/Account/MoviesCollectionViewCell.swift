//
//  MyFavoritesCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 6/30/22.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTextLabel: UILabel!
    
    func setup() {
    
    }
    
    func fetchImage(for tv: TVShows) {
        guard let tvImage = tv.poster_path else { return }
        BollywoodAPI.fetchImage(from: tvImage) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.movieImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchImage(for movie: Movies) {
        guard let movieImage = movie.poster_path else { return }
        BollywoodAPI.fetchImage(from: movieImage) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.movieImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

//
//  MyFavoritesCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 6/30/22.
//

import UIKit

class MyFavoritesCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var posterNameTextLabel: UILabel!
    
    func setup() {
    
    }
    
    func fetchImage(for tv: TVShows) {
        guard let tvImage = tv.poster_path else { return }
        BollywoodAPI.fetchImage(from: tvImage) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.posterImageView.image = image
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
                    self.posterImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

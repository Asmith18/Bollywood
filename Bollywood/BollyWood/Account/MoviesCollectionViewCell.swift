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
    
    
    func updateViews() {
        
    }
    
    func fetchImage(for movie: Movies) {
        guard let movieImage = movie.poster_path else { return }
        BollywoodAPI.fetchImage(from: movieImage) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.movieImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

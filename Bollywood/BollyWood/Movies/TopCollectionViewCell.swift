//
//  TopCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 5/17/22.
//

import UIKit

class TopCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var topMovieImageView: UIImageView!
    @IBOutlet weak var topTitleTextLabel: UILabel!
    
    override func prepareForReuse() {
        topMovieImageView.image = nil
        topTitleTextLabel.text = nil
    }
    
    func setup(with movie: Movies) {
        topTitleTextLabel.text = movie.title
        fetchImage(for: movie)
    }
    
    
    func fetchImage(for movie: Movies) {
        guard let image = movie.poster_path else { return }
//        topMovieImageView.fetchImage(from: image)
        BollywoodAPI.fetchImage(from: image) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.topMovieImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

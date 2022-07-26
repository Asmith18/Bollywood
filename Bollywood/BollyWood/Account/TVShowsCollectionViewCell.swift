//
//  TVShowsCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 7/26/22.
//

import UIKit

class TVShowsCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var tvImageView: UIImageView!
    @IBOutlet weak var tvTextLabel: UILabel!
    
    func fetchImage(for tv: TVShows) {
        guard let tvImage = tv.poster_path else { return }
        BollywoodAPI.fetchImage(from: tvImage) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.tvImageView.image = image
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
                    self.tvImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

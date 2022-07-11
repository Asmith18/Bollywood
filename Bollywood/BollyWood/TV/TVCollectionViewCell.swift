//
//  TVCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 6/27/22.
//

import UIKit

class TVCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tvImageView: UIImageView!
    @IBOutlet weak var tvTextLabel: UILabel!
    
    
    func setup(with tv: TVShows) {
        tvTextLabel.text = tv.name
        fetchImage(for: tv)
    }
    
    override func prepareForReuse() {
        tvImageView.image = nil
        tvTextLabel.text = nil
    }
    
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
}

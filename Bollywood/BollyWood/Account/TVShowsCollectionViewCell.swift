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
    
    func updateViews(account: Account) {
        
    }
    
    func fetchImage(for tv: TVShows) {
        guard let tvImage = tv.poster_path else { return }
        BollywoodAPI.fetchImage(from: tvImage) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.tvImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

//
//  TVShowPorviderCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 7/30/22.
//

import UIKit

class TVShowPorviderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var showProviderImageView: UIImageView!
    
    override func prepareForReuse() {
        showProviderImageView.image = nil
    }
    
    func setup(with free: Flatrate) {
        
        if free.logo_path != nil {
            fetchImage(free: free)
        } else {
            showProviderImageView.image = UIImage(named: "noImage")
        }
        
        makeRounded()
    }
    
    func makeRounded() {
        showProviderImageView.clipsToBounds = true
        showProviderImageView.layer.cornerRadius = showProviderImageView.frame.height/2
    }
    
    
    func fetchImage(free: Flatrate) {
        guard let freeImage = free.logo_path else { return }
        BollywoodAPI.fetchImage(from: freeImage) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.showProviderImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

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
        fetchImage(free: free)
        makeRounded()
    }
    
    func makeRounded() {
        showProviderImageView.layer.cornerRadius = showProviderImageView.frame.size.width / 2
        showProviderImageView.clipsToBounds = true
    }
    
    
    func fetchImage(free: Flatrate) {
        guard let freeImage = free.logo_path else { return }
        BollywoodAPI.fetchImage(from: freeImage) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.showProviderImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

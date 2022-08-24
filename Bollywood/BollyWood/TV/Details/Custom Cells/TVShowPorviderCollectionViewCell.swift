//
//  TVShowPorviderCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 7/30/22.
//

import UIKit

class TVShowPorviderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var showProviderImageView: UIImageView!
    @IBOutlet weak var showProviderTextLabel: UILabel!
    
    func setup(with free: Flatrate) {
        showProviderTextLabel.text = free.provider_name
        fetchImage(free: free)
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

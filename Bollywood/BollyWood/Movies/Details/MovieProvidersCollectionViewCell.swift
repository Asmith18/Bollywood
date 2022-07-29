//
//  ProvidersCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 7/29/22.
//

import UIKit
import WebKit

class MovieProvidersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieProviderImageView: UIImageView!
    @IBOutlet weak var movieProviderName: UILabel!
    
    func setup(with rent: Rent) {
        movieProviderName.text = rent.provider_name
        fetchImage(with: rent)
    }
    
    func fetchImage(with rent: Rent) {
        guard let providerImage = rent.logo_path else { return }
        BollywoodAPI.fetchImage(from: providerImage) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.movieProviderImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

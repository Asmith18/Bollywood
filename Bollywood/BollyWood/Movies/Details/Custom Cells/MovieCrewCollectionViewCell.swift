//
//  MovieCrewCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 8/3/22.
//

import UIKit

class MovieCrewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieCrewImageView: UIImageView!
    @IBOutlet weak var movieCrewnameTextLabel: UILabel!
    
    override func prepareForReuse() {
        movieCrewImageView.image = nil
        movieCrewnameTextLabel.text = nil
    }
    
    func setup(with crew: MovieCrew) {
        fetchImage(with: crew)
        movieCrewnameTextLabel.text = crew.name
        makeRounded()
    }
    
    func makeRounded() {
        movieCrewImageView.layer.cornerRadius = movieCrewImageView.frame.size.width / 2
        movieCrewImageView.clipsToBounds = true
    }
    
    
    func fetchImage(with crew: MovieCrew) {
        guard let crewImage = crew.profile_path else { return }
        BollywoodAPI.fetchImage(from: crewImage) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.movieCrewImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

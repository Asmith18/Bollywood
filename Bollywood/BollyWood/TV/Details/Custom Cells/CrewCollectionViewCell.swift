//
//  CrewCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 8/3/22.
//

import UIKit

class CrewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var crewImageView: UIImageView!
    @IBOutlet weak var crewMemberName: UILabel!
    
    override func prepareForReuse() {
        crewImageView.image = nil
        crewMemberName.text = nil
    }
    
    func setup(with crew: TVCrew) {
        crewMemberName.text = crew.name
        fetchImage(crew: crew)
        makeRounded()
    }
    
    func makeRounded() {
        crewImageView.layer.cornerRadius = crewImageView.frame.size.width / 2
        crewImageView.clipsToBounds = true
    }
    
    
    func fetchImage(crew: TVCrew) {
        guard let crewImage = crew.profile_path else { return }
        BollywoodAPI.fetchImage(from: crewImage) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.crewImageView.image = image
                }
            case.failure(let error):
                print(error)
            }
        }
    }
}

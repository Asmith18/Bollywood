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
    
    func setup(with crew: TVCrew) {
        crewMemberName.text = crew.name
        fetchImage(crew: crew)
    }
    
    func fetchImage(crew: TVCrew) {
        guard let crewImage = crew.profile_path else { return }
        BollywoodAPI.fetchImage(from: crewImage) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.crewImageView.image = image
                }
            case.failure(let error):
                print(error)
            }
        }
    }
}

//
//  CrewCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 8/3/22.
//

import UIKit

class CrewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var crewImageView: MovieImageCache!
    @IBOutlet weak var crewMemberName: UILabel!
    
    override func prepareForReuse() {
        crewImageView.image = nil
        crewMemberName.text = nil
    }

    func makeRounded() {
        crewImageView.layer.cornerRadius = crewImageView.frame.size.width / 2
        crewImageView.clipsToBounds = true
    }
    
    func setup(with crew: TVCrew) {
        
        if crew.name != nil {
            crewMemberName.text = crew.name
        } else {
            crewMemberName.text = ""
        }
        
        if crew.profile_path != nil {
            crewImageView.setImage(using: crew.profile_path)
        } else {
            crewImageView.image = UIImage(named: "noImage")
        }
        
        makeRounded()
    }
    
    
    
//    func fetchImage(crew: TVCrew) {
//        guard let crewImage = crew.profile_path else { return }
//        BollywoodAPI.fetchImage(from: crewImage) { [weak self] result in
//            switch result {
//            case .success(let image):
//                DispatchQueue.main.async {
//                    self?.crewImageView.image = image
//                }
//            case.failure(let error):
//                print(error)
//            }
//        }
//    }
}

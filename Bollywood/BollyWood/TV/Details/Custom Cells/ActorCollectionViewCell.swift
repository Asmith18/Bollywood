//
//  ActorCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 8/3/22.
//

import UIKit

class ActorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var actorImgaeView: UIImageView!
    @IBOutlet weak var actorName: UILabel!
    
    override func prepareForReuse() {
        actorImgaeView.image = nil
        actorName.text = nil
    }
    
    func setup(with cast: TVCast) {
        actorName.text = cast.name
        fetchImage(cast: cast)
        makeRounded()
    }
    
    func makeRounded() {
        actorImgaeView.layer.cornerRadius = actorImgaeView.frame.size.width / 2
        actorImgaeView.clipsToBounds = true
    }
    
    
    func fetchImage(cast: TVCast) {
        guard let castImage = cast.profile_path else { return }
        BollywoodAPI.fetchImage(from: castImage) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.actorImgaeView.image = image
                }
            case.failure(let error):
                print(error)
            }
        }
    }
}

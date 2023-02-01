//
//  ActorCollectionViewCell.swift
//  Bollywood
//
//  Created by adam smith on 8/3/22.
//

import UIKit

class ActorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var actorImgaeView: MovieImageCache!
    @IBOutlet weak var actorName: UILabel!
    
    override func prepareForReuse() {
        actorImgaeView.image = nil
        actorName.text = nil
    }
    
    func makeRounded() {
        actorImgaeView.layer.cornerRadius = actorImgaeView.frame.size.width / 2
        actorImgaeView.clipsToBounds = true
    }
    
    func setup(with cast: TVCast) {
        
        if cast.name != nil {
            actorName.text = cast.name
        } else {
            actorName.text = ""
        }
        
        if cast.profile_path != nil {
            actorImgaeView.setImage(using: cast.profile_path)
        } else {
            actorImgaeView.image = UIImage(named: "noImage")
        }
        
        makeRounded()
    }
    
}

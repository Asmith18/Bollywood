//
//  Account.swift
//  Bollywood
//
//  Created by adam smith on 6/30/22.
//

import Foundation
import UIKit

class Account {
    
    let profileImage: UIImage
    let profileName: String
    let favPoster: UIImage
    let favTitle: String
    
    init(profileImage: UIImage = UIImage(), profileName: String, favPoster: UIImage = UIImage(), favTitle: String) {
        self.favPoster = favPoster
        self.favTitle = favTitle
        self.profileName = profileName
        self.profileImage = profileImage
    }
}

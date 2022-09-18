//
//  Account.swift
//  Bollywood
//
//  Created by adam smith on 6/30/22.
//

import Foundation
import UIKit

class Account {
    
    let profileName: String
    let profileImage: UIImage
    let favImage: UIImage
    let favTitle: String
    let favoriteObjects: Bool
    
    init(profileName: String, profileImage: UIImage, favImage: UIImage, favTitle: String, favoriteObjects: Bool) {
        self.profileName = profileName
        self.profileImage = profileImage
        self.favImage = favImage
        self.favTitle = favTitle
        self.favoriteObjects = favoriteObjects
    }
}

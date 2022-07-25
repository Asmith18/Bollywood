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
    let favoriteObjects: Bool
    
    init(profileImage: UIImage = UIImage(), profileName: String, favoriteObjects: Bool = false) {
        self.profileName = profileName
        self.profileImage = profileImage
        self.favoriteObjects = favoriteObjects
    }
}

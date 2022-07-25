//
//  AccountViewModel.swift
//  Bollywood
//
//  Created by adam smith on 6/30/22.
//

import Foundation

protocol AccountViewModelDelegate: AccountViewController {
    func accountHasData()
}

class AccountViewModel {
    
    var account: Account?
    var myFavorites: [String] = []
    weak var delegate: AccountViewModelDelegate?
    
    init(delegate: AccountViewModelDelegate) {
        self.delegate = delegate
    }
}

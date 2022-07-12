//
//  TVViewModel.swift
//  Bollywood
//
//  Created by adam smith on 6/27/22.
//

import Foundation

protocol TVShowsViewModelDelegate: TVShowViewController {
    func tvShowHasData()
    func searchTermHasData()
}

class TVShowsViewModel {
    
    var results: [TVShows] = []
    weak var delegate: TVShowsViewModelDelegate?
    
    init(delegate:TVShowsViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchPopular() {
        BollywoodAPI.fetchPopularTV { result in
            switch result {
            case .success(let tvData):
                self.results = tvData.results
                self.delegate?.tvShowHasData()
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func searchTVShow(searchTerm: String) {
        BollywoodAPI.searchTVShow(with: searchTerm) { result in
            switch result {
            case .success(let search):
                self.results = search.results
                self.delegate?.searchTermHasData()
            case.failure(let error):
                print(error)
            }
        }
    }
}

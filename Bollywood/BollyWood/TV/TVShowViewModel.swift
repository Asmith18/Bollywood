//
//  TVViewModel.swift
//  Bollywood
//
//  Created by adam smith on 6/27/22.
//

import Foundation

protocol TVShowsViewModelDelegate: TVShowViewController {
    func searchTermHasData()
}

class TVShowsViewModel {
    
    var results: [TVShows] = []
    weak var delegate: TVShowsViewModelDelegate?
    
    init(delegate:TVShowsViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchPopular() {
        BollywoodAPI.fetchPopularTV { [weak self] result in
            switch result {
            case .success(let tvData):
                self?.results = tvData.results
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func searchTVShow(searchTerm: String) {
        BollywoodAPI.searchTVShow(with: searchTerm) { [weak self] result in
            switch result {
            case .success(let search):
                self?.results = search.results
                self?.delegate?.searchTermHasData()
            case.failure(let error):
                print(error)
            }
        }
    }
}

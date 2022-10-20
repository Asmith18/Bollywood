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
    private let service = TvSearchService()
    
    init(delegate:TVShowsViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchPopular() {
        service.fetchcharacterList(for: .popularTv) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let tvData):
                self?.results = tvData.results
            }
        }
    }
    
    func searchTVShow(searchTerm: String) {
        service.fetchcharacterList(for: .tvPath(searchTerm)) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let tv):
                self?.results = tv.results
                self?.delegate?.searchTermHasData()
            }
        }
    }
}

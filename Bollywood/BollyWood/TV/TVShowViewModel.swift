//
//  TVViewModel.swift
//  Bollywood
//
//  Created by adam smith on 6/27/22.
//

import Foundation

protocol TVShowsViewModelDelegate: TVShowViewController {
    func searchTermHasData()
    func tvListHasData()
}

class TVShowsViewModel {
    
    var results: [TVShows] = []
    weak var delegate: TVShowsViewModelDelegate?
    private let service = TvSearchService()
    
    init(delegate: TVShowsViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchPopular(page: Int) {
        service.fetch(from: .popularTv(page)) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let tvData):
                self?.results.append(contentsOf: tvData.results.filter({$0.origin_country.contains("US")}))
                self?.delegate?.tvListHasData()
            }
        }
    }
    
    func searchTVShow(searchTerm: String) {
        service.fetch(from: .tvPath(searchTerm)) { [weak self] result in
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

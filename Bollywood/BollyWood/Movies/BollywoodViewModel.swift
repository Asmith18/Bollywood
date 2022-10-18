//
//  BollywoodViewModel.swift
//  Bollywood
//
//  Created by adam smith on 5/18/22.
//

import Foundation

protocol BollywoodViewModelDelegate: BollywoodViewController {
    func searchTermHasData()
    func movieListHasData()
}

class BollywoodViewModel {
    
    var results: [Movies] = []
    weak var delegate: BollywoodViewModelDelegate?
    private let service = MovieSearchService()
    
    init(delegate: BollywoodViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchPopular() {
        BollywoodAPI.fetchPopularMovie { [weak self] result in
            switch result {
            case .success(let movieData):
                self?.results = movieData.results
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchMovie(searchTerm: String) {
//        service.fetchcharacterList(for: .movieQuery(searchTerm)) { result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let movie):
//                self.results = movie.results
//                self.delegate?.searchTermHasData()
//            }
//        }
        BollywoodAPI.searchMovie(with: searchTerm) { [weak self] result in
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

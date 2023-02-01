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
    
    func fetchPopular(page: Int) {
        service.fetch(from: .popularMovie(page)) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let movieData):
                self?.results.append(contentsOf: movieData.results)
                self?.delegate?.movieListHasData()
            }
        }
    }
    
    func searchMovie(searchTerm: String) {
        service.fetch(from: .moviePath(searchTerm)) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let movie):
                self?.results = movie.results
                self?.delegate?.searchTermHasData()
            }
        }
    }
}

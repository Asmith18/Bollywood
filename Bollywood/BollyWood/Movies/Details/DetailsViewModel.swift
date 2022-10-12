//
//  DetailsViewModel.swift
//  Bollywood
//
//  Created by adam smith on 6/28/22.
//

import Foundation

protocol DetailsViewModelDelegate: DetailViewController {
    func movieHasData()
    func vidCodeHasData()
    func movieCastHasData()
    func movieCrewHasData()
    func genresHasData()
}

class DetailsViewModel {
    
    var movie: Movies?
    var webView: WebView?
    var results: [WebViewResults] = []
    var rent: [RentResults] = []
    var buy: [BuyResults] = []
    var flatrate: FlatrateResults?
    var favoriteArray = [String]()
    var webViewResults: WebViewResults?
    var movieCast: [MovieCast] = []
    var movieCrew: [MovieCrew] = []
    var genres: [MovieGenres] = []
    weak var delegate: DetailsViewModelDelegate?
    
    init(delegate: DetailsViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchVidCode() {
        guard let movieVideo = movie?.id else { return }
        BollywoodAPI.fetchMovieVideo(for: movieVideo) { [weak self] result in
            switch result {
            case.success(let webView):
                self?.results = webView.results
                self?.delegate?.vidCodeHasData()
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func getMovieCredits() {
        guard let movieId = movie?.id else { return }
        BollywoodAPI.fetchMovieCredits(with: movieId) { [weak self] result in
            switch result {
            case.success(let cast):
                self?.movieCast = cast.cast
                self?.movieCrew = cast.crew
                self?.delegate?.movieCastHasData()
                self?.delegate?.movieCrewHasData()
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func getMovieDetails() {
        guard let movieId = movie?.id else { return }
        BollywoodAPI.fetchMovieDetails(with: movieId) { [weak self] result in
            switch result {
            case .success(let details):
                self?.genres = details.genres
                self?.delegate?.genresHasData()
            case .failure(let error):
                print(error)
            }
        }
    }
}



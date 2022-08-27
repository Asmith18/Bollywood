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
    func movieProviderHasData()
    func movieCastHasData()
}

class DetailsViewModel {
    
    var movie: Movies?
    var webView: WebView?
    var results: [WebViewResults] = []
    var providerResults: [MovieProviders] = []
    var rent: [RentResults] = []
    var buy: [BuyResults] = []
    var flatrate: FlatrateResults?
    var favoriteArray = [String]()
    var webViewResults: WebViewResults?
    var movieCast: [MovieCast] = []
    weak var delegate: DetailsViewModelDelegate?
    
    init(delegate: DetailsViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchVidCode() {
        guard let movieVideo = movie?.id else { return }
        BollywoodAPI.fetchMovieVideo(for: movieVideo) { result in
            switch result {
            case.success(let webView):
                self.results = webView.results
                self.delegate?.vidCodeHasData()
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func getMoviePoviders() {
        guard let movieProvider = movie?.id else { return }
        BollywoodAPI.fetchMovieProviders(with: movieProvider) { result in
            switch result {
            case .success(let provider):
                self.flatrate = provider.results.US.flatrate
                self.delegate?.movieProviderHasData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMovieCast() {
        guard let movieId = movie?.id else { return }
        BollywoodAPI.fetchMovieCast(with: movieId) { result in
            switch result {
            case.success(let cast):
                self.movieCast = cast.cast
            case.failure(let error):
                print(error)
            }
        }
    }
}



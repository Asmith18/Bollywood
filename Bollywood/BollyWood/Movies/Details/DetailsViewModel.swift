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
    private let creditsService = MovieCreditsService()
    private let videoService = VideoService()
    weak var delegate: DetailsViewModelDelegate?
    
    init(delegate: DetailsViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchVidCode() {
        guard let movieId = movie?.id else { return }
        videoService.fetchcharacterList(for: .movieVideos(movieId)) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let webView):
                self?.results = webView.results
                self?.delegate?.vidCodeHasData()
            }
        }
    }
    
    func getMovieCredits() {
        guard let movieId = movie?.id else { return }
        creditsService.fetchcharacterList(for: .movieCredits(movieId)) { [weak self] result in
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



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
    var results: [WebViewResults] = []
    var flatrate: FlatrateResults?
    var movieCast: [MovieCast] = []
    var movieCrew: [MovieCrew] = []
    var genres: [MovieGenres] = []
    private let creditsService = MovieCreditsService()
    private let videoService = VideoService()
    private let genreService = MovieGenreService()
    weak var delegate: DetailsViewModelDelegate?
    
    init(delegate: DetailsViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchVidCode() {
        guard let movieId = movie?.id else { return }
        videoService.fetch(from: .movieVideos(movieId)) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let webView):
                self?.results = webView.results.filter({$0.type == "Trailer"})
                self?.delegate?.vidCodeHasData()
            }
        }
    }
    
    func getMovieCredits() {
        guard let movieId = movie?.id else { return }
        creditsService.fetch(from: .movieCredits(movieId)) { [weak self] result in
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
        genreService.fetch(from: .movieGenre(movieId)) { [weak self] result in
            switch result  {
            case .failure(let error):
                print(error)
            case .success(let details):
                self?.genres = details.genres
                self?.delegate?.genresHasData()
            }
        }
    }
}



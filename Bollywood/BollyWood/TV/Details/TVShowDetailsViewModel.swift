//
//  TVShowDetailsViewModel.swift
//  Bollywood
//
//  Created by adam smith on 6/28/22.
//

import Foundation

protocol TVShowDetailsViewModelDelegate: TVShowDetailsViewController {
    func showHasData()
    func vidCodeHasData()
    func tvShowproviderHasData()
    func tvCastHasData()
    func tvCrewHasData()
    func tvGenresHasData()
}

class TVShowDetailsViewModel {
    
    //MARK: - Properties
    var tvShow: TVShows?
    var webView: WebView?
    var results: [WebViewResults] = []
    var flatrate: [Flatrate] = []
    var tvCast: [TVCast] = []
    var tvCrew: [TVCrew] = []
    var genres: [TVGenres] = []
    var webViewResults: WebViewResults?
    private let providerService = TVProviderService()
    private let creditsService = TVCreditsService()
    private let videoService = VideoService()
    private let genreService = TVGenreService()
    weak var delegate: TVShowDetailsViewModelDelegate?
    
    init(delegate: TVShowDetailsViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchVidCode() {
        guard let tvId = tvShow?.id else { return }
        videoService.fetchcharacterList(for: .tvVideos(tvId)) { [weak self] result in
            switch result {
            case .success(let webView):
                self?.results =  webView.results.filter({$0.type == "Trailer"})
                self?.delegate?.vidCodeHasData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTVProviders() {
        guard let tvProvider = tvShow?.id else { return }
        providerService.fetchcharacterList(for: .tvProvider(tvProvider)) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let provider):
                self?.flatrate = provider.results.US.flatrate
                self?.delegate?.tvShowproviderHasData()
            }
        }
    }
    
    func getTVCredits() {
        guard let tvId = tvShow?.id else { return }
        creditsService.fetchcharacterList(for: .tvCredits(tvId)) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let credits):
                self.tvCast = credits.cast
                self.tvCrew = credits.crew
                self.delegate?.tvCastHasData()
                self.delegate?.tvCrewHasData()
            }
        }
    }
    
    func getTVDetails() {
        guard let tvId = tvShow?.id else { return }
        genreService.fetchcharacterList(for: .tvGenre(tvId)) { [weak self] result in
            switch result {
            case .success(let details):
                self?.genres = details.genres
                self?.delegate?.tvGenresHasData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

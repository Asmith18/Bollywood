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
    weak var delegate: TVShowDetailsViewModelDelegate?
    
    init(delegate: TVShowDetailsViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchVidCode() {
        guard let tvVideo = tvShow?.id else { return }
        BollywoodAPI.fetchTvVideo(for: tvVideo) { [weak self] result in
            switch result {
            case.success(let webView):
                self?.results = webView.results
                self?.delegate?.vidCodeHasData()
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func getTVProviders() {
        guard let tvProvider = tvShow?.id else { return }
        BollywoodAPI.fetchTVProviders(with: tvProvider) { [weak self] result in
            switch result {
            case .success(let provider):
                self?.flatrate = provider.results.US.flatrate
                self?.delegate?.tvShowproviderHasData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTVCredits() {
        guard let tvId = tvShow?.id else { return }
        BollywoodAPI.fetchTvCredits(with: tvId) { [weak self] result in
            switch result {
            case.success(let cast):
                self?.tvCast = cast.cast
                self?.tvCrew = cast.crew
                self?.delegate?.tvCastHasData()
                self?.delegate?.tvCrewHasData()
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func getTVDetails() {
        guard let tvId = tvShow?.id else { return }
        BollywoodAPI.fetchTvDetails(with: tvId) { [weak self] result in
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

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
}

class TVShowDetailsViewModel {
    
//MARK: - Properties
    var tvShow: TVShows?
    var webView: WebView?
    var results: [WebViewResults] = []
    var flatrate: [Flatrate] = []
    var tvCast: [TVCast] = []
    var webViewResults: WebViewResults?
    weak var delegate: TVShowDetailsViewModelDelegate?
    
    init(delegate: TVShowDetailsViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchVidCode() {
        guard let tvVideo = tvShow?.id else { return }
        BollywoodAPI.fetchTvVideo(for: tvVideo) { result in
            switch result {
            case.success(let webView):
                self.results = webView.results
                self.delegate?.vidCodeHasData()
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func getTVProviders() {
        guard let tvProvider = tvShow?.id else { return }
        BollywoodAPI.fetchTVProviders(with: tvProvider) { result in
            switch result {
            case .success(let provider):
                self.flatrate = provider.results.US.flatrate
                self.delegate?.tvShowproviderHasData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTVCast() {
        guard let tvId = tvShow?.id else { return }
        BollywoodAPI.fetchTvCast(with: tvId) { result in
            switch result {
            case.success(let cast):
                self.tvCast = cast.cast
            case.failure(let error):
                print(error)
            }
        }
    }
}

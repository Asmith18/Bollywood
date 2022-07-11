//
//  TVShowDetailsViewController.swift
//  Bollywood
//
//  Created by adam smith on 6/28/22.
//

import UIKit
import WebKit

class TVShowDetailsViewController: UIViewController {
     
    var viewModel: TVShowDetailsViewModel!
    
    //MARK: - Outlets
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var showNameTextlabel: UILabel!
    @IBOutlet weak var showDateTextLabel: UILabel!
    @IBOutlet weak var showRatingTextLabel: UILabel!
    @IBOutlet weak var showDescriptionTextView: UITextView!
    @IBOutlet weak var tvShowWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        viewModel.fetchVidCode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func getVideo() {
        guard let vidCode = viewModel.results.filter({ $0.type == "Trailer"}).first?.key else { return }
        let vidCodeBaseURLString = "https://www.youtube.com"
        guard let baseURL = URL(string: vidCodeBaseURLString) else { return }
        
        var urlcomponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlcomponents?.path = "/embed/\(vidCode)"
        let finalURL = urlcomponents?.url
        tvShowWebView.load(URLRequest(url: finalURL!))
    }
    
    func updateViews() {
        fetchImage(for: viewModel)
        showNameTextlabel.text = viewModel.tvShow?.name
        showRatingTextLabel.text = "\(viewModel.tvShow?.vote_average ?? 0) / 10"
        showDescriptionTextView.layer.cornerRadius = 25
        showDescriptionTextView.text = viewModel.tvShow?.overview
    }
    
    func fetchImage(for viewModel: TVShowDetailsViewModel) {
        guard let tvImage = viewModel.tvShow?.poster_path else { return }
        BollywoodAPI.fetchImage(from: tvImage) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.showImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension TVShowDetailsViewController: TVShowDetailsViewModelDelegate {
    func vidCodeHasData() {
        DispatchQueue.main.async {
            self.getVideo()
        }
    }
    
    func showHasData() {
        updateViews()
    }
}

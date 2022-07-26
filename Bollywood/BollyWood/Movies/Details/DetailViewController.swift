//
//  DetailViewController.swift
//  Bollywood
//
//  Created by adam smith on 5/21/22.
//

import UIKit
import WebKit
import FirebaseAuth

class DetailViewController: UIViewController {
    
    var viewModel: DetailsViewModel!
    var isFavMovie = UserDefaults.standard.bool(forKey: "isFavMovie")

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameTextLabel: UILabel!
    @IBOutlet weak var movieDateTextLabel: UILabel!
    @IBOutlet weak var movieRatingTextLabel: UILabel!
    @IBOutlet weak var movieDescriptionTextField: UITextView!
    @IBOutlet weak var movieTrailerWebView: WKWebView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
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
        movieTrailerWebView.load(URLRequest(url: finalURL!))
    }
    
    func updateViews() {
        movieRatingTextLabel.text = "\(viewModel.movie?.vote_average ?? 0) / 10"
        movieDescriptionTextField.layer.cornerRadius = 25
        fetchImage(for: viewModel)
        movieNameTextLabel.text = viewModel.movie?.title
        movieDescriptionTextField.text = viewModel.movie?.overview
    }
    
    func fetchImage(for viewModel: DetailsViewModel) {
        guard let tvImage = viewModel.movie?.poster_path else { return }
        BollywoodAPI.fetchImage(from: tvImage) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.movieImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        if isFavMovie {
            favoriteButton.image = UIImage(systemName: "star")
        } else {
            favoriteButton.image = UIImage(systemName: "star.fill")
        }
        isFavMovie = !isFavMovie
        UserDefaults.standard.set(isFavMovie, forKey: "isFavMovie")
        UserDefaults.standard.synchronize()
    }
}

extension DetailViewController: DetailsViewModelDelegate {
    func vidCodeHasData() {
        DispatchQueue.main.async {
            self.getVideo()
        }
    }
    
    func movieHasData() {
    }
}

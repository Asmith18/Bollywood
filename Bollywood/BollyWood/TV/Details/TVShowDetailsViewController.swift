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
    @IBOutlet weak var providerCollectionView: UICollectionView!
    @IBOutlet weak var trailerCollectionView: UICollectionView!
    @IBOutlet weak var actorCollectionView: UICollectionView!
    @IBOutlet weak var crewCollectionView: UICollectionView!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        updateViews()
        fetchEndpoint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupCollectionView() {
        providerCollectionView.dataSource = self
        providerCollectionView.delegate = self
        trailerCollectionView.dataSource = self
        trailerCollectionView.delegate = self
        actorCollectionView.dataSource = self
        actorCollectionView.delegate = self
        crewCollectionView.dataSource = self
        crewCollectionView.delegate = self
        genreCollectionView.dataSource = self
        genreCollectionView.delegate = self
    }
    
    func fetchEndpoint() {
        viewModel.fetchVidCode()
        viewModel.getTVProviders()
        viewModel.getTVCredits()
        viewModel.getTVDetails()
    }
    
    func updateViews() {
        fetchImage(for: viewModel)
        showDateTextLabel.text = viewModel.tvShow?.first_air_date
        showNameTextlabel.text = viewModel.tvShow?.name
        showRatingTextLabel.text = "\(viewModel.tvShow?.vote_average ?? 0) / 10"
        providerCollectionView.layer.cornerRadius = 25
        showDescriptionTextView.layer.cornerRadius = 25
        if viewModel.tvShow?.overview != "" {
            showDescriptionTextView.text = viewModel.tvShow?.overview
        } else {
            showDescriptionTextView.text = "No Description Found..."
        }
    }
    
    func fetchImage(for viewModel: TVShowDetailsViewModel) {
        guard let tvImage = viewModel.tvShow?.backdrop_path else { return }
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
    
    func tvGenresHasData() {
        DispatchQueue.main.async {
            self.genreCollectionView.reloadData()
        }
    }
    
    
    func tvCrewHasData() {
        DispatchQueue.main.async {
            self.crewCollectionView.reloadData()
        }
    }
    
    func tvShowproviderHasData() {
        DispatchQueue.main.async {
            self.providerCollectionView.reloadData()
        }
    }
    
    func vidCodeHasData() {
        DispatchQueue.main.async {
            self.trailerCollectionView.reloadData()
        }
    }
    
    func showHasData() {
        updateViews()
    }
    
    func tvCastHasData() {
        DispatchQueue.main.async {
            self.actorCollectionView.reloadData()
        }
    }
}

extension TVShowDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == providerCollectionView.self {
            return viewModel.flatrate.count
        } else if collectionView == trailerCollectionView.self {
            return viewModel.results.count
        } else if collectionView == actorCollectionView.self {
                return viewModel.tvCast.count
        } else if collectionView == crewCollectionView.self {
            if viewModel.tvCrew.isEmpty {
                return 1
            } else {
                return viewModel.tvCrew.count
            }
        } else {
            return viewModel.genres.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == providerCollectionView.self {
            let cell = providerCollectionView.dequeueReusableCell(withReuseIdentifier: "provider", for: indexPath) as! TVShowPorviderCollectionViewCell
            
            let result = viewModel.flatrate[indexPath.row]
            cell.setup(with: result)
            
            return cell
        } else if collectionView == trailerCollectionView.self {
            let cell = trailerCollectionView.dequeueReusableCell(withReuseIdentifier: "trailer", for: indexPath) as! TVShowWebKitCollectionViewCell
            
            let result = viewModel.results[indexPath.row]
            cell.getVideo(results: result)
            
            return cell
        } else if collectionView == actorCollectionView.self {
            let cell = actorCollectionView.dequeueReusableCell(withReuseIdentifier: "actor", for: indexPath) as! ActorCollectionViewCell
            
            let result = viewModel.tvCast[indexPath.row]
            cell.setup(with: result)
            
            return cell
        } else if collectionView == crewCollectionView.self {
            let cell = crewCollectionView.dequeueReusableCell(withReuseIdentifier: "crew", for: indexPath) as! CrewCollectionViewCell
            
            if viewModel.tvCrew.isEmpty {
                cell.crewImageView.image = UIImage(named: "noImage")
            } else {
                let result = viewModel.tvCrew[indexPath.row]
                cell.setup(with: result)
            }
            
            return cell
        } else {
            let cell = genreCollectionView.dequeueReusableCell(withReuseIdentifier: "genre", for: indexPath) as! GenreCollectionViewCell
            
            let result = viewModel.genres[indexPath.row]
            cell.setup(with: result)
            
            return cell
        }
    }
}
